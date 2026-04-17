class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.2/oc-go-cc_darwin-arm64"
  version "0.0.2"
  sha256 "af3732f0aa48f00ef2d11b27bc7fec2594c761dafec2c0415c2c227f5f9a8b2d"

  depends_on :macos => :arm64_if_intel

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.2/oc-go-cc_darwin-arm64"
      sha256 "af3732f0aa48f00ef2d11b27bc7fec2594c761dafec2c0415c2c227f5f9a8b2d"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.2/oc-go-cc_darwin-amd64"
      sha256 "d02e57bfe9f7a3b9727472c408b9568416b86f144aaefe323bcabc69b216dcc9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.2/oc-go-cc_linux-amd64"
      sha256 "328ec2c1fd97a3d4b1051adfcb00de2c48a495809ac0986002b1fc8440c0b15f"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.2/oc-go-cc_linux-arm64"
      sha256 "e060eb33e0b933c3f4fbbf8a9d4f4a589dfe46f1277861a75f5e51fb34b64aa8"
    end
  end

  def install
    bin.install "oc-go-cc_darwin-arm64" => "oc-go-cc" if OS.mac? && Hardware::CPU.arm?
    bin.install "oc-go-cc_darwin-amd64" => "oc-go-cc" if OS.mac? && !Hardware::CPU.arm?
    bin.install "oc-go-cc_linux-amd64" => "oc-go-cc" if OS.linux? && Hardware::CPU.intel?
    bin.install "oc-go-cc_linux-arm64" => "oc-go-cc" if OS.linux? && !Hardware::CPU.intel?
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
