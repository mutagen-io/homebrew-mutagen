# TODO: This formula isn't particularly idiomatic. It treats the release archive
# as the source bundle and just copies the compiled files from the bundle to
# their destinations. This is necessary at the moment because Mutagen has a
# custom build script that (a) performs time-consuming cross-compilation of
# agent binaries and (b) requires macOS cgo support to build agents that support
# FSEvents. Issue (a) can likely be solved by bottling the compiled binaries,
# but issue (b) doesn't have an elegant solution for Linux systems.
class MutagenBeta < Formula
  desc "Fast file synchronization and network forwarding for remote development"
  homepage "https://mutagen.io"
  version "0.18.0-beta1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.18.0-beta1/mutagen_darwin_arm64_v0.18.0-beta1.tar.gz"
      sha256 "1fc27d19e8836486d91f821d9b32ff9091d4e15f2955de8f1ecc6d1a64e74feb"
    else
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.18.0-beta1/mutagen_darwin_amd64_v0.18.0-beta1.tar.gz"
      sha256 "6482ba0b9809858c5e4bb5a210a6370b08bc80225e2b34866103d68b58bb7f28"
    end
  else
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.18.0-beta1/mutagen_linux_amd64_v0.18.0-beta1.tar.gz"
    sha256 "ac8a52d0d6e185198d6c2e9853c6f6a88abb1afea7ce84d368053b29f884f692"
  end

  conflicts_with "mutagen", :because => "both install `mutagen` binaries"
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

      WARNING: Mutagen beta releases are not officially supported.
    EOS
  end

  test do
    system bin/"mutagen", "version"
  end
end
