#!/bin/fish

# Get the directory where this script lives
set SCRIPT_DIR (dirname (status --current-filename))
set REPO_ROOT (dirname $SCRIPT_DIR)
set DOTFILES_DIR "$REPO_ROOT/dotfiles"
set MODULE "claude"
set TARGET "$HOME"
set BACKUP_TIMESTAMP (date +%Y%m%d_%H%M%S)

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

echo "Setting up stow for $MODULE..."
echo "Source: $DOTFILES_DIR"
echo "Target: $TARGET"
echo ""

# Backup and remove existing files (if they exist and are not symlinks)
# This ensures the module version is always used (module is source of truth)

set BACKED_UP 0

# Check CLAUDE.md
if test -f "$TARGET/.claude/CLAUDE.md" -a ! -L "$TARGET/.claude/CLAUDE.md"
    set BACKUP_FILE "$TARGET/.claude/CLAUDE.md.backup.$BACKUP_TIMESTAMP"
    echo "📦 Backing up existing CLAUDE.md..."
    mv "$TARGET/.claude/CLAUDE.md" $BACKUP_FILE
    echo "   Saved to: $BACKUP_FILE"
    set BACKED_UP (math $BACKED_UP + 1)
end

# Check ccstatusline settings
if test -f "$TARGET/.config/ccstatusline/settings.json" -a ! -L "$TARGET/.config/ccstatusline/settings.json"
    set BACKUP_FILE "$TARGET/.config/ccstatusline/settings.json.backup.$BACKUP_TIMESTAMP"
    echo "📦 Backing up existing ccstatusline settings..."
    mv "$TARGET/.config/ccstatusline/settings.json" $BACKUP_FILE
    echo "   Saved to: $BACKUP_FILE"
    set BACKED_UP (math $BACKED_UP + 1)
end

if test $BACKED_UP -gt 0
    echo ""
    echo "ℹ️  $BACKED_UP file(s) backed up. The module version will be used (module is source of truth)."
    echo ""
end

# Execute stow (without --adopt to preserve module version)
echo "Running stow..."
stow -d $DOTFILES_DIR -t $TARGET $MODULE

# Validate symlinks were created
echo ""
echo "Verifying symlinks..."
set ERRORS 0

if test -L "$TARGET/.claude/CLAUDE.md"
    echo "✓ CLAUDE.md symlink created"
    echo "  "(ls -la "$TARGET/.claude/CLAUDE.md")
else
    echo "✗ Error: CLAUDE.md symlink not created"
    set ERRORS (math $ERRORS + 1)
end

if test -L "$TARGET/.config/ccstatusline/settings.json"
    echo "✓ ccstatusline settings.json symlink created"
    echo "  "(ls -la "$TARGET/.config/ccstatusline/settings.json")
else
    echo "✗ Error: ccstatusline settings.json symlink not created"
    set ERRORS (math $ERRORS + 1)
end

echo ""
if test $ERRORS -eq 0
    echo "✅ All symlinks created successfully!"
    echo ""
    echo "Your configuration is now managed by stow."
    echo "Edit files in: $DOTFILES_DIR/$MODULE/"
    echo "Changes will be reflected immediately in $TARGET"
    exit 0
else
    echo "❌ Failed to create $ERRORS symlink(s)"
    exit 1
end
