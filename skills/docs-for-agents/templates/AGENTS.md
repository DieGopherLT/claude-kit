# [Project Name] - Technical Guidelines

[Write 2-3 paragraphs introducing the project from a technical perspective:

- Brief technical overview
- Primary technologies and architectural approach
- Key technical constraints or requirements
- How this documentation is organized]

## Quick Reference

### Project Structure

```shell
project-name/
├── [directory]/           # [Purpose]
│   ├── [key-file]        # [Description]
│   └── [subdirectory]/   # [Purpose]
├── [directory]/           # [Purpose]
├── [config-file]          # [Description]
└── [config-file]          # [Description]
```

### Essential Commands

- **Build**: `[command]` - [Description of what this does]
- **Test**: `[command]` - [Description of what this does]
- **Dev**: `[command]` - [Description of what this does]
- **Lint**: `[command]` - [Description of what this does]

### Documentation

- [README.md](../README.md) - Project overview and business documentation

## Development Standards

### Naming Conventions

[Document the actual naming conventions found in the codebase]

**Variables**: [Pattern description]

- Example: `[exampleName]`

**Functions**: [Pattern description]

- Example: `[exampleFunction()]`

**Classes/Types**: [Pattern description]

- Example: `[ExampleClass]`

**Files**: [Pattern description]

- Example: `[example-file.ext]`

### Code Patterns

[Document the good practices and patterns identified in the codebase]

**[Pattern Category 1]**: [Description and where it's used]

- Location: `[file:line]`
- Example: `[code snippet if helpful]`

**[Pattern Category 2]**: [Description and where it's used]

- Location: `[file:line]`

**[Pattern Category 3]**: [Description and where it's used]

- Location: `[file:line]`

### Common Practices

[Document recurring practices and conventions used across the project]

**[Practice 1]**: [Description]

**[Practice 2]**: [Description]

**[Practice 3]**: [Description]

## Antipatterns to Address

[Document problems that need gradual correction, with specific file locations]

### [Antipattern Category 1]

**Issue**: [Brief description of the problem]

**Locations**:

- `[path/to/file.ext:line]` - [Specific issue]
- `[path/to/another.ext:line]` - [Specific issue]

**Recommended Action**: [How to gradually fix this]

**Priority**: [Low/Medium/High]

---

### [Antipattern Category 2]

**Issue**: [Brief description]

**Locations**:

- `[path/to/file.ext:line]`

**Recommended Action**: [Fix strategy]

**Priority**: [Low/Medium/High]

## Build & Development

[Detailed information about scripts, commands, and development workflow]

### Build System

**Primary Build Tool**: [Tool name]

**Build Commands**:

- `[command]` - [Description]
- `[command]` - [Description]

**Build Configuration**: `[config file location]`

### Development Workflow

**Starting Development**:

1. `[command]` - [Description]
2. `[command]` - [Description]
3. [Additional steps]

**Development Tools**:

- **Linter**: [Tool] (`[command]`)
- **Formatter**: [Tool] (`[command]`)
- **Type Checker**: [Tool] (`[command]`)

### Testing

**Test Framework**: [Framework name]

**Commands**:

- `[command]` - Run all tests
- `[command]` - Watch mode
- `[command]` - Generate coverage report

**Test Location**: `[path]`

### Scripts Reference

[List important scripts from package.json, Makefile, or task runner]

- `[script-name]` - [Description]
- `[script-name]` - [Description]
- `[script-name]` - [Description]

### Environment Setup

**Required Environment Variables**: See `.env.example`

**Setup Steps**:

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Cross-References

- [README.md](../README.md) - Business context and project overview
- [Link to other relevant documentation if it exists]
