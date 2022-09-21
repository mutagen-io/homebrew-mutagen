class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.4/mutagen-compose_darwin_arm64_v0.15.4.tar.gz"
      sha256 "184ad48c1a9d96719714eb468332555a1237c32414bd99672b5da606de912aae"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.4/mutagen-compose_darwin_amd64_v0.15.4.tar.gz"
      sha256 "dadce3494749a4e1f8d99f837664590494eb1159f16e1c78a768a70ab4b01755"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.4/mutagen-compose_linux_amd64_v0.15.4.tar.gz"
    sha256 "4237898783c6caf8200c92bec5af78d900243c2acd96d42f8b2d25aac8f246f6"
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
