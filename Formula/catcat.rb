class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  version "4.6.7"
  license "MIT" # Update if your project uses a different license

  on_macos do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.7/catcat-macos-arm64.zip"
      sha256 "31eec725be10399e26603362c32dc00eb984ec13e5f3e61142ee89f8ef0ab237"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.7/catcat-macos-x86_64.zip"
      sha256 "89eba63e6ecbd25cc415e8dfcf4f71df1088581fb5a932cbf4437fe220cb9e19"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.7/catcat-linux-arm64.zip"
      sha256 "42b500807c1ba33a7f05c84edd948508626ddcd10559f5755adf81e65bc29cc0"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.7/catcat-linux-x86_64.zip"
      sha256 "272d811bb91d7c2c76039e9b97e83d1856f20836cbbd93123d895fa686715eef"
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
