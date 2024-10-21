class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.18.0-rc2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-rc2/mutagen-compose_darwin_arm64_v0.18.0-rc2.tar.gz"
      sha256 "edb5c244229937c13c2ae160d49d31c176a992cfa39be2dc063cf0f2f05e272b"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-rc2/mutagen-compose_darwin_amd64_v0.18.0-rc2.tar.gz"
      sha256 "21c06f32f3508c326320c5e34ea003594f383d783bb99bda554a98d361198176"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.18.0-rc2/mutagen-compose_linux_amd64_v0.18.0-rc2.tar.gz"
    sha256 "d53b9fe362229aadba662707e39b2935ae0e8739446f3d957a7ea3df2a4d033b"
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
