class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  version "4.4.5"
  license "MIT" # Update if your project uses a different license

  on_macos do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.4.5/catcat-macos-arm64.zip"
      sha256 "d61101c4cec8cb964d834fb868a5255c3a8706ad5016316b999bed385cacd770"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.4.5/catcat-macos-x86_64.zip"
      sha256 "1e4f8e655b9d46f19388b8dd0048ac2022743c9dad263cbda2c620717443bc60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.4.5/catcat-linux-arm64.zip"
      sha256 "9cfa2f5f453cd183e7fe22cf7918ea7215d1d816fb66860a06e37981b0d89780"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.4.5/catcat-linux-x86_64.zip"
      sha256 "9a317dca12f61de96dc1100bcdc71f120c9dadb1c58e357878a01b091dcdd72c"
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
