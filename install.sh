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
