class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.14.0-3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-3/mutagen-compose_darwin_arm64_v0.14.0.tar.gz"
      sha256 "0f1d273c6afaa9ba5b98d1fa170c1ebbd9e5933897dc63acbcd7660d95a3b745"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-3/mutagen-compose_darwin_amd64_v0.14.0.tar.gz"
      sha256 "70df6d742f780aa78efb53ff9490fd81a55336dbf348893df38df2e17a16e324"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0-3/mutagen-compose_linux_amd64_v0.14.0.tar.gz"
    sha256 "99a24cc5b0ba6c4666a292c7727fd6bf0a367a3c765f7c2b5998d7728edee50a"
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
