class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.16/oc-go-cc_darwin-arm64"
      sha256 "53826166d67c7c86e786932e8907ef366a18337af11f452160868b7580df0bb9"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.16/oc-go-cc_darwin-amd64"
      sha256 "0d3db3dd2dcca525734868f3f0f9810366881acb9b960ee6e2bccd09ae0ea22b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.16/oc-go-cc_linux-amd64"
      sha256 "3481242c606d0cd4aac342ec108bac552790b918f55d2dc53a57bc8a5453812b"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.16/oc-go-cc_linux-arm64"
      sha256 "8aad4326a9bbc3ab05b5027928245c222c278af2a158cae3508f6369249aa85d"
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
