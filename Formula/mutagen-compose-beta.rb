class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.16.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.5/mutagen-compose_darwin_arm64_v0.16.5.tar.gz"
      sha256 "7cf8e8fa64f7473516dd550bfd3a65a255205bbea845162b61ca013f75d723f4"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.5/mutagen-compose_darwin_amd64_v0.16.5.tar.gz"
      sha256 "0205d1c9577de8bb60d6f0dd5ac5eea30a83d05c0d6d31f9bce22d00edda6cb6"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.5/mutagen-compose_linux_amd64_v0.16.5.tar.gz"
    sha256 "4c705769a677b43086b1cc2e93d29c79f035ec91e2a50e135d4cf526e3ab3ee4"
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
