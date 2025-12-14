#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "fileutils"
require "json"
require "open-uri"
require "pathname"
require "tmpdir"

REPO = "DevinMcDonald/catcat"
ASSET_PRIORITIES = ["catcat_bundle.zip", "catcat.zip"].freeze

def github_headers
  headers = {
    "Accept" => "application/vnd.github+json",
    "User-Agent" => "homebrew-catcat-updater"
  }

  if (token = ENV["GITHUB_TOKEN"])
    headers["Authorization"] = "Bearer #{token}"
  end

  headers
end

def fetch_latest_release
  url = "https://api.github.com/repos/#{REPO}/releases/latest"
  JSON.parse(URI.open(url, github_headers).read)
end

def pick_asset(release)
  assets = release["assets"] || []
  ASSET_PRIORITIES.each do |name|
    asset = assets.find { |a| a["name"] == name }
    return asset if asset
  end

  assets.find { |a| (a["content_type"] || "").include?("zip") } || assets.first
end

def formula_path
  Pathname(__dir__).join("..", "Formula", "catcat.rb").expand_path
end

def current_formula_version(content)
  url = content[/^\s*url\s+"([^"]+)"/, 1]
  return nil unless url

  url[%r{download/v?([^/]+)/}, 1] || url[%r{/v?([^/]+)/[^/]+$}, 1]
end

def download_asset(asset)
  raise "No asset available to download" unless asset

  tmp_dir = Dir.mktmpdir("catcat-download-")
  target = File.join(tmp_dir, asset.fetch("name"))

  begin
    URI.open(asset.fetch("browser_download_url"), github_headers) do |remote|
      File.open(target, "wb") { |f| IO.copy_stream(remote, f) }
    end
  rescue StandardError
    FileUtils.remove_entry(tmp_dir) if Dir.exist?(tmp_dir)
    raise
  end

  [target, tmp_dir]
end

def update_formula(content, url, sha256)
  updated = content.sub(/(^\s*url\s+").*(")/) { "#{$1}#{url}#{$2}" }
  updated = updated.sub(/(^\s*sha256\s+").*(")/) { "#{$1}#{sha256}#{$2}" }

  unless updated.include?(url) && updated.include?(sha256)
    abort("Failed to rewrite formula with new url/sha")
  end

  updated
end

release = fetch_latest_release
latest_tag = release["tag_name"] || abort("Latest release tag_name missing from GitHub response")
latest_version = latest_tag.sub(/\Av/i, "")
asset = pick_asset(release) || abort("No assets found on the latest release")

formula_file = formula_path
content = formula_file.read
current_version = current_formula_version(content)

unless current_version
  abort("Could not determine current formula version from url line")
end

if current_version == latest_version
  puts "catcat is already up to date (#{current_version})."
  exit 0
end

puts "Updating catcat from #{current_version} -> #{latest_version}"

downloaded_asset, tmp_dir = download_asset(asset)
sha256 = Digest::SHA256.file(downloaded_asset).hexdigest
new_content = update_formula(content, asset.fetch("browser_download_url"), sha256)
formula_file.write(new_content)

puts "Updated #{formula_file}"

Dir.chdir(formula_file.dirname.parent) do
  system("git", "add", formula_file.to_s) || abort("git add failed")

  if system("git", "diff", "--cached", "--quiet")
    puts "No changes to commit."
  else
    commit_message = "catcat #{latest_version}"
    system("git", "commit", "-m", commit_message) || abort("git commit failed")

    branch = `git rev-parse --abbrev-ref HEAD`.strip
    system("git", "push", "origin", branch) || abort("git push failed")
    puts "Pushed updates to origin/#{branch}"
  end
ensure
  FileUtils.remove_entry(tmp_dir) if tmp_dir && Dir.exist?(tmp_dir)
end
