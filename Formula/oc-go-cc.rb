class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.14/oc-go-cc_darwin-arm64"
      sha256 "03b73a6d27807d07477a1f96936b5b6363e2a0bc25ccd9f679ead9ae51444fa6"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.14/oc-go-cc_darwin-amd64"
      sha256 "2f89e7baea3ff147ddb6cf28a109b6791899481b1959f575ae14d8da4376b57d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.14/oc-go-cc_linux-amd64"
      sha256 "38651ecf68b4e958443a3522f77f87414159ee937140eb1aabf9a6ae0c5f84d8"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.14/oc-go-cc_linux-arm64"
      sha256 "1e5227c808ca8d6ea576f8c5bd954c9a07ad383d34c1d77126691941555eb0ab"
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
