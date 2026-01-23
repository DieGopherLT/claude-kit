# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is **dotclaudefiles** (formerly claude-kit), a Claude Code plugin repository containing custom commands, agents, skills, and configurations. It's designed to be installed as a plugin and distributed across devices, with local development happening in `~/.claude/` before promotion to the plugin.

## Development Workflow

The plugin uses a **development sandbox pattern**:

1. **Local Development**: Create/modify resources in `~/.claude/` (commands, agents, skills)
2. **Testing**: Test resources locally to ensure they work
3. **Sync Detection**: Use `config-sync-analyzer` agent to detect new/modified resources
4. **Promotion**: Copy validated resources to this repository (`/home/diego/config/claude/`)
5. **Plugin Update**: Commit changes and update plugin via Claude Code plugin system
6. **Cleanup**: Remove local copies (they now come from the installed plugin)

### 🔧 Using plugin-dev Resources (CRITICAL)

**ALWAYS use the `plugin-dev` plugin for developing this repository.** It provides:

- **Skills**: `/plugin-dev:create-plugin`, `/plugin-dev:skill-development`, `/plugin-dev:agent-development`, `/plugin-dev:command-development`, `/plugin-dev:hook-development`, `/plugin-dev:mcp-integration`, `/plugin-dev:plugin-settings`, `/plugin-dev:plugin-structure`
- **Agents**: `plugin-validator`, `skill-reviewer`, `agent-creator`
- **Best Practices**: Frontmatter guidelines, progressive disclosure, auto-discovery patterns

**The plugin-dev plugin was created by the Claude Code team specifically to make plugin development easier and follow official best practices.**

**WARNING**: Failing to use `plugin-dev` resources means ignoring official Claude Code plugin development standards. Always consult these resources when creating or modifying plugin components.

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

Located in `agents/`, these are autonomous agents for specific tasks. Each agent follows frontmatter format with `name`, `description`, `tools`, `model`, and `color` fields. Explore the directory to discover available agents and their specialized capabilities.

### Commands (Slash Commands)

Located in `commands/`, these are user-invocable shortcuts for quick operations. Commands use YAML frontmatter with arguments, descriptions, and execution instructions. Browse the directory to see all available commands.

### Skills (Multi-step Workflows)

Located in `skills/`, these are complex workflows that may include supporting files (scripts, templates, references). Skills use `SKILL.md` format with frontmatter and progressive disclosure pattern. Check the directory for available workflows.

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
/plugin marketplace add https://github.com/DieGopherLT/dotclaudefiles diegopher
/plugin install dotclaudefiles@diegopher
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
/plugin install dotclaudefiles@diegopher
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

## Frontmatter Best Practices (Agents & Skills)

### Language: Spanish (Español)

**All agent and skill frontmatter descriptions MUST be written in Spanish.** This facilitates activation since Diego interacts with Claude in Spanish.

### Description Format

#### For Skills (Third Person)

Skills must use third-person format with specific trigger phrases:

```yaml
---
name: skill-name
description: Esta skill debe usarse cuando el usuario pide "frase específica 1", "frase específica 2", "frase específica 3", o menciona contextos relevantes. Proporciona [breve descripción de lo que ofrece].
---
```

**Characteristics:**

- Start with "Esta skill debe usarse cuando el usuario pide..."
- Include 5-8 specific phrases users would say (between quotes)
- Add contextual mentions after "o menciona..."
- End with value proposition ("Proporciona...")
- Use concrete, action-oriented triggers

**Good example:**

```yaml
description: Esta skill debe usarse cuando el usuario pide "dominar el sistema de tipos de TypeScript", "implementar tipos genéricos", "crear tipos condicionales", "refactorizar biblioteca TypeScript", "refactorizar tipados", "migrar de JavaScript a TypeScript", o menciona tipos mapeados, tipos literales de plantilla, o tipos utilitarios. Proporciona guía completa para construir aplicaciones type-safe.
```

**Bad example:**

```yaml
description: Use when working with TypeScript types.  # Wrong language, vague, no triggers
```

#### For Agents (Third Person)

Agents also use third-person format with triggering conditions:

```yaml
---
name: agent-name
description: Este agente debe usarse cuando [condición específica 1], [condición específica 2], o cuando se necesite [capacidad específica]. [Descripción de lo que hace].
---
```

**Characteristics:**

- Start with "Este agente debe usarse cuando..."
- Describe conditions, not user phrases (agents are invoked by Claude, not users)
- Focus on scenarios and technical conditions
- Be specific about what the agent analyzes, generates, or validates

**Good example:**

```yaml
description: Este agente debe usarse cuando se crean nuevos módulos de 3+ archivos, se modifican 4+ archivos, o tras ejecutar un plan aprobado con 5+ archivos. Asegura que el código nuevo siga los patrones y convenciones del proyecto existente.
```

### Introspection for Activation Keywords

When creating or refining frontmatter, engage in collaborative introspection:

- **Ask Diego about real usage patterns**: "¿Cómo describirías esta tarea cuando me la pides?"
- **Test trigger phrases**: Present 3-4 trigger phrase options and ask which feels most natural
- **Explore related vocabulary**: "¿Qué otras palabras usarías para pedir esto?"
- **Validate context mentions**: "Además de estas frases, ¿qué conceptos o términos técnicos mencionarías?"
- **Iterate based on feedback**: After creating frontmatter, ask "¿Estas frases de activación capturan bien cuándo usarías esta skill/agent?"

**Introspection benefits:**

- Captures Diego's natural language patterns
- Increases activation accuracy
- Reduces false negatives (skill/agent not triggering when it should)
- Creates more intuitive plugin experience

### Progressive Disclosure (Skills Only)

Skills should follow progressive disclosure:

1. **SKILL.md body**: Core concepts, essential procedures (1,500-2,000 words ideal, <3,000 max)
2. **references/**: Detailed patterns, advanced techniques, comprehensive docs (2,000-5,000+ words each)
3. **examples/**: Working code, configuration files, templates
4. **scripts/**: Validation, testing, automation utilities

Keep frontmatter + core content lean; move detailed information to references.

### Writing Style

**Body content (Skills & Agents):**

- Use imperative/infinitive form (verb-first instructions)
- NOT second person ("you should...")
- Objective, instructional language

**Correct:**

```markdown
Para crear un hook, definir el tipo de evento.
Validar la configuración antes de usar.
```

**Incorrect:**

```markdown
Debes crear un hook definiendo el tipo de evento.
Tienes que validar la configuración.
```

### Validation Checklist

Before finalizing agent/skill:

- [ ] Description in Spanish
- [ ] Third-person format ("Esta skill debe usarse cuando..." / "Este agente debe usarse cuando...")
- [ ] Up to 8 specific trigger phrases (skills) or conditions (agents)
- [ ] Contextual mentions included
- [ ] Value proposition clear
- [ ] Body uses imperative form
- [ ] Progressive disclosure applied (skills)
- [ ] Introspection performed with Diego for activation keywords

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
