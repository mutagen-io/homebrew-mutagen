class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0/mutagen-compose_darwin_arm64_v0.13.0.tar.gz"
      sha256 "9aee874e84f9c67cd2a8b056c04f9435f74e7aa6654bb3ace5073dcfea3082b7"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0/mutagen-compose_darwin_amd64_v0.13.0.tar.gz"
      sha256 "fcdfddb56fc93392504750a4ef5729350e9a1180c7ab62c6399bce2e0e4bf08d"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.13.0/mutagen-compose_linux_amd64_v0.13.0.tar.gz"
    sha256 "a695e127a22085d49f8dd779abb371e1137575988e8e2cabedad819063c4c4f0"
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
