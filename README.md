# Ralph Wiggum

**Autonomous AI Coding Loop powered by Claude Code CLI**

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/Corepany/ralph/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Ralph Wiggum is a CLI tool that runs Claude Code in an autonomous loop, working through a Product Requirements Document (PRD) one feature at a time. It reads your requirements, implements them, verifies the work, and commits changes—all without manual intervention.

## Quick Start

### Install with curl (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/Corepany/ralph/main/install.sh | bash
```

### Install with Homebrew

```bash
brew tap Corepany/ralph
brew install ralph
```

### Get Started

```bash
# Show help
ralph --help

# Initialize a new project
ralph --init

# Generate PRD from requirements
ralph --plan "Build a todo app with user authentication"

# Run 5 iterations
ralph 5
```
