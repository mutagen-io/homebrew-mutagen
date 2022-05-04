class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.14.0-1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-1/mutagen-compose_darwin_arm64_v0.14.0.tar.gz"
      sha256 "2b754147a739d83a7f5f2246b12ce64379dbec1a2f4ce329fc3d512cee051be6"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-1/mutagen-compose_darwin_amd64_v0.14.0.tar.gz"
      sha256 "6acec150b23b26163272e00a23d1364dd5e2ae9f845ab99aeabd690cecf5652e"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-1/mutagen-compose_linux_amd64_v0.14.0.tar.gz"
    sha256 "752d7f22444fcd1d8fdad022f02b743b0b379eaeabbd4948695a60246fdddb26"
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
