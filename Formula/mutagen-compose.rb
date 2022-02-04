class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.13.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.1/mutagen-compose_darwin_arm64_v0.13.1.tar.gz"
      sha256 "726d12dcc92d7941e8d7080491dcf4df24772a2f98d082f8f2ac60f4c8664ed4"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.1/mutagen-compose_darwin_amd64_v0.13.1.tar.gz"
      sha256 "f7ac509f76f8634466af2a3980596919027479e4fa3100a21404eb8d0410a66a"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.1/mutagen-compose_linux_amd64_v0.13.1.tar.gz"
    sha256 "543f7bfc5ecadfb2a0ad4d9d255b6dd28e3ff90fdb52209aba068664696b52a5"
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
