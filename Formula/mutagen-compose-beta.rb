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
  version "0.13.0-beta4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta4/mutagen-compose_darwin_arm64_v0.13.0-beta4.tar.gz"
      sha256 "190ea4cf724c4bcc0f76806dafa359164fa7f9e262fc7a286d96dfee9339d803"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta4/mutagen-compose_darwin_amd64_v0.13.0-beta4.tar.gz"
      sha256 "37e2917d220f71dda8f99ef4fbf4b1079ef4be3ac4437d82387968e76d207961"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta4/mutagen-compose_linux_amd64_v0.13.0-beta4.tar.gz"
    sha256 "3a4d3022c111df48cdd23f4b9a69bff96bcfb37705415641eeab9b1732304ee7"
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
