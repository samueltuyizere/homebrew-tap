class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.9/oc-go-cc_darwin-arm64"
      sha256 "ae51c9b3e15249f152a2e894b5a029b9c21677e74907b0e1279b757e0897bf62"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.9/oc-go-cc_darwin-amd64"
      sha256 "4a5c057ebd31911abd8311a07a6f371a083886cb48d48e7344102260813db3b9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.9/oc-go-cc_linux-amd64"
      sha256 "58f1a6fd816c0d01c21ee404575fae7a30c8d1bd3dc053851f034c772bef8596"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.9/oc-go-cc_linux-arm64"
      sha256 "ca661d073926fc1c9ef6dcae621114f8d1e8ba6d55e9bfbfa3fe0e259ffee50d"
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
