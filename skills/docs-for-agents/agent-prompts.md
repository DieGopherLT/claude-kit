# Agent Prompts for Codebase Analysis

This file contains the prompts for the 3 Explore agents used to analyze the codebase.

---

## Agent 1: Code Patterns Analysis

### Context

Use existing AGENTS.md Development Standards section as reference if available.

### Objective

Discover actual code patterns in use across the codebase.

### Scope

**Start Points**: Main source directories (src/, lib/, cmd/, pkg/, internal/, etc.)

**Include**: All source code files, implementation files, module/package definitions

**Exclude**: Tests, mocks, generated code, node_modules, vendor, build artifacts, configuration files

### Deliverables

1. **Naming Conventions Actually Used** - Variable, function, class, file, and package naming patterns
2. **Code Standards Patterns Found** - Error handling, logging, comments, imports, code organization
3. **Common Practices Across the Codebase** - Design patterns, utilities usage, API patterns, validation

### Depth

Medium thoroughness

### Output Format

```markdown
## Development Standards

### Naming Conventions

**Variables**: [pattern found]
**Functions**: [pattern found]
**Classes/Types**: [pattern found]
**Files**: [pattern found]

### Code Patterns

**Error Handling**: [approach with file references]
**Logging**: [pattern found]
**API Design**: [pattern found]

### Common Practices

**[Practice 1]**: [Description and locations]
**[Practice 2]**: [Description and locations]
```

---


## Agent 2: Project Structure Analysis

### Context

Check existing AGENTS.md Quick Reference section if available.

### Objective

Map project organization and create a compact, informative directory tree.

### Scope

**Start Points**: Project root

**Include**: Important directories, configuration files, entry points, key documentation, build configs

**Exclude**: Build artifacts, dependencies, hidden files (except critical configs), IDE configs, logs

### Deliverables

1. **Compact Directory Tree** - Max 15-20 lines with inline comments
2. **Entry Point Files** - Main application, CLI, API/server entry points
3. **Key Paths** - Source, tests, config, documentation locations
4. **Configuration Files** - Build, test, linter, environment configs

### Depth

Medium thoroughness

### Output Format

```markdown
### Project Structure

\`\`\`shell
project/
├── src/                 # Source code
│   ├── main.ts         # Application entry point
│   ├── api/            # REST API endpoints
│   └── services/       # Business logic
├── tests/              # Test suites
├── package.json        # Dependencies and scripts
└── tsconfig.json       # TypeScript config
\`\`\`
```

### Formatting Requirements

- Use shell syntax
- Maximum 15-20 lines
- Inline comments with `#`
- Focus on orientation, not completeness
- Highlight entry points and key directories

---

## Agent 3: Build & Tooling Analysis

### Context

Compare with existing AGENTS.md Build & Development section if available.

### Objective

Discover build system, development workflow, and essential commands.

### Scope

**Start Points**: package.json, Makefile, build scripts, task runners, language build files, CI/CD configs

**Include**: Scripts, build configs, test configs, development workflows, tooling setup

**Exclude**: Lock files, cache files, build artifacts, dependency files

### Deliverables

1. **Build Commands** - Compile, bundle, package, production builds
2. **Test Commands** - Run tests, specific suites, coverage, watch mode
3. **Development Workflow** - Dev server, hot reload, migrations, dependency install, environment setup
4. **Tooling Setup** - Linter, formatter, type checker, git hooks, other dev tools

### Depth

Medium thoroughness

### Output Format

#### Essential Commands (for Quick Reference)

```markdown
### Essential Commands

- **Build**: `npm run build` - Compile TypeScript and bundle
- **Test**: `npm test` - Run all test suites
- **Dev**: `npm run dev` - Start development server
- **Lint**: `npm run lint` - Check code quality
```

#### Build & Development (detailed section)

```markdown
## Build & Development

### Build System

**Primary Build Tool**: [Tool name]
**Build Commands**: [Commands with descriptions]
**Build Configuration**: [Config file location]

### Development Workflow

**Starting Development**: [Steps]
**Development Tools**: [Linter, Formatter, Type Checker]

### Testing

**Test Framework**: [Framework]
**Commands**: [Test commands]
**Test Location**: [Path]

### Scripts Reference

**Available scripts**: [List from package.json]

### Environment Setup

**Required Variables**: See `.env.example`
**Setup Steps**: [Steps to get started]
```

---

## General Notes for All Agents

- Provide specific file locations with line numbers when possible
- Focus on what IS being done, not what SHOULD be done
- Document actual patterns, even if inconsistent
- Be constructive, not critical
- Suggest actionable improvements
- Prioritize clarity and usefulness
- Think "what helps navigate and understand this project?"
