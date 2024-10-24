class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.18.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0/mutagen-compose_darwin_arm64_v0.18.0.tar.gz"
      sha256 "4f98ea38cf06ee1742bf721794e1f7d6d438e7ee1b8e02448a2a827e32e9e861"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0/mutagen-compose_darwin_amd64_v0.18.0.tar.gz"
      sha256 "987c619e2d0f56d2c9103a0659dce28faf3a331aebdadc5b20ed8d01aeda57da"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0/mutagen-compose_linux_amd64_v0.18.0.tar.gz"
    sha256 "87d4ab81d7c5e778b427c9af09ad65dca049219944191c9f4c9d869b413d82ef"
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
