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

## Usage

### Initialize a Project

Start by creating template files for your project:

```bash
ralph --init
```

This creates:
- `prd.json` - The Product Requirements Document with example tasks
- `progress.txt` - A log file for tracking learnings across iterations
- `project-request.md` - A template for describing your project idea

### Generate a PRD

Use `--plan` to generate a PRD from your project description:

**From a file (recommended for complex projects):**
```bash
# Edit project-request.md with your project idea, then:
ralph --plan
```

**Inline for quick projects:**
```bash
ralph --plan "Build a REST API for a todo app with user authentication"
```

The planning mode uses Claude to:
1. Read any existing `CLAUDE.md` for project context
2. Break down your requirements into small, atomic tasks
3. Generate acceptance criteria for each task
4. Output a properly ordered `prd.json`

### Run Iterations

Once you have a `prd.json`, run ralph with a maximum number of iterations:

```bash
ralph 10
```

Each iteration:
1. Reads `prd.json` and `progress.txt`
2. Picks the highest priority incomplete task
3. Implements the feature following project conventions
4. Runs tests and type checking
5. Updates the PRD (marks task as complete)
6. Appends notes to `progress.txt`
7. Commits changes to git

Ralph continues until:
- All tasks are complete (`RALPH_COMPLETE`)
- Human help is needed (`RALPH_NEEDS_HELP`)
- Maximum iterations reached

## Commands

| Command | Description |
|---------|-------------|
| `ralph <n>` | Run ralph for n iterations, working through the PRD |
| `ralph --init` | Create template files (prd.json, progress.txt, project-request.md) |
| `ralph --plan [desc]` | Generate PRD from project-request.md or inline description |
| `ralph --update` | Check for and install updates (or show Homebrew instructions) |
| `ralph --version` | Display the current version |
| `ralph --help` | Show help message with usage information |
