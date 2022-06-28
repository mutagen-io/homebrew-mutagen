class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.0-beta3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-beta3/mutagen-compose_darwin_arm64_v0.15.0-beta3.tar.gz"
      sha256 "832caa3421206f3e2ad79c96b82327ccf09c615f81490e5abbaf19fce1225c7c"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-beta3/mutagen-compose_darwin_amd64_v0.15.0-beta3.tar.gz"
      sha256 "3e8637e9c1ef61df39eb956ef85cdcaaef436f0db38ac18bcb3dc84bf25a9487"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-beta3/mutagen-compose_linux_amd64_v0.15.0-beta3.tar.gz"
    sha256 "6007200476a380e010bc980362d436cff8074ae9851cf4e1a1091bbf0ab3cc7f"
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
