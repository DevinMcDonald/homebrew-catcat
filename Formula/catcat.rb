class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  url "https://github.com/DevinMcDonald/catcat/releases/download/v1.3.2/catcat_bundle.zip"
  sha256 "83c417b6df853309457f09bbec188d8e819187c5a6ff34f81965b1ce2840f723"
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
