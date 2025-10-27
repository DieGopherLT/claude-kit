#!/usr/bin/env fish

# Get the directory where this script lives
set SCRIPT_DIR (dirname (status --current-filename))
set REPO_ROOT (dirname $SCRIPT_DIR)
set DOTFILES_DIR "$REPO_ROOT/dotfiles"
set MODULE "claude"
set TARGET "$HOME"

# Verify dotfiles directory exists
if not test -d $DOTFILES_DIR
    echo "Error: Dotfiles directory not found at $DOTFILES_DIR"
    exit 1
end

# Verify module exists
if not test -d "$DOTFILES_DIR/$MODULE"
    echo "Error: Module $MODULE not found in $DOTFILES_DIR"
    exit 1
end

# Check if CLAUDE.md exists and is NOT a symlink
if test -f "$TARGET/.claude/CLAUDE.md" -a ! -L "$TARGET/.claude/CLAUDE.md"
    echo "Backing up existing CLAUDE.md..."
    set BACKUP_NAME "$TARGET/.claude/CLAUDE.md.backup."(date +%Y%m%d_%H%M%S)
    mv "$TARGET/.claude/CLAUDE.md" $BACKUP_NAME
    echo "Backup created: $BACKUP_NAME"
end

# Execute stow
echo "Running stow for $MODULE..."
echo "Source: $DOTFILES_DIR"
echo "Target: $TARGET"
stow -d $DOTFILES_DIR -t $TARGET $MODULE

# Validate symlink was created
if test -L "$TARGET/.claude/CLAUDE.md"
    echo "✓ Symlink created successfully"
    ls -la "$TARGET/.claude/CLAUDE.md"
else
    echo "✗ Error: stow failed to create symlink"
    exit 1
end
