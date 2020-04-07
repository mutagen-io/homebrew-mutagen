# TODO: This formula isn't particularly idiomatic. It treats the release archive
# as the source bundle and just copies the compiled files from the bundle to
# their destinations. This is necessary at the moment because Mutagen has a
# custom build script that (a) performs time-consuming cross-compilation of
# agent binaries and (b) requires macOS cgo support to build agents that support
# FSEvents. Issue (a) can likely be solved by bottling the compiled binaries,
# but issue (b) doesn't have an elegant solution for Linux systems.
class Mutagen < Formula
  desc "Fast, cross-platform, continuous, bidirectional file synchronization"
  homepage "https://mutagen.io"
  version "0.11.3"
  if OS.mac?
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.11.3/mutagen_darwin_amd64_v0.11.3.tar.gz"
    sha256 "f988ec285e66f0b2e219c4064689b0eb1e99af39e92960047b1fd3b9a89c8153"
  else
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.11.3/mutagen_linux_amd64_v0.11.3.tar.gz"
    sha256 "c1e1467b00fb864138ec981c2b2676c0d92e65d6b7870f1ce9ea5e506d9e6d72"
  end

  devel do
    version "0.11.3"
    if OS.mac?
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.11.3/mutagen_darwin_amd64_v0.11.3.tar.gz"
      sha256 "f988ec285e66f0b2e219c4064689b0eb1e99af39e92960047b1fd3b9a89c8153"
    else
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.11.3/mutagen_linux_amd64_v0.11.3.tar.gz"
      sha256 "c1e1467b00fb864138ec981c2b2676c0d92e65d6b7870f1ce9ea5e506d9e6d72"
    end
  end

  def install
    # Generate a bash completion script in a subdirectory and install it to the
    # bash completion directory.
    mkdir "generated" do
      system "../mutagen", "generate", "--bash-completion-script=mutagen"
      bash_completion.install "mutagen"
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
