# Claude Code Configuration

Diego's centralized Claude Code configuration including custom commands, agents, skills, output styles, and CLAUDE.md management.

## Overview

This repository serves as a Claude Code plugin and configuration manager, providing:

- **Plugin Components**: Commands, agents, skills, output styles, and MCP servers distributed via Claude Code's plugin system
- **Dotfiles Management**: CLAUDE.md and ccstatusline configuration managed via GNU Stow
- **Automation Scripts**: Shell scripts for seamless setup and synchronization

## Architecture

```
claude-code/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── .mcp.json                # MCP servers configuration
├── commands/                # Custom slash commands (19)
├── agents/                  # Specialized agents (3)
├── skills/                  # Agent skills (2)
├── output-styles/           # Custom output styles (2)
├── dotfiles/
│   └── claude/
│       ├── .claude/
│       │   └── CLAUDE.md              # User preferences
│       └── .config/
│           └── ccstatusline/
│               └── settings.json      # Status line config
└── scripts/
    ├── stow-claude.sh       # Bash setup script
    └── stow-claude.fish     # Fish setup script
```

## Installation

### As a Claude Code Plugin

**1. Add this repository as a marketplace:**

```bash
# In Claude Code
/plugin marketplace add https://github.com/DieGopherLT/claude-code
```

**2. Install the plugin:**

```bash
/plugin install diegopher-claude-config@diegopher
```

**3. Enable the plugin (if not auto-enabled):**

```bash
/plugin enable diegopher-claude-config@diegopher
```

### Setting up CLAUDE.md with Stow

**Using Bash:**

```bash
./scripts/stow-claude.sh
```

**Using Fish:**

```bash
./scripts/stow-claude.fish
```

The script will:
- Backup any existing configuration files (with timestamp)
- Remove existing files to avoid conflicts
- Create symlinks using the **module version** (module is source of truth):
  - `~/.claude/CLAUDE.md` → `dotfiles/claude/.claude/CLAUDE.md`
  - `~/.config/ccstatusline/settings.json` → `dotfiles/claude/.config/ccstatusline/settings.json`
- Validate all symlinks were created successfully

**Important:** The module version is always used. If you have existing local files, they will be backed up (with timestamp) but the repository version will take precedence. This ensures you always get the latest configuration when cloning the repo on a new machine.

## What's Included

### Commands (19)

Custom slash commands for enhanced workflows:
- `/commit` - Intelligent git commit with conventional commits
- `/review` - Code review with quality checks
- `/test` - Test generation and execution
- `/scaffold` - Project scaffolding
- `/security-scan` - Security vulnerability scanning
- `/refactor-conditional-jsx` - JSX conditional refactoring
- `/deep-reason` - Deep reasoning for complex problems
- `/dry-run` - Simulate execution flow
- And more...

### Agents (3)

Specialized agents for specific tasks:
- **quality-auditor** - Code quality and consistency auditing
- **ui-implementation-specialist** - UI component implementation
- **ui-ux-designer** - UI/UX design guidance

### Skills (2)

Autonomous capabilities:
- **create-skill** - Create new Claude Code skills
- **create-command** - Create custom slash commands
- **subagent-orchestration** - Parallel/sequential subagent management

### Output Styles (2)

Custom output formatting:
- **mentor** - Mentor-style explanations
- **personal-preference** - Personalized output style

### MCP Servers (2)

Integrated Model Context Protocol servers:
- **sequential-thinking** - Advanced reasoning with dynamic problem-solving
- **context7** - Up-to-date library documentation from Upstash

## Updating

### Update Plugin Components

```bash
# In Claude Code
/plugin marketplace update diegopher
/plugin install diegopher-claude-config@diegopher
```

### Update User Configuration

Since configuration files are symlinked via Stow, simply pull the latest changes:

```bash
cd /path/to/claude-code
git pull
```

Changes are immediately reflected in:
- `~/.claude/CLAUDE.md`
- `~/.config/ccstatusline/settings.json`

## Synchronization Strategy

**Plugin Components** → Distributed via Claude Code plugin system
- Commands, agents, skills, output styles, MCP servers
- Version managed through `plugin.json`
- Updated via marketplace refresh

**User Configuration** → Managed via GNU Stow + Git
- CLAUDE.md (user preferences and instructions)
- ccstatusline settings (status line customization)
- Symlinked for instant updates
- Version controlled separately

## Development

### Modifying Plugin Components

1. Edit files in `commands/`, `agents/`, `skills/`, or `output-styles/`
2. Update version in `.claude-plugin/plugin.json`
3. Commit and push changes
4. Users update via `/plugin marketplace update`

### Modifying User Configuration

1. Edit files in `dotfiles/claude/`:
   - `.claude/CLAUDE.md` for user preferences
   - `.config/ccstatusline/settings.json` for status line
2. Commit and push changes
3. Users pull latest changes (symlinks auto-update)

## Uninstallation

### Remove Plugin

```bash
/plugin uninstall diegopher-claude-config@diegopher
```

### Remove Configuration Symlinks

```bash
# Using Stow (removes all symlinks)
stow -D -d /path/to/claude-code/dotfiles -t ~ claude

# Or manually
rm ~/.claude/CLAUDE.md
rm ~/.config/ccstatusline/settings.json
```

## License

MIT

## Author

Diego ([@DieGopherLT](https://github.com/DieGopherLT))
