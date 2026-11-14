class AgentKnowledge < Formula
  desc "Share a folder over habilis-network with live two-way sync"
  homepage "https://github.com/agent-habilis/agent-knowledge"
  license "BUSL-1.1"
  version "0.1.1"

  # The release workflow rewrites every version and digest below, matching a
  # `sha256` line only where it directly follows its `url`. Nothing may be put
  # between the two, or that pair keeps its stale digest through the bump and
  # ships a formula that cannot verify. The zero digests are placeholders until
  # the first release writes the real ones.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-knowledge/releases/download/v#{version}/agent-knowledge-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "78396023cc25a70ee8f956703597529c7a94379ecbe1d63fe33c3fd1d8aaaf6f"
    else
      url "https://github.com/agent-habilis/agent-knowledge/releases/download/v#{version}/agent-knowledge-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "b01e348d8e68759c64add52b5e72beb6abf07b87d65d2fd15486cccf7c592d81"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/agent-habilis/agent-knowledge/releases/download/v#{version}/agent-knowledge-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e6dff92ee6b9a32a298f451a713eb6b51baf93ad19d912d920cb3b40ec55bcba"
    elsif Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-knowledge/releases/download/v#{version}/agent-knowledge-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cdb88682cdb5452c516a7eb217a3923fd3d78d0fb92df7d08d279d0fd862a839"
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
