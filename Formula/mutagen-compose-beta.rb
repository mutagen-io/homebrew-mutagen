class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.18.0-beta2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-beta2/mutagen-compose_darwin_arm64_v0.18.0-beta2.tar.gz"
      sha256 "d0e75a3342434bda197d4fd5b9c64167c2c447f2e55b35757f3360f69b3c3444"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-beta2/mutagen-compose_darwin_amd64_v0.18.0-beta2.tar.gz"
      sha256 "64af9ce77ac4be311b1062438018bcc5883dd4a2edab5ef4c54d2c47c5a27cbb"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-beta2/mutagen-compose_linux_amd64_v0.18.0-beta2.tar.gz"
    sha256 "f47775a1f5da92fc6f87fe2d78cdc1b77176e56d91f6a1cbe071b62090a99638"
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
