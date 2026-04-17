class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.5/oc-go-cc_darwin-arm64"
      sha256 "d61081c033f7e8daa8e6f263c95861e0e9a65abfa15df69298b7c607de70e7d6"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.5/oc-go-cc_darwin-amd64"
      sha256 "b0f9949d40d3f660b5c56d8fd0dd9a6a65f5bd936d8de31387a455209e739162"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.5/oc-go-cc_linux-amd64"
      sha256 "73514f995b09f97555835871a2bf0d643112055a4d2a50e53f01f5ef9862de8c"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.5/oc-go-cc_linux-arm64"
      sha256 "80f1ff8e8208a588e605725d741bac97fd9c7b5a87d5a82d21ded5293a27b94f"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "oc-go-cc_darwin-arm64" => "oc-go-cc"
    elsif OS.mac?
      bin.install "oc-go-cc_darwin-amd64" => "oc-go-cc"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "oc-go-cc_linux-amd64" => "oc-go-cc"
    else
      bin.install "oc-go-cc_linux-arm64" => "oc-go-cc"
    end
  end

  def caveats
    <<~EOS
      To get started with oc-go-cc:

        1. Initialize configuration:
           oc-go-cc init

        2. Set your OpenCode Go API key:
           export OC_GO_CC_API_KEY=sk-opencode-your-key

        3. Start the proxy:
           oc-go-cc serve

        4. Configure Claude Code:
           export ANTHROPIC_BASE_URL=http://127.0.0.1:3456
           export ANTHROPIC_AUTH_TOKEN=unused

        5. Run Claude Code:
           claude
    EOS
  end

  test do
    system "#{bin}/oc-go-cc", "--version"
  end
end
