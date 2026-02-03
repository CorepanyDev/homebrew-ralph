# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0] - 2026-02-03

### Added

- `ralph --clean` (or `-c`) command to remove all Ralph template files
  - Removes prd.json, progress.txt, and project-request.md
  - Lists files to be deleted before prompting for confirmation
  - Shows message if no template files exist

### Changed

- System prompts now instruct Claude to NOT commit Ralph template files (prd.json, progress.txt, project-request.md)
  - These are local workflow files and should not be version controlled
- Updated Homebrew formula caveats to include --once and --clean commands

## [1.2.0] - 2026-02-02

### Added

- `ralph --once` (or `-o`) command for single iteration interactive mode
  - Runs Claude interactively so user can watch implementation in real-time
  - No loop - executes one task and exits
  - Simplified prompt without RALPH_NEEDS_HELP signal (user is watching)

## [1.1.0] - 2026-02-02

### Added

- `ralph --reset` command to revert template files to initial state
  - Resets prd.json, progress.txt, and project-request.md
  - Prompts for confirmation before overwriting existing files

## [1.0.0] - 2025-02-02

### Added

- Initial release of Ralph Wiggum autonomous AI coding loop
- Core iteration workflow: read PRD, work on tasks, verify, commit
- `ralph <n>` command to run n iterations autonomously
- `ralph --init` command to create template files (project-request.md, prd.json, progress.txt)
- `ralph --plan` command to generate PRD from project request using Claude
- `ralph --version` command to display version information
- `ralph --update` command with self-update capability
  - Version comparison with GitHub releases
  - Homebrew installation detection
  - Automatic download and replacement
- `ralph --help` command with usage documentation
- JSON-based PRD format with id, description, acceptance_criteria, and passes fields
- Progress tracking via progress.txt file
- Completion signals: RALPH_COMPLETE and RALPH_NEEDS_HELP
- install.sh script for curl-based installation
  - OS detection (macOS and Linux)
  - Shell detection (bash, zsh, fish)
  - Dependency checking (git, claude CLI)
  - Automatic PATH configuration
- uninstall.sh script for clean removal
- Homebrew formula for tap installation
- Comprehensive documentation in README.md
- MIT License

[1.3.0]: https://github.com/CorepanyDev/homebrew-ralph/releases/tag/v1.3.0
[1.2.0]: https://github.com/CorepanyDev/homebrew-ralph/releases/tag/v1.2.0
[1.1.0]: https://github.com/CorepanyDev/homebrew-ralph/releases/tag/v1.1.0
[1.0.0]: https://github.com/CorepanyDev/homebrew-ralph/releases/tag/v1.0.0
