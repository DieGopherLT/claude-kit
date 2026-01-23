# dotclaudefiles

My personal Claude Code configuration packaged as a plugin. Includes commands, agents, skills, and configs I use daily.

## Install

```bash
/plugin marketplace add https://github.com/DieGopherLT/dotclaudefiles diegopher
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
/plugin update dotclaudefiles@diegopher
```

## Uninstall

```bash
/plugin uninstall dotclaudefiles@diegopher
```

---

**Diego** ([@DieGopherLT](https://github.com/DieGopherLT))
