class Catcat < Formula
  desc "Terminal tower defense with cats"
  homepage "https://github.com/DevinMcDonald/catcat"
  url "https://github.com/DevinMcDonald/catcat/releases/download/v1.3.2/catcat_bundle.zip"
  sha256 "2e31d629a8099d677c58707f9bcc1681c21a177123930936b7fa4f0e740a7550"
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
