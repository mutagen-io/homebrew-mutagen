class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.0-1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-1/mutagen-compose_darwin_arm64_v0.15.0.tar.gz"
      sha256 "31f404996769764d40a823953638df43df66d6080948c664e94e891dd4a18ea4"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-1/mutagen-compose_darwin_amd64_v0.15.0.tar.gz"
      sha256 "02939455e47c599ecb58d6d3c97e45bf7e762f74e10fa03751a096937b1f704e"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-1/mutagen-compose_linux_amd64_v0.15.0.tar.gz"
    sha256 "80d370492711872c621e47dd64988486e6f29364725648a6814759b7e4c7b1ab"
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
