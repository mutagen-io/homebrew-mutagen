class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.3/mutagen-compose_darwin_arm64_v0.15.3.tar.gz"
      sha256 "d04262cd3c06e4234423777d02874267967dd6cac32ab8b218689aaf8e17df20"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.3/mutagen-compose_darwin_amd64_v0.15.3.tar.gz"
      sha256 "ed413b19a9a359da9afc260a89d9cb81e20f1ba9368a4f0c6c1aae731e9dfdb8"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.3/mutagen-compose_linux_amd64_v0.15.3.tar.gz"
    sha256 "e08ea66b6203cc6ecc06be75e93bf6fae014e315ea001098ff905e8617da1c3b"
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
