class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.19"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.19/oc-go-cc_darwin-arm64"
      sha256 "c0dd14c839fc30d6961d61559b257dd32ad29a958655dcc28bb9a60017d10629"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.19/oc-go-cc_darwin-amd64"
      sha256 "c390c29e603eb5d1ffbbe6b168baf853fb11d512a2e9923a1709fa9b2f90f5cb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.19/oc-go-cc_linux-amd64"
      sha256 "11a727d79fd9d464cbde7eafe267f0cf0a9919b5a4661e8a40bb8c182bd0c229"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.19/oc-go-cc_linux-arm64"
      sha256 "f655b7046e5c67ba8ab4587391781a76085d33652506fe039e381b2f05740c69"
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
