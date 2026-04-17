class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.6/oc-go-cc_darwin-arm64"
      sha256 "f0291efb2e464d7463f29b216627db11f01b4116eb1a7a10668e278eb60d7733"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.6/oc-go-cc_darwin-amd64"
      sha256 "561f61940ce2f6e49081c7195a9c4395639be912d49005d2328153a2618641f4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.6/oc-go-cc_linux-amd64"
      sha256 "f100d295e3f7dbe1eddc8e13e097d191d7f363de5567409cd7ec8535aebf6c65"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.6/oc-go-cc_linux-arm64"
      sha256 "e5734d76aa33379db5e44d8a71a6a720fbcef8cadcd308f7f15ce3c507bae674"
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
