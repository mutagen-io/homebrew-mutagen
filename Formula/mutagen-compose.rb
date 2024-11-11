class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.18.0-1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-1/mutagen-compose_darwin_arm64_v0.18.0.tar.gz"
      sha256 "9f1889db2eb3aa3c099b985e8e2f89363653293edd37757b79607599ae11b5ee"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-1/mutagen-compose_darwin_amd64_v0.18.0.tar.gz"
      sha256 "5aeb0140b299f884b80127397b2096e844b148383bdec913caa6446acbfaf45a"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-1/mutagen-compose_linux_amd64_v0.18.0.tar.gz"
    sha256 "955b3e8627f7465e28505d06f1b8af07ecce4b9decb4945755c33a63af84a4ef"
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
