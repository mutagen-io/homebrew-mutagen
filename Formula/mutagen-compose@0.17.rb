class MutagenComposeAT017 < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.17.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.6/mutagen-compose_darwin_arm64_v0.17.6.tar.gz"
      sha256 "af52aae55363123d790601d282516e1b92592a9d42e70b05d0c30c3a917359cb"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.6/mutagen-compose_darwin_amd64_v0.17.6.tar.gz"
      sha256 "b9ecd30313be96df0251129f4fc411130e5f7384a41b694cfcb95172d1296016"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.6/mutagen-compose_linux_amd64_v0.17.6.tar.gz"
    sha256 "3cd469a3e4cb579c25d09a92fd54aa1c5707879d277f3dfce0c5d76d8187f685"
  end

  depends_on "mutagen@0.17"

  conflicts_with "mutagen-compose", :because => "both install `mutagen-compose` binaries"
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
