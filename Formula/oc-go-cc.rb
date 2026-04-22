class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.10/oc-go-cc_darwin-arm64"
      sha256 "1f0e041df4ebb0a62b4995bb8982bfca539b1c3e6de077c5e16179f1773fdc82"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.10/oc-go-cc_darwin-amd64"
      sha256 "507724f0d36daa4b361ea0e129c9a432023ce4e7ca9e2ae883c0a3a574374682"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.10/oc-go-cc_linux-amd64"
      sha256 "2313aa3348f14982566a92d63ca6f158cb89e35a32bf0d90eb0acf0d99650acb"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.10/oc-go-cc_linux-arm64"
      sha256 "0a7ba86eeacab1ce1ffb4621a28341bc4c969791e43b6ec93fcf0e52098c37a8"
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
