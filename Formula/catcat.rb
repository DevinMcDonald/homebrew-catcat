class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  version "4.6.0"
  license "MIT" # Update if your project uses a different license

  on_macos do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.0/catcat-macos-arm64.zip"
      sha256 "e14129e0d77e7020dc831680c235b4ed0af2d5aa8750ef9ab7e02a84b95d1192"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.0/catcat-macos-x86_64.zip"
      sha256 "3df7aaf7d299b76f5dfe5c273b6dec5289369cdfed15df51f00a3f7e467c39d9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.0/catcat-linux-arm64.zip"
      sha256 "68b0ba952baad2e10162fa7b6414cb5b9c26c8475207961bd1df7aef07f3e88a"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.0/catcat-linux-x86_64.zip"
      sha256 "43ef9ddf47b8336448c61b90876d4cab5f065cd24b7760146833acf5a18590e8"
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
