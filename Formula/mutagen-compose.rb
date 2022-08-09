class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.1/mutagen-compose_darwin_arm64_v0.15.1.tar.gz"
      sha256 "fd3015faf634d1785909510606392ebf74b26ac7ba447b2d8974ccea4d399265"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.1/mutagen-compose_darwin_amd64_v0.15.1.tar.gz"
      sha256 "582a58aa76de23050c5bb63864ae9e249769a7922229ba71efcc374697e0e572"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.1/mutagen-compose_linux_amd64_v0.15.1.tar.gz"
    sha256 "4377d59d52df2b4145608c50952e7be260309edf127f6625dcb43afec0d63aa1"
  end

  depends_on "mutagen"

  conflicts_with "mutagen-compose-beta", :because => "both install `mutagen-compose` binaries"

  def install
    # Install the mutagen-compose binary into the bin directory.
    bin.install "mutagen-compose"
  end

  def caveats
    <<~EOS
      Mutagen Compose is still nascent software. Please report issues that you
      encounter on the Mutagen Compose issue tracker:

      https://github.com/mutagen-io/mutagen-compose/issues
    EOS
  end

  test do
    system bin/"mutagen-compose", "version"
  end
end
