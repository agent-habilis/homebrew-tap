class AgentGraph < Formula
  desc "find, print, and draw graphs of agents"
  homepage "https://github.com/agent-habilis/agent-graph"
  license "MIT"
  version "0.1.1"

  # The release workflow rewrites every version and digest below, matching a
  # `sha256` line only where it directly follows its `url`. Nothing may be put
  # between the two, or that pair keeps its stale digest through the bump and
  # ships a formula that cannot verify.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-graph/releases/download/v#{version}/agent-graph-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "259c4d130ffbb8be1cc0441b31f818107b6fef9e20283b2ce1bb8f70472739a9"
    else
      url "https://github.com/agent-habilis/agent-graph/releases/download/v#{version}/agent-graph-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "55aae6999bf44d5f69f33484cacba41a3c5c6da8e7488adda5eb672049c80e1c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/agent-habilis/agent-graph/releases/download/v#{version}/agent-graph-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eda0937043d4857df4bff0caa8a2cadd3507f46232d6d570c98c2e5ec696c692"
    elsif Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-graph/releases/download/v#{version}/agent-graph-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f257b212a116862fa44781268dcff9a12a686a5b7f59590c82a9eb7f3b6d7e18"
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
