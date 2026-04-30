class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.21"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.21/oc-go-cc_darwin-arm64"
      sha256 "e24ef74b5883135c940e8eb84ac7d5d54675c7714f314c4b7d013a3cad8055c2"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.21/oc-go-cc_darwin-amd64"
      sha256 "ac3d3bb6a8be9aa387d84d7eacf14ba45e129c795d9859b1a11fa124e3b46e00"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.21/oc-go-cc_linux-amd64"
      sha256 "228d98b5cfdd9ac85ecccc22d698e2ff8dd257effd6916e74918a724d530e205"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.21/oc-go-cc_linux-arm64"
      sha256 "8b65097c8ee1592cec1134d7bbc2395bc0d34194122f71f20e39db0c89012bb2"
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
