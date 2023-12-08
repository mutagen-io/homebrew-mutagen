class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.18.0-beta1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-beta1/mutagen-compose_darwin_arm64_v0.18.0-beta1.tar.gz"
      sha256 "f4b0fa688b65c04ac9f8103e75813944102b9b458d2ce76017eabe02faefdc6c"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-beta1/mutagen-compose_darwin_amd64_v0.18.0-beta1.tar.gz"
      sha256 "258ad15fa57b583f58592c86b70dcbd4db36065dbaed3751d68d6a9c3d9d3c10"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-beta1/mutagen-compose_linux_amd64_v0.18.0-beta1.tar.gz"
    sha256 "055da3b1daf76cf2e463c145706883a05a174db9e714fe2587a252fc273a1a8c"
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
