class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.8/oc-go-cc_darwin-arm64"
      sha256 "5b8dfb89f30546a6f7537155fd721e8aa2e9569e59b0ea7d347f53c193477eb8"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.8/oc-go-cc_darwin-amd64"
      sha256 "ae3562636bc116df735fd7215904866a300b6146cc1be255728d4454c48c606d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.8/oc-go-cc_linux-amd64"
      sha256 "a8bacc89df54a8d48869a315578e91905cabe4b4d5182ffcc6e75b7a5909b531"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.8/oc-go-cc_linux-arm64"
      sha256 "5e80485eb0c2f6f6e95aaf4a3d634f3fc38123bf9dcb2f1c0c37d893d328c8f0"
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
