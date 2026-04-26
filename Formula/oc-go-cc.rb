class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.17"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.17/oc-go-cc_darwin-arm64"
      sha256 "4c32ecfd29a7d0fc1b82d22f4ba2d27250d87ee5dad4efb746f42590016b2858"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.17/oc-go-cc_darwin-amd64"
      sha256 "3814cb8a1987e62a2b2c321e502ca13867ac564ce37e66653eb5570ed49065e0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.17/oc-go-cc_linux-amd64"
      sha256 "e47b6e77aa1e54fc3c18cc90c4a4be7a901e190c630742226c9671d4da13fb7b"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.17/oc-go-cc_linux-arm64"
      sha256 "ec9b2198a3d89fe6a5758ec9fadf5204848bcbdd98a040f7e94a5002c7c85c2d"
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
