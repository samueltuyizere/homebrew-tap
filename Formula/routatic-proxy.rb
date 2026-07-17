class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.6.1/routatic-proxy_darwin-arm64"
      sha256 "77cdd109813c00c2f2946a40cd5eff02bb16f71584720cb2f5b49884186f3d19"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.1/routatic-proxy_darwin-amd64"
      sha256 "6519f597441caa6d401e180a6bb70f2a9e7a24bbd7195e5c2d8482b66c2aabe2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.6.1/routatic-proxy_linux-amd64"
      sha256 "b4344e4a79eedcc5e00a6b6b57ebe8b8dceb15eed0c48fc3b339d7b073c2bcb3"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.1/routatic-proxy_linux-arm64"
      sha256 "63bbea490844fcb3f943eba1fa41c3132e4258b2effa3692faa11222ade5ef5d"
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
