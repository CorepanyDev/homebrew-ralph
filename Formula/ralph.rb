class Ralph < Formula
  desc "Autonomous AI coding loop powered by Claude Code CLI"
  homepage "https://github.com/CorepanyDev/homebrew-ralph"
  url "https://github.com/CorepanyDev/homebrew-ralph/archive/refs/tags/v1.2.0.tar.gz"
  license "MIT"

  def install
    bin.install "bin/ralph"
  end

  def caveats
    <<~EOS
      Ralph requires Claude Code CLI to function.

      Install Claude Code CLI:
        https://docs.anthropic.com/en/docs/claude-code/getting-started

      Quick start:
        ralph --init     # Initialize project files
        ralph --plan     # Generate PRD from project-request.md
        ralph 10         # Run 10 autonomous iterations
    EOS
  end

  test do
    assert_match "Ralph Wiggum", shell_output("#{bin}/ralph --help")
    assert_match version.to_s, shell_output("#{bin}/ralph --version")
  end
end
