#!/usr/bin/env bash
set -euo pipefail

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
DOTFILES_DIR="${REPO_ROOT}/dotfiles"
MODULE="claude"
TARGET="${HOME}"

# Verify dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Dotfiles directory not found at $DOTFILES_DIR"
    exit 1
fi

# Verify module exists
if [ ! -d "$DOTFILES_DIR/$MODULE" ]; then
    echo "Error: Module $MODULE not found in $DOTFILES_DIR"
    exit 1
fi

# Check if CLAUDE.md exists and is NOT a symlink
if [ -f "${TARGET}/.claude/CLAUDE.md" ] && [ ! -L "${TARGET}/.claude/CLAUDE.md" ]; then
    echo "Backing up existing CLAUDE.md..."
    BACKUP_NAME="${TARGET}/.claude/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
    mv "${TARGET}/.claude/CLAUDE.md" "$BACKUP_NAME"
    echo "Backup created: $BACKUP_NAME"
fi

# Execute stow
echo "Running stow for $MODULE..."
echo "Source: $DOTFILES_DIR"
echo "Target: $TARGET"
stow -d "$DOTFILES_DIR" -t "$TARGET" "$MODULE"

# Validate symlink was created
if [ -L "${TARGET}/.claude/CLAUDE.md" ]; then
    echo "✓ Symlink created successfully"
    ls -la "${TARGET}/.claude/CLAUDE.md"
else
    echo "✗ Error: stow failed to create symlink"
    exit 1
fi
