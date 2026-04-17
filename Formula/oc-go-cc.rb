class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.3/oc-go-cc_darwin-arm64"
      sha256 "8ac52ac2c0ff59298263adec7380c533dcfa7d5db942b7f764b12420edb1fc51"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.3/oc-go-cc_darwin-amd64"
      sha256 "9b2d2703083f9c6ca65543ac3ef73528b642515620487e80dd0d914810c2912c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.3/oc-go-cc_linux-amd64"
      sha256 "efdc1b72be6ffa1309d65829bc065c1cd5aea59a22e5f0e6026b11c0f016d371"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.3/oc-go-cc_linux-arm64"
      sha256 "3a359a56ea151b240e724f1e1511fc6791f7ea6b5026fbd826113d3f05763a05"
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
