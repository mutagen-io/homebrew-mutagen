class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.16.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.4/mutagen-compose_darwin_arm64_v0.16.4.tar.gz"
      sha256 "d509e0eb5cb2f012377ae6560bd78fe61bdbee995c7351515c037ddf0e7abe88"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.4/mutagen-compose_darwin_amd64_v0.16.4.tar.gz"
      sha256 "86275eeaa4c4a5c8a995cb296ad262c66caee357c6be8844d0288b46d432d8ac"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.4/mutagen-compose_linux_amd64_v0.16.4.tar.gz"
    sha256 "7b665b9ba9375f52ecace84376538e2a7296c67100915a7569efcf4d8bcdf6da"
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
