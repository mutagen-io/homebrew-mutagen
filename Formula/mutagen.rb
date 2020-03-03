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
  version "0.11.1"
  if OS.mac?
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.11.1/mutagen_darwin_amd64_v0.11.1.tar.gz"
    sha256 "276471171ab54630f4381a502be4bcf63cabc7ee6bb24875891983c5ee75ce44"
  else
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.11.1/mutagen_linux_amd64_v0.11.1.tar.gz"
    sha256 "0df9036be5f1f2fd9d9fb16acaa256e85f5c729507dff742dc19b88fb693071b"
  end

  devel do
    version "0.11.1"
    if OS.mac?
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.11.1/mutagen_darwin_amd64_v0.11.1.tar.gz"
      sha256 "276471171ab54630f4381a502be4bcf63cabc7ee6bb24875891983c5ee75ce44"
    else
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.11.1/mutagen_linux_amd64_v0.11.1.tar.gz"
      sha256 "0df9036be5f1f2fd9d9fb16acaa256e85f5c729507dff742dc19b88fb693071b"
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

    # Install the agent bundle into the bin directory.
    # TODO: I'd prefer to install this in the libexec directory for hygiene
    # purposes. This is a bit of a pain to properly implement because Mutagen
    # use's Go's os.Executable function, which on some platforms (including
    # macOS) returns the symlink path used to launch the executable. Resolving
    # the symlink would be necessary to compute the libexec path because libexec
    # isn't linked into /usr/local by Homebrew. Other than that, probing for the
    # bundle in libexec wouldn't be particularly difficult.
    bin.install "mutagen-agents.tar.gz"
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
