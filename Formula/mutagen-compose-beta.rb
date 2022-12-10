class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.16.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.3/mutagen-compose_darwin_arm64_v0.16.3.tar.gz"
      sha256 "0ac9b01458a71bdb53d6cd6ebc3900603998b9fbf89a72669fd28eadc5082b89"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.3/mutagen-compose_darwin_amd64_v0.16.3.tar.gz"
      sha256 "8a439d0f192d6a0a79041c74f2ecfb1416ce4aff713be6f9110aec5698e59ddf"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.16.3/mutagen-compose_linux_amd64_v0.16.3.tar.gz"
    sha256 "1251956aaf5b22fdda7ba4463b159a451caa34a3b775ef6c7db708ad9c90e86c"
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
