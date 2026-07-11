class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.5.1/routatic-proxy_darwin-arm64"
      sha256 "730d353712efe998cce530c9aaf7fb02eb85189c1e51b0bbb7e27c7315b88817"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.5.1/routatic-proxy_darwin-amd64"
      sha256 "fabc7d0b1ec3eff9b4773297bf628959f1fa068eb8cee05625cd40a5dcef9d13"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.5.1/routatic-proxy_linux-amd64"
      sha256 "19fa94de0fba715b7e499685caa894f8933a8b5a4ef51d001b65fe94296f1e35"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.5.1/routatic-proxy_linux-arm64"
      sha256 "b5a17a4361de8d907e151f5fbcb453e58343556107207234eb5ab99f7e7bf7bb"
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
