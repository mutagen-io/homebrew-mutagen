class MutagenComposeBeta < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.0-beta1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-beta1/mutagen-compose_darwin_arm64_v0.15.0-beta1.tar.gz"
      sha256 "0bdf2740a27763cb95fa89c5f460cd2ac6350f024424b953cc84c2ac68864afc"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-beta1/mutagen-compose_darwin_amd64_v0.15.0-beta1.tar.gz"
      sha256 "8caba07df8d333439b394d320c541c0973ed18790bd36df7b77617925961947f"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0-beta1/mutagen-compose_linux_amd64_v0.15.0-beta1.tar.gz"
    sha256 "e94093736d25cd3038675c41df02269e3aeb978be068a0a47c98758aa939ef29"
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
