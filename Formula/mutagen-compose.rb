class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.17.0-1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.0-1/mutagen-compose_darwin_arm64_v0.17.0.tar.gz"
      sha256 "4d7cffa7dc81e56f967c2ea3ec71f36f0020cbefc01767d3d6bfdcf6a3c49efd"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.0-1/mutagen-compose_darwin_amd64_v0.17.0.tar.gz"
      sha256 "dcd4938c712e922e71bc2de04c330e2597a037fa6949c7d7c8c006d892885947"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.0-1/mutagen-compose_linux_amd64_v0.17.0.tar.gz"
    sha256 "ef28b5acaebd5f9a5ef978ba3863fcd9b84862e04eb4e14dfffbcfedffcf9fe6"
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
