#!/bin/bash
# Ralph Wiggum - Install Script
# Downloads and installs ralph to your system
set -e

# Configuration
RALPH_REPO='CorepanyDev/ralph'
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

# Get the latest version from GitHub API
get_latest_version() {
    local latest_version
    latest_version=$(curl -s "https://api.github.com/repos/${RALPH_REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    if [ -z "$latest_version" ]; then
        # Fallback: try to get from tags if no releases
        latest_version=$(curl -s "https://api.github.com/repos/${RALPH_REPO}/tags" | grep '"name":' | head -1 | sed -E 's/.*"v?([^"]+)".*/\1/')
    fi
    echo "$latest_version"
}

# Download ralph to the install directory
download_ralph() {
    local version="$1"
    local download_url="https://raw.githubusercontent.com/${RALPH_REPO}/v${version}/bin/ralph"
    local dest="${INSTALL_DIR}/ralph"

    echo -e "${BLUE}Downloading ralph v${version}...${NC}"

    # Create install directory if it doesn't exist
    if [ ! -d "$INSTALL_DIR" ]; then
        mkdir -p "$INSTALL_DIR"
        echo -e "  Created directory: ${INSTALL_DIR}"
    fi

    # Download the script
    if ! curl -fsSL "$download_url" -o "$dest" 2>/dev/null; then
        echo -e "${RED}Error: Failed to download ralph from GitHub.${NC}"
        echo "URL: $download_url"
        exit 1
    fi

    # Verify the downloaded file
    if [ ! -s "$dest" ] || ! head -1 "$dest" | grep -q "^#!/"; then
        rm -f "$dest"
        echo -e "${RED}Error: Downloaded file appears to be invalid.${NC}"
        exit 1
    fi

    # Make it executable
    chmod +x "$dest"
    echo -e "  ${GREEN}✓${NC} Downloaded to ${dest}"
}

# Setup PATH in shell configuration
setup_path() {
    local shell_name="$1"
    local shell_config=""

    # Determine the shell config file
    case "$shell_name" in
        zsh)
            shell_config="$HOME/.zshrc"
            ;;
        bash)
            # Use .bashrc for Linux, .bash_profile for macOS
            if [ -f "$HOME/.bashrc" ]; then
                shell_config="$HOME/.bashrc"
            else
                shell_config="$HOME/.bash_profile"
            fi
            ;;
        fish)
            shell_config="$HOME/.config/fish/config.fish"
            ;;
        *)
            shell_config="$HOME/.profile"
            ;;
    esac

    # Check if INSTALL_DIR is already in PATH
    if echo "$PATH" | grep -q "$INSTALL_DIR"; then
        echo -e "  ${GREEN}✓${NC} ${INSTALL_DIR} is already in PATH"
        return 0
    fi

    # Check if the PATH export already exists in the config file
    if [ -f "$shell_config" ] && grep -q "export PATH=.*${INSTALL_DIR}" "$shell_config" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} PATH entry already exists in ${shell_config}"
        return 0
    fi

    # Add PATH export to shell config
    echo "" >> "$shell_config"
    echo "# Added by ralph installer" >> "$shell_config"

    if [ "$shell_name" = "fish" ]; then
        # Fish shell uses different syntax
        echo "set -gx PATH \"\$HOME/.local/bin\" \$PATH" >> "$shell_config"
    else
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$shell_config"
    fi

    echo -e "  ${GREEN}✓${NC} Added ${INSTALL_DIR} to PATH in ${shell_config}"
    echo -e "  ${YELLOW}Note:${NC} Run 'source ${shell_config}' or restart your shell to use ralph"
}

# Ensure install directory exists
ensure_install_dir() {
    if [ ! -d "$INSTALL_DIR" ]; then
        mkdir -p "$INSTALL_DIR"
        echo -e "  Created directory: ${INSTALL_DIR}"
    fi
}

# Display installation banner
show_banner() {
    echo ""
    echo -e "${BLUE}╔═══════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}                                                   ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}   ${GREEN}Ralph Wiggum${NC} - Autonomous AI Coding Loop      ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}                                                   ${BLUE}║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Display success message with quick start commands
show_success() {
    local version="$1"
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}                                                   ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}   ${GREEN}✓${NC} Installation complete!                        ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                   ${GREEN}║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  Installed version: ${GREEN}v${version}${NC}"
    echo ""
    echo -e "${BLUE}Quick Start:${NC}"
    echo "  ralph --help      Show all available commands"
    echo "  ralph --init      Initialize a new project"
    echo "  ralph --plan      Generate a PRD from project-request.md"
    echo ""
}

# Main function
main() {
    show_banner

    echo -e "${BLUE}Installing Ralph Wiggum...${NC}"
    echo ""

    # Step 1: Detect OS
    local os
    os=$(detect_os)
    echo -e "  ${GREEN}✓${NC} Detected OS: ${os}"

    # Step 2: Check dependencies
    check_dependencies
    echo ""

    # Step 3: Ensure install directory exists
    ensure_install_dir

    # Step 4: Get latest version and download
    echo -e "${BLUE}Fetching latest version...${NC}"
    local version
    version=$(get_latest_version)
    if [ -z "$version" ]; then
        echo -e "${RED}Error: Could not determine latest version from GitHub.${NC}"
        exit 1
    fi
    echo -e "  ${GREEN}✓${NC} Latest version: v${version}"
    echo ""

    # Step 5: Download ralph
    download_ralph "$version"
    echo ""

    # Step 6: Setup PATH
    echo -e "${BLUE}Configuring PATH...${NC}"
    local shell_name
    shell_name=$(detect_shell)
    setup_path "$shell_name"
    echo ""

    # Step 7: Show success message
    show_success "$version"
}

# Run main
main "$@"
