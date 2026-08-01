class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  url "https://github.com/DevinMcDonald/catcat/releases/download/v1.3.9/catcat_bundle.zip"
  sha256 "4193c94d5362578af08197b0a520a86bebf8288b9a882cdf8cd3ae3ffd75cec2"
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
