class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.16.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.2/mutagen-compose_darwin_arm64_v0.16.2.tar.gz"
      sha256 "a0614ac2fedacfcfeed3e9da29e42952ceb2d6f2e46105f717cfdfb164498dc5"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.2/mutagen-compose_darwin_amd64_v0.16.2.tar.gz"
      sha256 "1bf6fa975d17d62b2716fc26c843887c7710630ceee8ef2c42d99cae5c53c0f0"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.2/mutagen-compose_linux_amd64_v0.16.2.tar.gz"
    sha256 "b138c97e1680bd4e855c114604cf0092a4b67848f6063ca40efddb3da0b046a8"
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
