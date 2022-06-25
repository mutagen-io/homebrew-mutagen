class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.0-beta2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-beta2/mutagen-compose_darwin_arm64_v0.15.0-beta2.tar.gz"
      sha256 "a53d73e2baf85f4eb1515865386b12dc1c98d26bf4ba84b0ad34a6ddb41f3b28"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-beta2/mutagen-compose_darwin_amd64_v0.15.0-beta2.tar.gz"
      sha256 "1d0131c2ccadda52ecaf0dc778e90de5b21678cede1a97d09feb63c19e678f82"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-beta2/mutagen-compose_linux_amd64_v0.15.0-beta2.tar.gz"
    sha256 "26999a1a020f6e86e629ae9384613b2aeb6cd2d97bc7626159723b002bc47514"
  end

  depends_on "mutagen-beta"

  conflicts_with "mutagen-compose", :because => "both install `mutagen-compose` binaries"

  def install
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
