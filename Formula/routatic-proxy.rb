class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.6.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.6.2/routatic-proxy_darwin-arm64"
      sha256 "8410b431cde25ed33e93e9a5fd35efdc9be07e3fbc27d73e81a5b81a945b0a88"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.2/routatic-proxy_darwin-amd64"
      sha256 "608dab0c1cfebf3829c85454915cab74229f696654288bc879b095c5f1ea8fa3"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.6.2/routatic-proxy_linux-amd64"
      sha256 "a10e828723365984c777fd6ca256f38e4fdc3fbf4a512c6eb823f632c1dd47c1"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.2/routatic-proxy_linux-arm64"
      sha256 "657c82f015a09429bfeb933eee7dcb89d5e8202e9c4325580925d0d0651e5d25"
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
