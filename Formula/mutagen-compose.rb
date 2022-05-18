class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.14.0-2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-2/mutagen-compose_darwin_arm64_v0.14.0.tar.gz"
      sha256 "5eaf4ab8942e91ec0c41ed5460f564c1a7aa66d3db5e12c8eecbc9498caf3518"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-2/mutagen-compose_darwin_amd64_v0.14.0.tar.gz"
      sha256 "3e3586b9cf7b9632e870739bad109756961646b84a4e61ce2d54492e5833a437"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-2/mutagen-compose_linux_amd64_v0.14.0.tar.gz"
    sha256 "dc60c21d8ea7eecf8a306d9e054cf13df5a216a71662333659064db3425a4c90"
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
