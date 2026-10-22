class AgentGraph < Formula
  desc "find, print, and draw graphs of agents"
  homepage "https://github.com/agent-habilis/agent-graph"
  license "MIT"
  version "0.2.0"

  # The release workflow rewrites every version and digest below, matching a
  # `sha256` line only where it directly follows its `url`. Nothing may be put
  # between the two, or that pair keeps its stale digest through the bump and
  # ships a formula that cannot verify.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-graph/releases/download/v#{version}/agent-graph-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "0c2bd212fe43c5f90f5a0840d085bf910dcbe2d770ae92cb503b7abb59ae1311"
    else
      url "https://github.com/agent-habilis/agent-graph/releases/download/v#{version}/agent-graph-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "d24ed8da9551711703ca39a6a0b1ecd3d4a0874ffb8432fa5e434b0c3209446d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/agent-habilis/agent-graph/releases/download/v#{version}/agent-graph-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6772248217b85a4da3891712cb948bdc4a782b70cb2b28cb1c80a015f2fd8ce8"
    elsif Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-graph/releases/download/v#{version}/agent-graph-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d59934a270a4c2a777b7aa1e40745d87f40ae8c2e502f0013fa15986d8deeb4b"
    end
  end

  def install
    bin.install "agent-graph"
  end

  # `plug` cannot run from `install` or `post_install`: both are sandboxed with
  # `deny_read_home` and no write path into `$HOME`, so it could not even detect
  # which harnesses are on the machine. It stays the user's step.
  def caveats
    <<~EOS
      Install the skills into every agent detected on this machine:
      ! agent-graph plug
    EOS
  end

  test do
    assert_match "agent-graph", shell_output("#{bin}/agent-graph --version")
  end
end
