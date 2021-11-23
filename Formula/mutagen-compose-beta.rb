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
  version "0.13.0-beta3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta3/mutagen-compose_darwin_arm64_v0.13.0-beta3.tar.gz"
      sha256 "0e4f8d34ddf41522a7659a876c0a1a70f4c76013f5580b44b997edf802e20ba9"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta3/mutagen-compose_darwin_amd64_v0.13.0-beta3.tar.gz"
      sha256 "3651a7105f7d07b6d7ebb495f2b71599b7603d8b7b6352fd9837d0811cb93d67"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta3/mutagen-compose_linux_amd64_v0.13.0-beta3.tar.gz"
    sha256 "1cc3a24470355e30b6f6ed3282f116540b29c1e2cff4c272ef36d0cb6274d0d1"
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
