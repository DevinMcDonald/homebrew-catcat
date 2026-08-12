class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  version "4.6.1"
  license "MIT" # Update if your project uses a different license

  on_macos do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.1/catcat-macos-arm64.zip"
      sha256 "db1fb36056088658e94c4995bfd7ddf2745dc2d47a18738922b9caef3c74bd02"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.1/catcat-macos-x86_64.zip"
      sha256 "bc7d0904111a334082dfdbab42812812c2df1a47c3d5b55dff41eb61404b3145"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.1/catcat-linux-arm64.zip"
      sha256 "448bc4609bc32514c56ca5299be8e2fd1150c4f9987750c17462f06a6bac6454"
    end
    on_intel do
      url "https://github.com/DevinMcDonald/catcat/releases/download/v4.6.1/catcat-linux-x86_64.zip"
      sha256 "a396e20d8fbc90b72600ab6d7f9b3e8b8cca4e24335ba37304ca877379dd844e"
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
