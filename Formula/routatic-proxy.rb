class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.5.0/routatic-proxy_darwin-arm64"
      sha256 "ca10869114f14b639517fc0591f41eabbc47b46d76cb11282811ebf50443a513"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.5.0/routatic-proxy_darwin-amd64"
      sha256 "635b6c116c55fa60db839aefc79e3fb1e2f4cd9d0df58ce2679dbc1958393e6f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.5.0/routatic-proxy_linux-amd64"
      sha256 "90da9b406126f4af63519499749a6070c6c5d899bc4d7a615b57fb2fa4d3e20f"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.5.0/routatic-proxy_linux-arm64"
      sha256 "1b9ff58059e32722ac43460082b4a565bcba4ef2ad7af0ade5af56c0345f1883"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "routatic-proxy_darwin-arm64" => "routatic-proxy"
    elsif OS.mac?
      bin.install "routatic-proxy_darwin-amd64" => "routatic-proxy"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "routatic-proxy_linux-amd64" => "routatic-proxy"
    else
      bin.install "routatic-proxy_linux-arm64" => "routatic-proxy"
    end
    bin.install_symlink bin/"routatic-proxy" => "oc-go-cc"
  end

  def caveats
    <<~EOS
      To get started with routatic-proxy:

        1. Initialize configuration:
           routatic-proxy init

        2. Set your OpenCode Go API key:
           export ROUTATIC_PROXY_API_KEY=sk-opencode-your-key

        3. Start the proxy:
           routatic-proxy serve

        4. Configure Claude Code:
           export ANTHROPIC_BASE_URL=http://127.0.0.1:3456
           export ANTHROPIC_AUTH_TOKEN=unused

        5. Run Claude Code:
           claude
    EOS
  end

  test do
    system "#{bin}/routatic-proxy", "--version"
    system "#{bin}/oc-go-cc", "--version"
  end
end
