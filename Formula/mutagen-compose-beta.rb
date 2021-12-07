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
  version "0.13.0-beta3-1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta3-1/mutagen-compose_darwin_arm64_v0.13.0-beta3.tar.gz"
      sha256 "fc6177cabacad2e9f921c08bf6f62c8fb3a6962ed77fdee64e1393bcbbc49d24"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta3-1/mutagen-compose_darwin_amd64_v0.13.0-beta3.tar.gz"
      sha256 "0354c57426cc5c5eee177f2f1a194dcf847ea62099261aac32dc19a2ed727066"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0-beta3-1/mutagen-compose_linux_amd64_v0.13.0-beta3.tar.gz"
    sha256 "4908ccf1ba7d2fb4510130436b90be59e8018852a54584a9afadb54c369b6d10"
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
