class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0/mutagen-compose_darwin_arm64_v0.16.0.tar.gz"
      sha256 "d6d5869b34cfdd82d7e92c7ca86892284792e0a3e7e452deb2221ce05caedacd"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0/mutagen-compose_darwin_amd64_v0.16.0.tar.gz"
      sha256 "6689f30c3683b1e4508516c620937cf9858b3a55264720fbee5cac16fa3d9307"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0/mutagen-compose_linux_amd64_v0.16.0.tar.gz"
    sha256 "d78edd86b154e1f576fa1f546fdccc9e62cf80688168e255713d4b31ffa10beb"
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
