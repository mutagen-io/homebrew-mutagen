class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.16.0-beta1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0-beta1/mutagen-compose_darwin_arm64_v0.16.0-beta1.tar.gz"
      sha256 "56b60a510744798c2f9daf9b51bcafeb6c336b912c4ffca92d8ffd844672e7dc"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0-beta1/mutagen-compose_darwin_amd64_v0.16.0-beta1.tar.gz"
      sha256 "3e38530fb0004abd55a28126c59859567365587e3c1d243a202bd862434b54f5"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0-beta1/mutagen-compose_linux_amd64_v0.16.0-beta1.tar.gz"
    sha256 "46c512a050df1f4563ff6cdae8a0d5ac5574791f247f4b6bc5c67e338d726fe5"
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
