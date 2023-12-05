class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.17.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.4/mutagen-compose_darwin_arm64_v0.17.4.tar.gz"
      sha256 "b2123bdf128f4fc5237df23ed6aea87312f517f89c850dfd068e69afd6db78db"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.4/mutagen-compose_darwin_amd64_v0.17.4.tar.gz"
      sha256 "b80e866f5d1879d2d1a1f3dae1d1c29c7b2a064682d2f8b7e8700007c6b2bf8c"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.17.4/mutagen-compose_linux_amd64_v0.17.4.tar.gz"
    sha256 "39243c3849801bdfa0b73be74ae52dc834f41db926cf75d8601cfcfbf4941416"
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
