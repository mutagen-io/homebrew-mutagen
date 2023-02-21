class MutagenAT016 < Formula
  desc "Fast file synchronization and network forwarding for remote development"
  homepage "https://mutagen.io"
  version "0.16.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.16.5/mutagen_darwin_arm64_v0.16.5.tar.gz"
      sha256 "c5e820e913da5b0a310b14320b9dc85305d854dbd9952c5312aa06e15f70191e"
    else
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.16.5/mutagen_darwin_amd64_v0.16.5.tar.gz"
      sha256 "0f874a3a80cfd1c5970617b6dd8b115fe97999725fec5c86f3e56ab28b07b668"
    end
  else
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.16.5/mutagen_linux_amd64_v0.16.5.tar.gz"
    sha256 "8b5bb689b16f381a06379fb13f8fc75e0e9b8f519752b92ea504650465970bad"
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
    EOS
  end

  test do
    system bin/"mutagen", "version"
  end
end