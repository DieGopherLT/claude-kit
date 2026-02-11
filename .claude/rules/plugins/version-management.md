---
paths:
  - "plugins/**"
---

# ⚠️ CRITICAL: Version Bump Rule (Ragnarök Prevention)

**ALWAYS bump the version in the affected plugin's `plugin.json` BEFORE committing changes.**

If you commit without updating the version, Ragnarök will occur. This is not negotiable.

```bash
# 1. Edit plugins/<plugin-name>/.claude-plugin/plugin.json
# 2. Increment version (e.g., 1.3.0 → 1.3.1 or 1.4.0)
# 3. THEN commit
git add plugins/<plugin-name>/.claude-plugin/plugin.json <other-files>
git commit -m "chore(<plugin-name>): bump version to X.Y.Z - <description>"
```

## Version Bumping Guidelines

- **Patch (1.3.0 → 1.3.1)**: Bug fixes, small tweaks, documentation updates
- **Minor (1.3.0 → 1.4.0)**: New commands, agents, or skills
- **Major (1.3.0 → 2.0.0)**: Breaking changes, major restructuring

When changes affect multiple plugins, bump all affected plugin versions.

## Updating Plugins

After making changes to any plugin in this repository:

```bash
cd /home/diego/config/claude
git add <modified-files>
git commit -m "Description of changes"
git push

# Update marketplace and reinstall affected plugin(s)
/plugin marketplace update diegopher
/plugin install <plugin-name>@diegopher
```
