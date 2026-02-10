# dotclaudefiles

My personal Claude Code plugins repository. Contains multiple plugins for different workflows.

## Available Plugins

| Plugin | Description |
|--------|-------------|
| `dotclaudefiles` | Commands, agents, skills, and configs I use daily |

## Install

```bash
# Add marketplace (once)
/plugin marketplace add DieGopherLT/dotclaudefiles

# Install plugin
/plugin install dotclaudefiles@diegopher
```

## Setup Dotfiles (Optional)

⚠️ **Warning:** This will replace your local files with the repo version (backups are created automatically).

```bash
# Bash
./scripts/stow-claude.sh

# Fish
./scripts/stow-claude.fish
```

## Status Line (Optional)

Want a status line? Use `dotfiles/claude/.config/ccstatusline/settings.json` with:

**ccstatusline (Node.js)**
[sirmalloc/ccstatusline](https://github.com/sirmalloc/ccstatusline) - Feature-rich status line with extensive customization.

or

**cc-status-line (Go)**
Install [DieGopherLT/cc-status-line](https://github.com/DieGopherLT/cc-status-line) - Lightweight Go implementation with better performance.

They both look almost identical, Go version made by me includes a visual context indicator.

## Update

```bash
/plugin marketplace update diegopher
/plugin install dotclaudefiles@diegopher
```

## Uninstall

```bash
/plugin uninstall dotclaudefiles@diegopher
```

---

**Diego** ([@DieGopherLT](https://github.com/DieGopherLT))
