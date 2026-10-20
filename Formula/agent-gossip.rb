class AgentGossip < Formula
  desc "mesh network for agents"
  homepage "https://github.com/agent-habilis/agent-gossip"
  license "MIT"
  version "0.12.6"

  # The release workflow rewrites every version and digest below, matching a
  # `sha256` line only where it directly follows its `url`. Nothing may be put
  # between the two, or that pair keeps its stale digest through the bump and
  # ships a formula that cannot verify.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-gossip/releases/download/v#{version}/agent-gossip-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "e3d6ed7473b6fab31d9c2a5fce8d64cf35923bbd272e3a239c86817f24dec08b"
    else
      url "https://github.com/agent-habilis/agent-gossip/releases/download/v#{version}/agent-gossip-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "d010a74f474df273df4b1dbb3bfe3d3c65b2c07a0842fc56b3b8f7e82d08f615"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/agent-habilis/agent-gossip/releases/download/v#{version}/agent-gossip-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aecf2c8f639960b200a988a95692b97c45631ed48df07935bc8d37caace63044"
    elsif Hardware::CPU.arm?
      url "https://github.com/agent-habilis/agent-gossip/releases/download/v#{version}/agent-gossip-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0f6b79921080597009526dbb404be635171113c9ed6012286e4e835190c08d88"
    end
  end

  def install
    bin.install "agent-gossip"
    man1.install Dir["man/*.1"]
  end

  # `plug` cannot run from `install` or `post_install`: both are sandboxed with
  # `deny_read_home` and no write path into `$HOME`, so it could not even detect
  # which harnesses are on the machine. It stays the user's step.
  def caveats
    <<~EOS
      Install the skills into every harness detected on this machine:
      ! agent-gossip plug

      Then check the setup with:
      ! agent-gossip doctor
    EOS
  end

  test do
    assert_match "agent-gossip", shell_output("#{bin}/agent-gossip --version")
  end
end
