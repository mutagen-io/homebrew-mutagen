class MutagenAT014 < Formula
  desc "Fast file synchronization and network forwarding for remote development"
  homepage "https://mutagen.io"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.14.0/mutagen_darwin_arm64_v0.14.0.tar.gz"
      sha256 "0773797d63978314c0fcffd9da7416db4bdaf6a290672d6530c4b47a07613fc6"
    else
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.14.0/mutagen_darwin_amd64_v0.14.0.tar.gz"
      sha256 "f4fb7da8a155ba267044084d20cc073632eaf9d05b1505f8eeb06fd484cacfd2"
    end
  else
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.14.0/mutagen_linux_amd64_v0.14.0.tar.gz"
    sha256 "eb9cb43cc78ec8a601c55e51f7ab176ab23f1f4738213c036d8fe9914aadd290"
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
