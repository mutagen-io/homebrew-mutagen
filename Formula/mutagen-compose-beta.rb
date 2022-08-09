class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.1/mutagen-compose_darwin_arm64_v0.15.1.tar.gz"
      sha256 ""
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.1/mutagen-compose_darwin_amd64_v0.15.1.tar.gz"
      sha256 ""
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.1/mutagen-compose_linux_amd64_v0.15.1.tar.gz"
    sha256 ""
  end

  depends_on "mutagen-beta"

  conflicts_with "mutagen-compose", :because => "both install `mutagen-compose` binaries"

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
