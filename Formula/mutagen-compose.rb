class MutagenCompose < Formula
  desc "Compose with Mutagen integration"
  homepage "https://github.com/mutagen-io/mutagen-compose"
  version "0.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0/mutagen-compose_darwin_arm64_v0.15.0.tar.gz"
      sha256 "793d8c325366ec9217dce4e3c140d215a1b7417596fe2614173eba73396e73b3"
    else
      url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0/mutagen-compose_darwin_amd64_v0.15.0.tar.gz"
      sha256 "083e90104b153eee388a0b643199eb539a1800621d134d6276e55a76ce572c77"
    end
  else
    url "https://github.com/mutagen-io/mutagen-compose/releases/download/v0.15.0/mutagen-compose_linux_amd64_v0.15.0.tar.gz"
    sha256 "676da8318e05f6e6bea331ea23709018559232a6d0b1e8ffcd9b117514f8b36f"
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
