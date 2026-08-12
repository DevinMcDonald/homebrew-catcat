class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  version "4.6.4"
  license "MIT" # Update if your project uses a different license

  on_macos do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.4/catcat-macos-arm64.zip"
      sha256 "0c7c8d8d82752a0b5752e20d1a65d75f1f3e9551db2613e6fe5135fcd62797d7"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.4/catcat-macos-x86_64.zip"
      sha256 "d72fdda1bdedbc8a816ea86c68085723d7917700d94521188f49221e352e9b7b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.4/catcat-linux-arm64.zip"
      sha256 "2df20b3f0dfd507999325714e81c0acd952102d4e11ca40e33b183d64e66c577"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.4/catcat-linux-x86_64.zip"
      sha256 "e407c9c19f48ba2be5be0b05c6bd239e3e89e5e1bb6f298e312d17507bd18ea3"
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
