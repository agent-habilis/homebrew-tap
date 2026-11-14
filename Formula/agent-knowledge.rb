class AgentKnowledge < Formula
  desc "Share a folder over habilis-network with live two-way sync"
  homepage "https://github.com/agent-habilis/agent-knowledge"
  license "BUSL-1.1"
  version "0.1.0"

  # The release workflow rewrites every version and digest below, matching a
  # `sha256` line only where it directly follows its `url`. Nothing may be put
  # between the two, or that pair keeps its stale digest through the bump and
  # ships a formula that cannot verify. The zero digests are placeholders until
  # the first release writes the real ones.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-knowledge/releases/download/v#{version}/agent-knowledge-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/agent-habilis/agent-knowledge/releases/download/v#{version}/agent-knowledge-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/agent-habilis/agent-knowledge/releases/download/v#{version}/agent-knowledge-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    elsif Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-knowledge/releases/download/v#{version}/agent-knowledge-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "agent-knowledge"
  end

  # `plug` cannot run from `install` or `post_install`: both are sandboxed with
  # no write path into `$HOME`, so it could not detect the harnesses on the
  # machine. It stays the user's step.
  def caveats
    <<~EOS
      Install the skills into every harness detected on this machine:
      ! agent-knowledge plug
    EOS
  end

  test do
    assert_match "agent-knowledge", shell_output("#{bin}/agent-knowledge --version")
  end
end
