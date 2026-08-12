class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  version "4.6.8"
  license "MIT" # Update if your project uses a different license

  on_macos do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.8/catcat-macos-arm64.zip"
      sha256 "7ba95d3f82c0bc44e6be36f9cd8395b4e9014941404acabec92400a6cb1204d3"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.8/catcat-macos-x86_64.zip"
      sha256 "b3eadfd81c7181e619783b270fc170bd04b58e822f7dbb1880aaed6a438517b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.8/catcat-linux-arm64.zip"
      sha256 "6439a02abdc1ba04329cafb9c7c07155faee4369d8a686a7028b2dc8cca7c582"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.8/catcat-linux-x86_64.zip"
      sha256 "d674c33d9d1b5855f05605f125bcc93cc8588058a2d4556451d22d9894fa6057"
    end
  end

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
