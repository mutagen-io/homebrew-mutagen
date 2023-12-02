class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.17.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.3/mutagen-compose_darwin_arm64_v0.17.3.tar.gz"
      sha256 "8d4bfd24900055ec9e0fcda93e618669e7a265cb8b53104c0c492b6c24141c4f"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.3/mutagen-compose_darwin_amd64_v0.17.3.tar.gz"
      sha256 "6190ae64c093fc567004aeaa2857759dbe93a939a248ad9eced55ce3aadc0d7a"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.3/mutagen-compose_linux_amd64_v0.17.3.tar.gz"
    sha256 "0cbc61bfaab3b56bb1c33e1a2226fc3b5d927eddb3146609a3054becc6c8d7c5"
  end

  depends_on "mutagen-beta"

  conflicts_with "mutagen-compose", :because => "both install `mutagen-compose` binaries"

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
