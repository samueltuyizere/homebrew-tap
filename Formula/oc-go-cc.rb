class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.20"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.20/oc-go-cc_darwin-arm64"
      sha256 "525a9fdd472d09a2a425f011ab9896d2c93749efd393d25a597057ccb4aab5a3"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.20/oc-go-cc_darwin-amd64"
      sha256 "c486f9ddfafba6d0940f5dbc5421c6cfe983c4264dd8ac484f1d5bcf749c59c5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.20/oc-go-cc_linux-amd64"
      sha256 "e8c7f37619150c7f9ba57ffeaa4a94eaebdc9f3b93b2898f86fa467bbf7a42fd"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.20/oc-go-cc_linux-arm64"
      sha256 "6b31a6bd5a617c8397a779de1ffd6248eaad5c1b3e83df2d8ff054480573ea59"
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
