# TODO: This formula isn't particularly idiomatic. It treats the release archive
# as the source bundle and just copies the compiled files from the bundle to
# their destinations. This is necessary at the moment because Mutagen has a
# custom build script that (a) performs time-consuming cross-compilation of
# agent binaries and (b) requires macOS cgo support to build agents that support
# FSEvents. Issue (a) can likely be solved by bottling the compiled binaries,
# but issue (b) doesn't have an elegant solution for Linux systems.
class MutagenEdge < Formula
  desc "Fast file synchronization and network forwarding for remote development"
  homepage "https://mutagen.io"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.13.0/mutagen_darwin_arm64_v0.13.0.tar.gz"
      sha256 "db64c9c6b1da73fa532be2e58ba55a008759a0b69bffa01c9ae7992ea4e47fdb"
    else
      url "https://github.com/mutagen-io/mutagen/releases/download/v0.13.0/mutagen_darwin_amd64_v0.13.0.tar.gz"
      sha256 "2d9acd4abb613b36a51c753bc3ea1a3ef7a6806ba4d3fd92f05ec641d4e4af0b"
    end
  else
    url "https://github.com/mutagen-io/mutagen/releases/download/v0.13.0/mutagen_linux_amd64_v0.13.0.tar.gz"
    sha256 "bd4c009e4bbce76bf13823d8734b7ed951c1623026faedecb63f0f77aceefde1"
  end

  conflicts_with "mutagen", :because => "both install `mutagen` binaries"
  conflicts_with "mutagen-beta", :because => "both install `mutagen` binaries"

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

      WARNING: Mutagen edge releases are unstable and entirely unsupported.
    EOS
  end

  test do
    system bin/"mutagen", "version"
  end
end
