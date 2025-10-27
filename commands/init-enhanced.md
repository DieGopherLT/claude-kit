# Enhanced Setup Command

## Purpose

Enhanced version of `/init` that creates comprehensive project documentation following Diego's preferences for separation of concerns, longevity, and technical accuracy.

## Behavior

### 1. README.md Detection & Creation

- **If README.md exists**: Reference it in CLAUDE.md
- **If README.md missing**: Create README.md, CLAUDE.md, and AGENTS.md together
- **README.md content focus**:
  - Business logic and high-level project presentation
  - User-facing documentation (installation, usage)
  - Project goals and context
  - Elevator pitch for the project

### 2. Intelligent Codebase Analysis

- **Pattern Detection**: Scan actual codebase to identify real patterns (not assumed ones)
- **Naming Conventions**: Discover and document actual naming patterns found
- **Antipattern Flagging**: Identify problematic patterns and mark for gradual correction
- **Technology Stack**: Auto-detect frameworks, libraries, and tools in use

### 3. Modular Documentation Structure

- **All projects**: Create `AGENTS.md` with complete technical documentation
- **CLAUDE.md purpose**: Minimal file with references to AGENTS.md and README.md
- **Large/Complex projects**: Optionally auto-create `docs/` folder with specialized files:
  - `docs/design.md` - UI/UX guidelines and design decisions
  - `docs/architecture.md` - System architecture and organization
    - Directories trees will have `shell` language.
    - Only mermaid diagrams are allowed if helpful.
    - Focus the file to orientate where to look for determined elements, not tell the exact path unless is a core file.
  - `docs/api.md` - API documentation and conventions
  - `docs/deployment.md` - Deployment and infrastructure
- **AGENTS.md remains focused**: Complete technical reference for Claude Code agents

### 4. Content Guidelines Implementation

#### CLAUDE.md Structure

```markdown
# [Project Name]

See @README.md for project overview and user documentation.

See @AGENTS.md for complete technical guidelines and development standards.
```

#### AGENTS.md Structure

```markdown
# [Project Name] - Technical Guidelines

[2-3 paragraph introduction with technical context]

## Quick Reference

- README.md: [link] - Business context and user documentation
- Build: [detected build command]
- Test: [detected test command]
- Docs: [links to docs/ files if created]

## Code Standards

### Naming Conventions

[Actual patterns found in codebase]

### Common Patterns

[Good practices identified and their locations]

### Antipatterns to Address

[Problems found that need gradual correction]

## Architecture

[Brief overview or link to docs/architecture.md]

## Build & Development

[Scripts and commands discovered]

## Cross-References

[Links to specialized documentation in docs/]
```

#### README.md Structure (if created)

```markdown
# [Project Name]

[Brief project description and value proposition]

## Overview

[What this project does and why it matters]

## Installation

[How to get started]

## Usage

[Basic usage examples]

## Contributing

[How to contribute - reference CLAUDE.md for technical guidelines]

## License

[License information]
```

### 5. Longevity Focus

- Document **patterns and principles**, not specific implementations
- Create guidelines that remain relevant as code evolves
- Flag temporary solutions that need eventual refactoring
- Focus on maintainable, discoverable documentation

### 6. Integration with Existing Workflow

- Respect existing documentation structure if present
- Enhance rather than replace existing good documentation
- Maintain consistency with Diego's preferences for technical communication
- Ensure Claude can efficiently process the generated structure

## Implementation Notes

- Command should be idempotent (safe to run multiple times)
- Prioritize token efficiency when agents read these files.
  - Code snippets are allowed to provide agents examples.
- Should respect existing files (ask before overwriting)
- Provide summary of what was created/updated
- Include suggestions for immediate next steps
- other file references syntax varies depending the file:
  - CLAUDE.md uses @<relative-path> to refer another files
  - AGENTS.md and any other markdown file uses the regular markdown syntax.

## Success Criteria

- New developers can understand project quickly (README.md)
- Claude agents can efficiently find and process technical context (AGENTS.md)
- CLAUDE.md serves as clear entry point with minimal maintenance
- Documentation remains current through gradual updates
- Complex topics are properly modularized
- Antipatterns are identified for systematic improvement
- AGENTS.md is not ignored by git, ensure by reading @.gitignore

ultrathink.
