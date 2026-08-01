class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  url "https://github.com/DevinMcDonald/catcat/releases/download/v1.3.9/catcat_bundle.zip"
  sha256 "d596dfbc33e943fd15b21f764305552d2c9816378932b2db245afd86e9956223"
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
