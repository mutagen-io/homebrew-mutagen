class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.16.0-beta2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0-beta2/mutagen-compose_darwin_arm64_v0.16.0-beta2.tar.gz"
      sha256 "25ffc8dd95f0304d76cc83468a2ecceac70edd55ee555c529299d540bef27af1"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0-beta2/mutagen-compose_darwin_amd64_v0.16.0-beta2.tar.gz"
      sha256 "2905ee0f518866654ef8bb7d51ebf4f022e5790f73a5c3db722c4ca87adf9101"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0-beta2/mutagen-compose_linux_amd64_v0.16.0-beta2.tar.gz"
    sha256 "f847053acb2fd4633ecbcabd7255a75f7bef3d99d7f3054af918ec5ea2a97516"
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
