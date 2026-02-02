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

## Requirements

- **[Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code)** - The AI coding assistant that powers ralph
- **Git** - For version control and committing changes
- **macOS or Linux** - Windows is not currently supported

## Installation

### curl (Recommended)

The quickest way to install ralph:

```bash
curl -fsSL https://raw.githubusercontent.com/Corepany/ralph/main/install.sh | bash
```

This will:
- Download ralph to `~/.local/bin`
- Add the directory to your PATH if needed
- Make ralph executable

You can customize the install location:

```bash
RALPH_INSTALL_DIR=/usr/local/bin curl -fsSL https://raw.githubusercontent.com/Corepany/ralph/main/install.sh | bash
```

### Homebrew

For macOS and Linux users with Homebrew:

```bash
brew tap Corepany/ralph
brew install ralph
```

### Manual Installation

Clone the repository and copy the script to your PATH:

```bash
git clone https://github.com/Corepany/ralph.git
cp ralph/bin/ralph ~/.local/bin/
chmod +x ~/.local/bin/ralph
```

Or install system-wide:

```bash
git clone https://github.com/Corepany/ralph.git
sudo cp ralph/bin/ralph /usr/local/bin/
sudo chmod +x /usr/local/bin/ralph
```
