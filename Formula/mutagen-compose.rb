class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.18.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.1/mutagen-compose_darwin_arm64_v0.18.1.tar.gz"
      sha256 "9a8a59af5a78c77e5832166f76fa31db87f82fd934d54c3583ae9a289c3be78a"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.1/mutagen-compose_darwin_amd64_v0.18.1.tar.gz"
      sha256 "a94c8fad7ce225bc12d77655544bf8dd1b4032854db2694b30527cd9b1d91dfb"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.1/mutagen-compose_linux_amd64_v0.18.1.tar.gz"
    sha256 "0a46d77136435fbf6050f1fff69e92e7f858378b71d30c0259bf9f465e32d0f6"
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
