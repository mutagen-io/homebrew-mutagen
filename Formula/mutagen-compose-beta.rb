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
  version "0.13.0-beta3-2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta3-2/mutagen-compose_darwin_arm64_v0.13.0-beta3.tar.gz"
      sha256 "13d589adcf1409a17797f0a3431c7cd72e5a04e75197a4191294a8d247ba103c"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta3-2/mutagen-compose_darwin_amd64_v0.13.0-beta3.tar.gz"
      sha256 "d8bc238f763ec60a322cd1c4548eb43cfa2e319464bb21e84482b736440218ff"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta3-2/mutagen-compose_linux_amd64_v0.13.0-beta3.tar.gz"
    sha256 "e5bc87313574942c5df4ef66441b9c6aec9e0bb8d743abdbd2aef8986d3e20ae"
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
