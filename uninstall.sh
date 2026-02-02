#!/bin/bash
# Ralph Wiggum - Uninstall Script
# Removes ralph from your system
set -e

# Configuration
INSTALL_DIR="${RALPH_INSTALL_DIR:-$HOME/.local/bin}"

# Colors for output (matching ralph's colors)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Display uninstall banner
show_banner() {
    echo ""
    echo -e "${BLUE}╔═══════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}                                                   ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}   ${YELLOW}Ralph Wiggum${NC} - Uninstaller                     ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}                                                   ${BLUE}║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Display success message
show_success() {
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}                                                   ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}   ${GREEN}✓${NC} Ralph has been successfully uninstalled!      ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                   ${GREEN}║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Note:${NC} PATH entries in your shell config were not removed."
    echo "  You can manually remove the ralph PATH entry if desired."
    echo ""
}

# Main function
main() {
    show_banner

    local ralph_path="${INSTALL_DIR}/ralph"

    # Check if ralph exists
    if [ ! -f "$ralph_path" ]; then
        echo -e "${YELLOW}Ralph is not installed at ${ralph_path}${NC}"
        echo ""
        echo "If you installed ralph via Homebrew, use:"
        echo "  brew uninstall ralph"
        echo ""
        exit 0
    fi

    echo -e "${BLUE}Found ralph at:${NC} ${ralph_path}"
    echo ""

    # Remove ralph
    if rm -f "$ralph_path"; then
        show_success
    else
        echo -e "${RED}Error: Failed to remove ralph.${NC}"
        echo "You may need to run this script with sudo:"
        echo "  sudo ./uninstall.sh"
        exit 1
    fi
}

# Run main
main "$@"
