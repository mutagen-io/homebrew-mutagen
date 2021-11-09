# TODO: This formula isn't particularly idiomatic. It treats the release archive
# as the source bundle and just copies the compiled files from the bundle to
# their destinations. This is necessary at the moment because Mutagen has a
# custom build script that (a) performs time-consuming cross-compilation of
# agent binaries and (b) requires macOS cgo support to build agents that support
# FSEvents. Issue (a) can likely be solved by bottling the compiled binaries,
# but issue (b) doesn't have an elegant solution for Linux systems.
class MutagenComposeBeta < Formula
  desc "Mutagen integration with Docker Compose"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.13.0-beta2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta2/mutagen-compose_darwin_arm64_v0.13.0-beta2.tar.gz"
      sha256 "ee9af7475030f63bf44ba2c0913f34cda45870fd57e90b290492d07705497ee0"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta2/mutagen-compose_darwin_amd64_v0.13.0-beta2.tar.gz"
      sha256 "e480cad8db8aa521c74e15910e2557f96f137c160c5d8911468db3cc521ba091"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta2/mutagen-compose_linux_amd64_v0.13.0-beta2.tar.gz"
    sha256 "028574eb88ce7a09b88c1ea0363e104f82942b627c3db979c3f855806c6ef106"
  end

  depends_on "mutagen-beta"

  def install
    # Install the mutagen-compose binary into the bin directory.
    bin.install "mutagen-compose"
  end

  def caveats
    <<~EOS
      Mutagen Compose is still beta software. Please report issues that you
      encounter on the Mutagen Compose issue tracker:

      https://github.com/mutagen-io/mutagen-compose/issues
    EOS
  end

  test do
    system bin/"mutagen-compose", "version"
  end
end
