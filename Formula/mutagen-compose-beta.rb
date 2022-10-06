class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.16.0-rc1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0-rc1/mutagen-compose_darwin_arm64_v0.16.0-rc1.tar.gz"
      sha256 "9ad5d2a90f471972a834e9642428a266d691d176199fa66774e3c912f20a9e74"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0-rc1/mutagen-compose_darwin_amd64_v0.16.0-rc1.tar.gz"
      sha256 "ce553795b2f91b796c22151c48c1a7b362be9c465ae862b1317380a760f4fa23"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.0-rc1/mutagen-compose_linux_amd64_v0.16.0-rc1.tar.gz"
    sha256 "732bb0b498be183fee878f979c5d562f0cdce644ae3d38e6a2b2584408fc281b"
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
