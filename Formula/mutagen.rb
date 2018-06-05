class Mutagen < Formula
  desc "Simple, cross-platform, continuous, bidirectional file synchronization"
  homepage "https://mutagen.io"
  version "0.2.0"
  url "https://github.com/havoc-io/mutagen/releases/download/v0.2.0/mutagen_darwin_amd64_v0.2.0.tar.gz"
  sha256 "c037f599b90ec5e6d349355256537f4e54420744d18773a24e9cdf2c925ccfc9"

  def install
    # Install the mutagen binary into the bin directory.
    bin.install "mutagen"

    # Install the agent bundle into the bin directory.
    bin.install "mutagen-agents.tar.gz"
  end

  def caveats
    <<~EOS
      Mutagen has a daemon component that runs on a per-user basis. You'll need to
      invoke the following manually and/or add it to your shell initialization
      script:

        mutagen daemon

      Support for automatically starting the Mutagen daemon is coming soon.
    EOS
  end

  test do
    system bin/"mutagen", "--version"
  end
end
