class MutagenAT010 < Formula
  desc "Fast file synchronization and network forwarding for remote development"
  homepage "https://mutagen.io"
  version "0.10.4"
  if OS.mac?
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.10.4/mutagen_darwin_amd64_v0.10.4.tar.gz"
    sha256 "aae7abd0b74a2f4c0f9b7190a2fbea9c82b7a736e9f1bc63a1cc6e961bc9b41b"
  else
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.10.4/mutagen_linux_amd64_v0.10.4.tar.gz"
    sha256 "bf06e2b2aab7b87bc1fccbf04eaa8ac536eed87a2ae239b856e0ff6251454246"
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

      WARNING: Mutagen legacy releases are unsupported one month after the first
      release in the next minor release series.
    EOS
  end

  test do
    system bin/"mutagen", "version"
  end
end
