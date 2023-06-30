class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.17.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.2/mutagen-compose_darwin_arm64_v0.17.2.tar.gz"
      sha256 "09928a1839834853469807c21aeeed119440c775b53e685d6294da86087fbf28"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.2/mutagen-compose_darwin_amd64_v0.17.2.tar.gz"
      sha256 "c98b1d610250d7785794ad08c9225d66ee1d201d9beb7cb93ceafa903a60094f"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.2/mutagen-compose_linux_amd64_v0.17.2.tar.gz"
    sha256 "b8e921fe843bbf72960a5c213b372bb04824c6b8009033cca6e525abdff593fc"
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
