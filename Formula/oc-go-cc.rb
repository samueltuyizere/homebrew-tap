class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.12"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.12/oc-go-cc_darwin-arm64"
      sha256 "47631123b21d90abe603769ca954f6fa6beee7c8ff8bbead46a575692582ce73"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.12/oc-go-cc_darwin-amd64"
      sha256 "522427c977d20df0d1b07ee24dc4d9f17072725696c59343bc5d212cf0472b08"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.12/oc-go-cc_linux-amd64"
      sha256 "6f7fea82b911efa4370951c0262ff0846c4b9815bddb93cf66c95e2fe3730d35"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.12/oc-go-cc_linux-arm64"
      sha256 "1141cfa7cb992d13ba5ba8d0012b37fa234848d0b02841d024389910dc44f1be"
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
