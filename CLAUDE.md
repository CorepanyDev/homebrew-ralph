# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Ralph Wiggum is an autonomous AI coding loop CLI tool that runs Claude Code iteratively to work through a Product Requirements Document (PRD). It reads requirements from `prd.json`, implements features one at a time, verifies work through tests, updates progress in `progress.txt`, and commits changes automatically.

## Repository Structure

- `bin/ralph` - The main bash script (single-file CLI tool)
- `Formula/ralph.rb` - Homebrew formula for tap installation
- `install.sh` - curl-based installation script
- `uninstall.sh` - Removal script

## Commands

```bash
# Run the script locally during development
./bin/ralph --help
./bin/ralph --version

# Test iteration workflow (requires prd.json in current directory)
./bin/ralph --init      # Create template files
./bin/ralph --plan      # Generate PRD from project-request.md
./bin/ralph 5           # Run 5 iterations
./bin/ralph --once      # Single interactive iteration

# Test Homebrew formula locally
brew install --build-from-source Formula/ralph.rb
brew test ralph
```

## Architecture

The tool is a single bash script with these key components:

1. **Template Management** (`init_templates`, `reset_templates`, `clean_templates`) - Creates/resets the working files: `prd.json`, `progress.txt`, `project-request.md`

2. **PRD Planning** (`--plan` flag) - Invokes Claude in plan mode to generate a structured PRD from natural language requirements

3. **Iteration Loop** (main logic) - Executes Claude Code with `--dangerously-skip-permissions` in a loop, each iteration:
   - Reads PRD and progress files
   - Works on highest priority incomplete task
   - Updates PRD (`passes: true`) and appends to progress log
   - Commits changes to git

4. **Completion Detection** - Monitors Claude's output for `RALPH_COMPLETE` (all done) or `RALPH_NEEDS_HELP` (stuck) signals

5. **Self-Update** (`--update` flag) - Fetches latest version from GitHub, detects Homebrew installs

## Key Files Modified During Runtime

Ralph creates these files in the user's project directory (not in this repo):
- `prd.json` - JSON array of tasks with `id`, `description`, `acceptance_criteria`, `passes` fields
- `progress.txt` - Cumulative log of completed work and learnings
- `project-request.md` - User's project description for PRD generation

## Release Process

### Files to Update When Bumping Version

When releasing a new version, update these files in order:

1. **`bin/ralph`** (line 5)
   ```bash
   RALPH_VERSION='X.Y.Z'
   ```

2. **`Formula/ralph.rb`** (line 4)
   ```ruby
   url "https://github.com/CorepanyDev/homebrew-ralph/archive/refs/tags/vX.Y.Z.tar.gz"
   ```
   Note: The sha256 is computed after the GitHub release is created

3. **`README.md`** (line 5) - Version badge
   ```markdown
   [![Version](https://img.shields.io/badge/version-X.Y.Z-blue.svg)]
   ```

4. **`CHANGELOG.md`** - Add new version section at top and link at bottom
   ```markdown
   ## [X.Y.Z] - YYYY-MM-DD
   ### Added/Changed/Fixed
   - Description of changes

   ...

   [X.Y.Z]: https://github.com/CorepanyDev/homebrew-ralph/releases/tag/vX.Y.Z
   ```

### Release Steps

1. Update all version references listed above
2. Commit changes: `git commit -m "Bump version to vX.Y.Z"`
3. Push to main: `git push origin main`
4. Create GitHub release with tag `vX.Y.Z`
5. After release is created, update `Formula/ralph.rb` with the sha256:
   ```bash
   curl -sL https://github.com/CorepanyDev/homebrew-ralph/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256
   ```
6. Commit and push the sha256 update
