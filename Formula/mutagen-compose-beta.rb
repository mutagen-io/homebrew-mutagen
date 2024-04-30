class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.18.0-rc1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-rc1/mutagen-compose_darwin_arm64_v0.18.0-rc1.tar.gz"
      sha256 "cf7be3748b5880f834bbe51b311351ccd7bb486f3b5933fe6d805f161b5f0e1a"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-rc1/mutagen-compose_darwin_amd64_v0.18.0-rc1.tar.gz"
      sha256 "56627c89357b0ad538ed07049597a15f5c2b368a669ca16097d1ba78a5574df6"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-rc1/mutagen-compose_linux_amd64_v0.18.0-rc1.tar.gz"
    sha256 "68bb022e2228f1063f1db9e8ed9bdad688a36ac71b5b01ba934dc0112b132a4d"
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
