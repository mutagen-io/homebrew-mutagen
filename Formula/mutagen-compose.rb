class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.17.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.0/mutagen-compose_darwin_arm64_v0.17.0.tar.gz"
      sha256 "bdb814950834ded3d5e8d048611d291889a98027fa8286401cf890b7df311624"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.0/mutagen-compose_darwin_amd64_v0.17.0.tar.gz"
      sha256 "cab00c1ae7acf1f564f2dedbbac4544769298b8b53282fb9b323987879810f68"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.0/mutagen-compose_linux_amd64_v0.17.0.tar.gz"
    sha256 "ed55a401ca0ea1d5375403924c8b50965ec20a3eb0dcf4deecf8bf735ca73b84"
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
