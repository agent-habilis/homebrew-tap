class AgentJail < Formula
  desc "Run a command in an OS sandbox with explicit permissions"
  homepage "https://github.com/agent-habilis/agent-jail"
  license "MIT"
  version "0.1.0"

  # The sha256 placeholders below are overwritten by the release workflow's
  # update-formula job on every tagged release (see .github/workflows/release.yml).
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-jail/releases/download/v#{version}/agent-jail-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/agent-habilis/agent-jail/releases/download/v#{version}/agent-jail-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    elsif Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-jail/releases/download/v#{version}/agent-jail-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "agent-jail"
    man1.install Dir["man/*.1"]
  end

  test do
    assert_match "agent-jail", shell_output("#{bin}/agent-jail --version")
  end
end
