class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.9/oc-go-cc_darwin-arm64"
      sha256 "7bf3245fed98259e886f75f12171402a236a7c73709c6f7191631fd02eab139e"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.9/oc-go-cc_darwin-amd64"
      sha256 "9ea897daa79d1b8d7aa39bd1d0f4c7b0de92d63e3dc6d276519791209581d305"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.9/oc-go-cc_linux-amd64"
      sha256 "88a03bd8efd44e98a51e28bef0e5954db64f71d77861807d1454067873b6fa48"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.9/oc-go-cc_linux-arm64"
      sha256 "fb63672984d797acca4a48d1b3b5c2a22b96d969d4cfefe59042d4ee14a442d6"
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
