class Ralph < Formula
  desc "Autonomous AI coding loop powered by Claude Code CLI"
  homepage "https://github.com/CorepanyDev/homebrew-ralph"
  url "https://github.com/CorepanyDev/homebrew-ralph/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "b6e64ff4703c85a0605f08def65c32517c3ef1a1e44833eb3bc27cd5eb466078"
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
        ralph --once     # Single interactive iteration
        ralph --clean    # Remove template files when done
    EOS
  end

  test do
    assert_match "Ralph Wiggum", shell_output("#{bin}/ralph --help")
    assert_match version.to_s, shell_output("#{bin}/ralph --version")
  end
end
