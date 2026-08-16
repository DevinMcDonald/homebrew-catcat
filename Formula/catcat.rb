class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  version "4.6.9"
  license "MIT" # Update if your project uses a different license

  on_macos do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.9/catcat-macos-arm64.zip"
      sha256 "afea791109a2839ba446af6908ffe112115004c6303bb87b44beeef542860724"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.9/catcat-macos-x86_64.zip"
      sha256 "93b3c22248acfad951fbb64211c3afd5daaf9c22cf088bcf74a6e179f7baaf04"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.9/catcat-linux-arm64.zip"
      sha256 "74ae41003f6b9e4550fd686d9a3deae6e31ba40856eb497f7dcd72fcb9b5a89e"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.9/catcat-linux-x86_64.zip"
      sha256 "2c89e21b3caf67e988566e89fbdfd582c1ab2a0f5b49da8cff4bb8106d8c1414"
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
