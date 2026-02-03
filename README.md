# Ralph Wiggum

**Autonomous AI Coding Loop powered by Claude Code CLI**

[![Version](https://img.shields.io/badge/version-1.3.0-blue.svg)](https://github.com/CorepanyDev/homebrew-ralph/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Ralph Wiggum is a CLI tool that runs Claude Code in an autonomous loop, working through a Product Requirements Document (PRD) one feature at a time. It reads your requirements, implements them, verifies the work, and commits changes—all without manual intervention.

## Quick Start

### Install with curl (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/CorepanyDev/homebrew-ralph/main/install.sh | bash
```

### Install with Homebrew

```bash
brew tap CorepanyDev/homebrew-ralph
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
curl -fsSL https://raw.githubusercontent.com/CorepanyDev/homebrew-ralph/main/install.sh | bash
```

This will:

- Download ralph to `~/.local/bin`
- Add the directory to your PATH if needed
- Make ralph executable

You can customize the install location:

```bash
RALPH_INSTALL_DIR=/usr/local/bin curl -fsSL https://raw.githubusercontent.com/CorepanyDev/homebrew-ralph/main/install.sh | bash
```

### Homebrew

For macOS and Linux users with Homebrew:

```bash
brew tap CorepanyDev/homebrew-ralph
brew install ralph
```

### Manual Installation

Clone the repository and copy the script to your PATH:

```bash
git clone https://github.com/CorepanyDev/homebrew-ralph.git
cp ralph/bin/ralph ~/.local/bin/
chmod +x ~/.local/bin/ralph
```

Or install system-wide:

```bash
git clone https://github.com/CorepanyDev/homebrew-ralph.git
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

> **Note:** These template files are local workflow files and are not committed to git by Ralph. You can use `ralph --clean` to remove them when you're done.

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

| Command               | Description                                                        |
| --------------------- | ------------------------------------------------------------------ |
| `ralph <n>`           | Run ralph for n iterations, working through the PRD                |
| `ralph --once`        | Run single iteration interactively                                 |
| `ralph --init`        | Create template files (prd.json, progress.txt, project-request.md) |
| `ralph --reset`       | Reset template files to initial state                              |
| `ralph --clean`       | Remove all Ralph template files                                    |
| `ralph --plan [desc]` | Generate PRD from project-request.md or inline description         |
| `ralph --update`      | Check for and install updates (or show Homebrew instructions)      |
| `ralph --version`     | Display the current version                                        |
| `ralph --help`        | Show help message with usage information                           |

## Workflow

```
┌─────────────────────┐
│  project-request.md │  Your project description
└──────────┬──────────┘
           │
           ▼
    ┌──────────────┐
    │ ralph --plan │  Generate PRD from requirements
    └──────┬───────┘
           │
           ▼
    ┌──────────────┐
    │   prd.json   │  Product Requirements Document
    └──────┬───────┘
           │
           ▼
    ┌──────────────┐
    │   ralph <n>  │  Run iteration loop
    └──────┬───────┘
           │
           ▼
┌──────────────────────────────────────────────────┐
│                  Iteration Loop                   │
│  ┌────────────────────────────────────────────┐  │
│  │ 1. Read prd.json + progress.txt            │  │
│  │ 2. Pick highest priority incomplete task   │  │
│  │ 3. Implement the feature                   │  │
│  │ 4. Run tests and verification              │  │
│  │ 5. Update prd.json (passes: true)          │  │
│  │ 6. Append to progress.txt                  │  │
│  │ 7. Git commit                              │  │
│  └────────────────────────────────────────────┘  │
│                       │                           │
│         ┌─────────────┼─────────────┐             │
│         ▼             ▼             ▼             │
│   ┌──────────┐  ┌──────────┐  ┌──────────┐       │
│   │ COMPLETE │  │NEEDS_HELP│  │ MAX ITER │       │
│   └──────────┘  └──────────┘  └──────────┘       │
└──────────────────────────────────────────────────┘
```

## PRD Format

Ralph uses a JSON-based Product Requirements Document (PRD) to track tasks. Each item in the PRD represents a single, atomic feature to implement.

### Example PRD Structure

```json
[
  {
    "id": 1,
    "description": "Add user authentication with email and password",
    "acceptance_criteria": [
      "Users can sign up with email and password",
      "Users can log in with valid credentials",
      "Invalid credentials show error message",
      "Passwords are hashed before storage"
    ],
    "passes": false
  },
  {
    "id": 2,
    "description": "Create todo list CRUD operations",
    "acceptance_criteria": [
      "Users can create new todo items",
      "Users can view their todo list",
      "Users can mark todos as complete",
      "Users can delete todos"
    ],
    "passes": false
  }
]
```

### PRD Fields

| Field                 | Type    | Description                                                   |
| --------------------- | ------- | ------------------------------------------------------------- |
| `id`                  | number  | Unique identifier for the task                                |
| `description`         | string  | Brief description of what to implement                        |
| `acceptance_criteria` | array   | List of criteria that must be met for the task to be complete |
| `passes`              | boolean | Whether the task has been completed (`true` when done)        |

### How Ralph Uses the PRD

1. **Task Selection**: Ralph reads all tasks with `passes: false` and selects the highest priority one based on dependencies and logical order
2. **Implementation**: Implements the feature following best practices for the language/framework in use
3. **Verification**: Runs tests and type checking to ensure acceptance criteria are met
4. **Completion**: Sets `passes: true` in the PRD when all criteria are satisfied
5. **Progress Logging**: Appends notes about what was done to `progress.txt`

## Updating

### curl Installation

Update to the latest version using the built-in update command:

```bash
ralph --update
```

This will:

- Check the latest version from GitHub
- Compare with your current version
- Download and replace the script if a newer version is available

### Homebrew Installation

If you installed ralph via Homebrew, use:

```bash
brew upgrade ralph
```

Ralph will detect Homebrew installations and remind you to use `brew upgrade` instead of the self-update feature.

## Uninstalling

### curl Installation

Remove ralph by deleting the script:

```bash
rm ~/.local/bin/ralph
```

Or if you installed to a custom location:

```bash
rm /path/to/your/ralph
```

You can also use the uninstall script:

```bash
curl -fsSL https://raw.githubusercontent.com/CorepanyDev/homebrew-ralph/main/uninstall.sh | bash
```

### Homebrew Installation

```bash
brew uninstall ralph
```

## Resources

- [Tips for AI Coding with Ralph Wiggum](https://www.aihero.dev/tips-for-ai-coding-with-ralph-wiggum) - Best practices and workflow tips
- [Claude Code CLI Documentation](https://docs.anthropic.com/en/docs/claude-code) - Official documentation for the underlying AI assistant
- [GitHub Repository](https://github.com/CorepanyDev/homebrew-ralph) - Source code, issues, and releases

## License

MIT License - see [LICENSE](LICENSE) for details.
