class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.6.0/routatic-proxy_darwin-arm64"
      sha256 "b0812c34befaa1cd7ba7e4f02a827ad1e7fc4c7f37099d995bf91a89ff4546e7"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.0/routatic-proxy_darwin-amd64"
      sha256 "8894a7a74af18385384e1d6dc904a34a4f98b965e97e637fd3ebcec76352bded"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.6.0/routatic-proxy_linux-amd64"
      sha256 "af5e0bb5f30dda8ae9dec807f1a8d5fa46940e22fcceab769221622459da929d"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.0/routatic-proxy_linux-arm64"
      sha256 "2adee26271d1511dcb1cb20a1d9ebea9d8ad5f0e4581bda78dfe2023b3041259"
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
