#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="msa-claude-md"
INSTALL_DIR="${HOME}/.claude/skills/${SKILL_NAME}"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!!]${NC} $1"; }
error() { echo -e "${RED}[ERR]${NC} $1"; exit 1; }

echo ""
echo "  msa-claude-md installer"
echo "  ========================"
echo ""

# Check prerequisites
command -v git >/dev/null 2>&1 || error "git is required but not installed."

# Check if already installed
if [ -d "$INSTALL_DIR" ]; then
    warn "Already installed at ${INSTALL_DIR}"
    read -rp "  Overwrite? [y/N] " answer
    case "$answer" in
        [yY]*) rm -rf "$INSTALL_DIR" ;;
        *)     echo "  Aborted."; exit 0 ;;
    esac
fi

# Ensure parent directory exists
mkdir -p "$(dirname "$INSTALL_DIR")"

# Detect source: local directory or git clone
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "${SCRIPT_DIR}/SKILL.md" ]; then
    # Local install from cloned repo
    cp -r "$SCRIPT_DIR" "$INSTALL_DIR"
    # Remove git artifacts from installed copy
    rm -rf "${INSTALL_DIR}/.git" "${INSTALL_DIR}/install.sh"
    info "Installed from local directory"
else
    # Remote install via git clone
    REPO_URL="https://github.com/cskwork/msa-claude-md.git"
    git clone --depth 1 "$REPO_URL" "$INSTALL_DIR" 2>/dev/null
    rm -rf "${INSTALL_DIR}/.git" "${INSTALL_DIR}/install.sh"
    info "Cloned from ${REPO_URL}"
fi

info "Installed to ${INSTALL_DIR}"
echo ""
echo "  Usage: In Claude Code, type /msa-claude-md"
echo "  Or ask: \"Generate CLAUDE.md files for this MSA project\""
echo ""
