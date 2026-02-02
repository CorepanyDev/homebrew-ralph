#!/bin/bash
# Ralph Wiggum - Install Script
# Downloads and installs ralph to your system
set -e

# Configuration
RALPH_REPO='Corepany/ralph'
INSTALL_DIR="${RALPH_INSTALL_DIR:-$HOME/.local/bin}"

# Colors for output (matching ralph's colors)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Detect operating system
detect_os() {
    local os
    case "$(uname -s)" in
        Darwin)
            os="macos"
            ;;
        Linux)
            os="linux"
            ;;
        *)
            echo -e "${RED}Error: Unsupported operating system '$(uname -s)'${NC}"
            echo "Ralph only supports macOS and Linux."
            exit 1
            ;;
    esac
    echo "$os"
}

# Detect user's shell
detect_shell() {
    local shell_name
    shell_name=$(basename "$SHELL")
    echo "$shell_name"
}

# Check for required dependencies
check_dependencies() {
    local missing=0

    echo -e "${BLUE}Checking dependencies...${NC}"

    # Check for git
    if ! command -v git &> /dev/null; then
        echo -e "${YELLOW}Warning: git is not installed${NC}"
        echo "  Git is required for Ralph to function properly."
        echo "  Install: https://git-scm.com/downloads"
        missing=1
    else
        echo -e "  ${GREEN}✓${NC} git found"
    fi

    # Check for Claude CLI
    if ! command -v claude &> /dev/null; then
        echo -e "${YELLOW}Warning: Claude CLI is not installed${NC}"
        echo "  Claude Code CLI is required for Ralph to work."
        echo "  Install: https://docs.anthropic.com/en/docs/claude-code"
        missing=1
    else
        echo -e "  ${GREEN}✓${NC} claude CLI found"
    fi

    # If dependencies are missing, prompt user
    if [ "$missing" -eq 1 ]; then
        echo ""
        echo -e "${YELLOW}Some dependencies are missing.${NC}"
        read -p "Continue anyway? (y/N) " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Installation cancelled."
            exit 0
        fi
    fi
}
