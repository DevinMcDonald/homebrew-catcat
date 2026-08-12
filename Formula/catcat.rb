class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  version "4.6.5"
  license "MIT" # Update if your project uses a different license

  on_macos do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.5/catcat-macos-arm64.zip"
      sha256 "883a15b850d368fc24ededb056ef191656977f22c93bbc249e3fcb6b2531107c"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.5/catcat-macos-x86_64.zip"
      sha256 "9d9a38178f3b26489ac91792e0aa0a688bead9dbbb20bf96ec8e4b81ffaf2db8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.5/catcat-linux-arm64.zip"
      sha256 "e1358e655d16c562731093825526f91472da745eb555ca5b0db7f196f62f2a93"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.5/catcat-linux-x86_64.zip"
      sha256 "8912fe8e958795744e6cf1bea2be897a1ad2877f0a1469a016fd5002a4f2e8ec"
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
