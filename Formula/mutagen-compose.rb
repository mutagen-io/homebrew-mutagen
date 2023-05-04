class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.17.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.1/mutagen-compose_darwin_arm64_v0.17.1.tar.gz"
      sha256 "590559adc8f0c6d5ffefec05793b3d4d8b5903684d72b35c0c9c1cb7801cd153"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.1/mutagen-compose_darwin_amd64_v0.17.1.tar.gz"
      sha256 "952aed9ae5a2d3c2f09916a91fe3153595097d2226986d1821638179e54152c7"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.1/mutagen-compose_linux_amd64_v0.17.1.tar.gz"
    sha256 "44ca89445e71f7ebc214c72cee7a3ade80cc985fb1123bb12f0074508058fc69"
  end

  depends_on "mutagen"

  conflicts_with "mutagen-compose-beta", :because => "both install `mutagen-compose` binaries"

  def install
    # Generate and install shell completion scripts.
    mkdir "generated" do
      system "../mutagen-compose", "generate",
        "--bash-completion-script=mutagen-compose.bash",
        "--fish-completion-script=mutagen-compose.fish",
        "--zsh-completion-script=_mutagen-compose"
      bash_completion.install "mutagen-compose.bash"
      fish_completion.install "mutagen-compose.fish"
      zsh_completion.install "_mutagen-compose"
    end

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
