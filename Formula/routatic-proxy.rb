class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.6.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.6.4/routatic-proxy_darwin-arm64"
      sha256 "9ec3ead8080e5a509dfdb64d41670155c39cd6823e9ff6aec4799bae2d3cff49"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.4/routatic-proxy_darwin-amd64"
      sha256 "8a9d130195df3eea722d07e21b6fd78f16d6074c0cc0a11f89e895b43e193f77"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.6.4/routatic-proxy_linux-amd64"
      sha256 "4867220f54b2ed48e2fcfe0a6bd4d42b13d098729e71cb50c3ea78fd4a185de9"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.4/routatic-proxy_linux-arm64"
      sha256 "7940c341492666f45c2d9988154a2656f291cd547c8ba5fdc41bbbf517e5ee31"
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
