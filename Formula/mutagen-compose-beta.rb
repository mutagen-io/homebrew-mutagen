class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.18.0-rc3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-rc3/mutagen-compose_darwin_arm64_v0.18.0-rc3.tar.gz"
      sha256 "e7b0f98bbf85d93b6db609d16fdb0c84314f234630fbbaba130949f1305169e6"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-rc3/mutagen-compose_darwin_amd64_v0.18.0-rc3.tar.gz"
      sha256 "9ebd7c12fa13064f1daa89a65a8028885cefbaadca29c0aa07517a52f6951810"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-rc3/mutagen-compose_linux_amd64_v0.18.0-rc3.tar.gz"
    sha256 "5134b3ce954e6d86621f7b1f7cf3d2a76304c8f426d0b68887a1a2503239803d"
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
