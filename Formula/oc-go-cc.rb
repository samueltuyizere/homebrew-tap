class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.15"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.15/oc-go-cc_darwin-arm64"
      sha256 "66e7e793e8e4380f8b7e76e81f8ea5e98dedcba70b6a0779772783e22e46a41e"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.15/oc-go-cc_darwin-amd64"
      sha256 "fe87e9627fc77e6e95ae143c082938d1dcf9a8b6ec4534ffbdf822e7f9c916ca"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.15/oc-go-cc_linux-amd64"
      sha256 "1c22909054c2f16a0e03131a5311b1f8b22a365b15d63677b0150ed64d525e30"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.15/oc-go-cc_linux-arm64"
      sha256 "48c328607e0da5bc24fa0c7f33d60e9a6a17f110f52f0cdfa4f4fd75abae39a1"
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
