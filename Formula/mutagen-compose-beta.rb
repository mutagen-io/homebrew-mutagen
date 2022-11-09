class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.16.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.1/mutagen-compose_darwin_arm64_v0.16.1.tar.gz"
      sha256 "b7740d6b1248790aa9afe4c7a63a88f0c886e7b4a52e5e1cdb507efc51938665"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.1/mutagen-compose_darwin_amd64_v0.16.1.tar.gz"
      sha256 "5bc5696fe42e164f8dc8a4adbc1b78d9ef3db2cc785ec3795c08898de6856518"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.1/mutagen-compose_linux_amd64_v0.16.1.tar.gz"
    sha256 "c42815114c8466d0225da3cc794b47404157378c1efe964018da6d61dd1ef1d0"
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
