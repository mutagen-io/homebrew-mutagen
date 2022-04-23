class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0/mutagen-compose_darwin_arm64_v0.14.0.tar.gz"
      sha256 "48a9447e0a44787477f8c36d57b5ea66e2bf8b72d43e7a0f3122823e2ba98aec"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0/mutagen-compose_darwin_amd64_v0.14.0.tar.gz"
      sha256 "cb7aced581ef6ac079814ca475c29f4d0bea468854d2001edb84f6c0cbb35f52"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.14.0/mutagen-compose_linux_amd64_v0.14.0.tar.gz"
    sha256 "5c7726482e4e4113aa27f927d78b6351e9eefe815a1ad698f2cda73b57a1cb22"
  end

  depends_on "mutagen"

  conflicts_with "mutagen-compose-beta", :because => "both install `mutagen-compose` binaries"

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
