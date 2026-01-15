# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is **claudefiles** (formerly claude-kit), a Claude Code plugin repository containing custom commands, agents, skills, and configurations. It's designed to be installed as a plugin and distributed across devices, with local development happening in `~/.claude/` before promotion to the plugin.

## Development Workflow

The plugin uses a **development sandbox pattern**:

1. **Local Development**: Create/modify resources in `~/.claude/` (commands, agents, skills)
2. **Testing**: Test resources locally to ensure they work
3. **Sync Detection**: Use `config-sync-analyzer` agent to detect new/modified resources
4. **Promotion**: Copy validated resources to this repository (`/home/diego/config/claude/`)
5. **Plugin Update**: Commit changes and update plugin via Claude Code plugin system
6. **Cleanup**: Remove local copies (they now come from the installed plugin)

## Repository Structure

```
.
├── agents/              # Custom Claude agents for specialized tasks
├── commands/            # Slash commands for quick operations
├── skills/              # Multi-step workflows and templates
├── output-styles/       # Response formatting styles
├── dotfiles/claude/     # Stow-managed configuration files
│   ├── .claude/         # CLAUDE.md and language-specific rules
│   └── .config/         # ccstatusline settings
├── scripts/             # Stow setup scripts (bash, fish, PowerShell)
└── .claude-plugin/      # Plugin metadata and marketplace info
```

## Key Components

### Agents (Specialized Subagents)

Located in `agents/`, these are autonomous agents for specific tasks:

- **quality-analyzer**: Code quality audits, detects code smells, generates refactoring reports
- **quality-refactorer**: Executes quality-analyzer reports mechanically
- **consistency-auditor**: Ensures new code follows existing project patterns
- **react-implementation-specialist**: Executes React implementation plans for 5+ files
- **dependency-docs-collector**: Fetches third-party package documentation
- **agent-reviewer**: Quality review for agent definitions
- **command-reviewer**: Quality review for command definitions

All agents follow frontmatter format with `name`, `description`, `tools`, `model`, and `color` fields.

### Commands (Slash Commands)

Located in `commands/`, these are user-invocable shortcuts:

- **claudify**: Generates/updates CLAUDE.md documentation for modules
- **deep-reason**: Uses sequential-thinking MCP for complex problem-solving
- **predict-issues**: Analyzes code for potential issues before execution
- **journal**: Creates development journal entries
- **remove-comments**: Strips comments from code files
- **explain-like-senior**: Technical explanations with senior engineer perspective
- **dry-run**: Simulates execution flow for prompts

### Skills (Multi-step Workflows)

Located in `skills/`, these are complex workflows:

- **create-pr**: Generates pull request descriptions based on dimension (small/medium/large)
- **dropletify**: Complete DigitalOcean deployment setup with Docker, GitHub Actions, rollback
- **subagent-orchestration**: Coordinates multiple parallel agents

Skills use `SKILL.md` format and may include supporting files (scripts, templates).

### Dotfiles Management

The `dotfiles/claude/` directory uses **GNU Stow** for symlink management:

- **Source of truth**: Files in `dotfiles/claude/` override local versions
- **Setup scripts**: `scripts/stow-claude.{sh,fish,ps1}` create symlinks to `$HOME`
- **Automatic backups**: Existing files are backed up before symlinking
- **Managed files**:
  - `~/.claude/CLAUDE.md` → User preferences and code standards
  - `~/.config/ccstatusline/settings.json` → Status line configuration
  - Language-specific rules in `.claude/rules/`

## Working with the Plugin

### Installing the Plugin

```bash
/plugin marketplace add https://github.com/DieGopherLT/claudefiles diegopher
/plugin install claudefiles@diegopher
```

### Updating the Plugin

After making changes to this repository:

```bash
cd /home/diego/config/claude
git add <modified-files>
git commit -m "Description of changes"
git push

# Update plugin
/plugin marketplace update diegopher
/plugin install claudefiles@diegopher
```

### ⚠️ CRITICAL: Version Bump Rule (Ragnarök Prevention)

**ALWAYS bump the version in `.claude-plugin/plugin.json` BEFORE committing changes.**

If you commit without updating the version, Ragnarök will occur. This is not negotiable.

```bash
# 1. Edit .claude-plugin/plugin.json
# 2. Increment version (e.g., 1.3.0 → 1.3.1 or 1.4.0)
# 3. THEN commit
git add .claude-plugin/plugin.json <other-files>
git commit -m "chore: bump version to X.Y.Z - <description>"
```

Version bumping guidelines:
- **Patch (1.3.0 → 1.3.1)**: Bug fixes, small tweaks, documentation updates
- **Minor (1.3.0 → 1.4.0)**: New commands, agents, or skills
- **Major (1.3.0 → 2.0.0)**: Breaking changes, major restructuring

### Syncing Local Changes

Use the `config-sync-analyzer` agent to detect local resources ready for promotion:

```bash
# The agent compares ~/.claude/ with this repository
# Reports: new resources, modified resources, sync status
# Provides copy commands to move resources to repo
```

## Configuration Files

- **`.mcp.json`**: MCP server configurations (sequential-thinking)
- **`.claude/settings.local.json`**: Plugin-specific settings
- **`.claude-plugin/plugin.json`**: Plugin metadata (name, version, description)
- **`.gitignore`**: Excludes `.claude/` directory (local development sandbox)

## Important Notes

### Excluded from Git

The `.claude/` directory in the repository root is excluded (`.gitignore`) because it's the development sandbox. The actual configuration meant for distribution lives in `dotfiles/claude/.claude/`.

### Symlinks to Watch For

When using `config-sync-analyzer`, symlinks are automatically excluded:
- `~/.claude/CLAUDE.md` (symlinked via stow)
- `~/.config/ccstatusline/settings.json` (symlinked via stow)

### System Files Never Synced

These files in `~/.claude/` are system-managed and never part of the plugin:
- `.credentials.json`, `claude.json`, `history.jsonl`, `settings.json`
- Directories: `debug/`, `file-history/`, `downloads/`, `session-env/`, `shell-snapshots/`, `todos/`, `projects/`, `plugins/`, `ide/`, `statsig/`, `hooks/`, `config/`

### Agent and Command Review

After creating/modifying agents or commands, use the reviewer agents proactively:
- `/agent-reviewer` for agent definitions
- `/command-reviewer` for command definitions

## Quality Standards

When creating new resources:

- **Agents**: Must include clear trigger examples, tool requirements, and specific instructions
- **Commands**: Must have argument hints, clear descriptions, and user-invocable flag if needed
- **Skills**: Must include step-by-step workflows, reference files/templates where applicable
- **Naming**: Descriptive, intent-focused (avoid generic terms like handler, manager, helper)
- **Documentation**: Token-efficient, focus on non-obvious information

## Stow Setup

The repository uses GNU Stow for dotfile management. Run setup scripts from repository root:

```bash
# Bash
./scripts/stow-claude.sh

# Fish
./scripts/stow-claude.fish

# PowerShell
.\scripts\stow-claude.ps1
```

Scripts will:
1. Backup existing non-symlinked files with timestamp
2. Create symlinks from `dotfiles/claude/` to `$HOME`
3. Verify symlinks were created successfully
4. Report any errors

## MCP Servers

The plugin includes the `sequential-thinking` MCP server configured in `.mcp.json`. This enables deep reasoning for complex problems through dynamic thought processes.
