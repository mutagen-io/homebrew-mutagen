class MutagenAT012 < Formula
  desc "Fast file synchronization and network forwarding for remote development"
  homepage "https://mutagen.io"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.12.0/mutagen_darwin_arm64_v0.12.0.tar.gz"
      sha256 "401c101e3f81ab08d6c67a3bd03cd65065410ea17460e1631594288a7e6f0051"
    else
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.12.0/mutagen_darwin_amd64_v0.12.0.tar.gz"
      sha256 "530ad1868ee0e5b0a003ec67f37d3962e78b033b11a874e2f66751746f1c7ab6"
    end
  else
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.12.0/mutagen_linux_amd64_v0.12.0.tar.gz"
    sha256 "7a35891c0667105d43ce36b1ee406b3af21802ba5cd402cac47fcf5eff1ecad9"
  end

  conflicts_with "mutagen", :because => "both install `mutagen` binaries"
  conflicts_with "mutagen-beta", :because => "both install `mutagen` binaries"
  conflicts_with "mutagen-edge", :because => "both install `mutagen` binaries"

  def install
    # Generate and install shell completion scripts.
    mkdir "generated" do
      system "../mutagen", "generate",
        "--bash-completion-script=mutagen.bash",
        "--fish-completion-script=mutagen.fish",
        "--zsh-completion-script=_mutagen"
      bash_completion.install "mutagen.bash"
      fish_completion.install "mutagen.fish"
      zsh_completion.install "_mutagen"
    end

    # Install the mutagen binary into the bin directory.
    bin.install "mutagen"

    # Install the agent bundle into the libexec directory.
    libexec.install "mutagen-agents.tar.gz"
  end

  def caveats
    <<~EOS
      Mutagen has a daemon component that runs on a per-user basis. You'll need
      to invoke the following manually and/or add it to your shell
      initialization script:

        mutagen daemon start

      This command is idempotent and can be run any number of times.

      Experimental support for automatically starting the daemon on macOS via
      launchd is also available. To register Mutagen as a per-user daemon with
      launchd, use:

        mutagen daemon register

      This registration can be removed with:

        mutagen daemon unregister

      In order to take advantage of automatic start-up, either log out and log
      back in or run:

        mutagen daemon start

      This support is experimental, so please provide feedback if you run into
      any issues.

      Please note that the Mutagen daemon should be manually restarted after an
      update using:

        mutagen daemon stop
        mutagen daemon start

      WARNING: Mutagen legacy releases are unsupported one month after the first
      release in the next minor release series.
    EOS
  end

  test do
    system bin/"mutagen", "version"
  end
end
