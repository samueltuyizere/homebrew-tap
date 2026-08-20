class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.6.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.6.3/routatic-proxy_darwin-arm64"
      sha256 "db521d2e242b35ddc419a5324e062f48cd900e830b1ea51a19dfeaa2bf3d941a"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.3/routatic-proxy_darwin-amd64"
      sha256 "0c38f7e0d8c66655685bd628d4f1750f7682a4e75754e892fd68f20e17fe781d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.6.3/routatic-proxy_linux-amd64"
      sha256 "be864867efca60a39f848d198458e4d57d66e4885441b50b2b4e39534c90de11"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.6.3/routatic-proxy_linux-arm64"
      sha256 "11bfd0eae4674574e05c57cefd0797e0be750fc95f352db619f7b653782b5b42"
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
