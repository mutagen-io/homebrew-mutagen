class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.17.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.5/mutagen-compose_darwin_arm64_v0.17.5.tar.gz"
      sha256 "fc375c37427f5d74b297daa91c7edb0efc2a95137e00a9e3d9d0bb6268f3356b"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.5/mutagen-compose_darwin_amd64_v0.17.5.tar.gz"
      sha256 "9d3e6dea97218d5a1270db48c6d134003e9d371f50024486604b2930a53b2a5e"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.5/mutagen-compose_linux_amd64_v0.17.5.tar.gz"
    sha256 "1b5440cb0609a6692e42457419b488fa379f20ff71e9d703fe43320608d03135"
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
