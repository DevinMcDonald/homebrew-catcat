class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  url "https://github.com/DevinMcDonald/catcat/releases/download/v1.2.0/catcat_bundle.zip"
  sha256 "8c91876f89aecb477549f7a3a5f91c3cf7779e06d5ceb86ea7e3236205e9eda9"
  license "MIT" # Update if your project uses a different license

  def install
    bundle_root = (buildpath/"catcat_bundle").directory? ? buildpath/"catcat_bundle" : buildpath
    libexec.install bundle_root.children
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
