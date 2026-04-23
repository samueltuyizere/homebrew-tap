class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.11/oc-go-cc_darwin-arm64"
      sha256 "0d5340fa3023d7ce64d2fa8b401d15519fb5f8eb2dfae5b9cc69d000d06ef452"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.11/oc-go-cc_darwin-amd64"
      sha256 "ae9779782aab77513820531e51f6ebb8d376c3b5d2e4dc79ee8ca8a4d9c298b4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.11/oc-go-cc_linux-amd64"
      sha256 "1a7a4c18f9e7dbbb1a15d50f2d54b59aad0d10c3658e9d58b9445557ca438d64"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.11/oc-go-cc_linux-arm64"
      sha256 "855442dc8443259c6b76127ddc15bb52f933079ca4921e56675320f293435380"
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
