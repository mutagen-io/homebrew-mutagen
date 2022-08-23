class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.2/mutagen-compose_darwin_arm64_v0.15.2.tar.gz"
      sha256 "eea85b8186254ecaa1854cd03ef28324a733ee95f6f6aa767806729b75ad0bf7"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.2/mutagen-compose_darwin_amd64_v0.15.2.tar.gz"
      sha256 "8b6dd2bf3e906829f4918bbb3fcebc3267af73a9e7590e5a7a787714cddb8d4d"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.2/mutagen-compose_linux_amd64_v0.15.2.tar.gz"
    sha256 "a3c93555cbed9ba5fa22002aae1dcc90ead5ebc04faa85e0e10243318fdaa7f1"
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
