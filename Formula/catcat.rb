class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/YOUR_GITHUB_USERNAME/catcat"
  url "https://github.com/YOUR_GITHUB_USERNAME/catcat/releases/download/v0.0.0/catcat-darwin-arm64.tar.gz"
  sha256 "REPLACE_WITH_SHA256"
  license "MIT" # Update if your project uses a different license

  def install
    libexec.install Dir["*"]
    (bin/"catcat").write <<~EOS
      #!/bin/bash
      cd "#{libexec}"
      exec "./catcat" "$@"
    EOS
    chmod 0555, bin/"catcat"
  end

  test do
    assert_predicate bin/"catcat", :executable?
  end
end
