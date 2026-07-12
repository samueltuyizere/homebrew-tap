class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.5.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.5.2/routatic-proxy_darwin-arm64"
      sha256 "65b9dc27dccf4c261fdc01acfec9377a800cfdb500a0af5c77ecb02dde10d75c"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.5.2/routatic-proxy_darwin-amd64"
      sha256 "d745b921eb3ac4456ddaf82ba82b132674f32e10b3c289c593c10443cf1ef718"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.5.2/routatic-proxy_linux-amd64"
      sha256 "3f7cf67d2ccf08ab1092ed4006988b16754ecf869ce9c51bbb0e8f34af542f52"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.5.2/routatic-proxy_linux-arm64"
      sha256 "1d45301a0c268b97c9c0f877af145f2c24be86f271a5e98b59f18f84c09cb11a"
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
