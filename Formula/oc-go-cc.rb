class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.7/oc-go-cc_darwin-arm64"
      sha256 "31e3c576a420eb2cff228da324d52276bef66cc5b532b52c160ffd1bba61403a"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.7/oc-go-cc_darwin-amd64"
      sha256 "0299ae3e06a2e562c1c0216bd1a20cc4a9b809ec9ea7aa4bde03b0f3be70bc17"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.7/oc-go-cc_linux-amd64"
      sha256 "bae54347445f852ac9e199ea847237d1f68072141c171d11b708b39bdd280acc"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.7/oc-go-cc_linux-arm64"
      sha256 "785d9bec855efcbbf531c97ba9ae0ce597b8f38227732d65a176efe6f9fb8031"
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
