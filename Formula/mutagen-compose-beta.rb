class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.14.0-beta1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-beta1/mutagen-compose_darwin_arm64_v0.14.0-beta1.tar.gz"
      sha256 "a3660bd9a26e31052377c9f933ef866fd1d17c8df42761b8307421eef1b072aa"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-beta1/mutagen-compose_darwin_amd64_v0.14.0-beta1.tar.gz"
      sha256 "5a464e6593b42363e655369d72e0afee534c3123ed818f9b1f6b647bc3121eb4"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-beta1/mutagen-compose_linux_amd64_v0.14.0-beta1.tar.gz"
    sha256 "c822d277faa2d8b403bd6c88d6a586fc4b5f8b56a8fe16cafcc30c74e3842ade"
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
