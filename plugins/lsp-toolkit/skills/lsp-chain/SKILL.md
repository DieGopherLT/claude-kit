---
name: lsp-chain
description: Esta skill debe usarse cuando el usuario pide "explorar con LSP", "usar LSP chain", "indexar codebase", "navegar codigo con precision", "explorar TypeScript/JavaScript/Go", o necesita una metodologia estructurada para explorar codebases usando Language Server Protocol en lugar de lectura de archivos.
---

# The LSP Chain Methodology

Structured approach for code exploration using Language Server Protocol, providing zero false positives and significant token savings compared to file reading.

## Supported Languages

- TypeScript (.ts, .tsx)
- JavaScript (.js, .jsx)
- Go (.go)

For other languages (Python, Rust, C#, etc.), use standard Glob/Grep/Read approach.

## The LSP Chain Flow

```text
[Glob/Grep] -> Candidate file
    |
[Already indexed?] --Yes--> Skip documentSymbol
    | No                         |
    v                            v
[documentSymbol] <---------------+
    |
[Selective Read] -> Only if implementation context needed
    |
[hover/goToDefinition] -> Understand symbol
    |
[findReferences/incomingCalls] -> Expand to other files
    |
[Dead end?]
    | No              | Yes
    v                 v
    next file    [Glob/Grep] -> New chain
```

## Key Concepts

### Dead End

A dead end occurs when:

- References lead to external dependencies (node_modules, stdlib)
- Symbol is a leaf (no internal dependencies)

When hitting a dead end, start a new chain from a different file.

### Memoization Rules

- `documentSymbol` only once per file (no re-indexing)
- `Read` optional even on already indexed files
- Cache is contextual during the session

## Tool Selection Guide

| Tool | Use For |
|------|---------|
| `Glob/Grep` | Initial discovery, non-code files, text patterns |
| `documentSymbol` | File index (functions, classes, exports) |
| `hover` | Symbol types and documentation |
| `goToDefinition` | Jump to definition |
| `findReferences` | All usages of a symbol |
| `incomingCalls/outgoingCalls` | Trace call flow |

## Workflow Phases

### Phase 1: Discovery

Use Glob/Grep to find candidate files related to the task:

```bash
# Routes/handlers
Glob: **/routes/**/*.{ts,js,go}
Glob: **/handlers/**/*.{ts,js,go}

# Services
Glob: **/services/**/*.{ts,js,go}

# By pattern
Grep: "router\.(get|post|put|delete)"
Grep: "fetch|axios|http\."
```

### Phase 2: Indexing

For each candidate file, run `documentSymbol` once:

```text
LSP documentSymbol: src/services/auth.ts
Result:
  - AuthService (class, line 10)
  - validateToken (method, line 25)
  - refreshToken (method, line 45)
```

Build mental index of what exists where.

### Phase 3: Navigation

Use LSP navigation tools to understand relationships:

```text
hover: Get type signature without reading file
goToDefinition: Jump to where symbol is defined
findReferences: See all usages across codebase
incomingCalls: Who calls this function?
outgoingCalls: What does this function call?
```

### Phase 4: Selective Reading

Only use Read tool when:

- Implementation details matter (not just signature)
- Non-code context needed (comments, config)
- LSP cannot answer the question

## Integrating with Subagents

When invoking `explore-lsp` or `Plan` agents for TS/JS/Go code, include in prompt:

```text
[Task description]

**Exploration with LSP Chain:**
1. Use Glob/Grep to find candidate files
2. documentSymbol to index structure (only once per file)
3. Selective Read if full context needed
4. hover/goToDefinition to understand specific symbols
5. findReferences/incomingCalls to expand to other files
6. Repeat until dead end (external dependency or leaf symbol)
7. New chain with Glob/Grep from another file

Do not re-index already visited files.
```

## Efficiency Metrics

When following LSP Chain correctly:

- **Token savings**: 40-60% vs reading all files
- **False positives**: Zero (LSP validates symbols exist)
- **Precision**: Exact line/character positions
- **Speed**: Faster than sequential file reads

## Anti-Patterns to Avoid

- Reading entire files before using LSP
- Re-running documentSymbol on already indexed files
- Using Grep for symbol lookup when LSP is available
- Ignoring dead ends (wasting tokens on external deps)

## Example Session

```text
Task: Understand authentication flow

1. Glob: **/auth/**/*.ts -> Found 3 files

2. documentSymbol: src/auth/service.ts
   - AuthService (class)
   - login (method)
   - validateToken (method)

3. hover: login method
   -> (email: string, password: string) => Promise<TokenPair>

4. outgoingCalls: login
   -> calls UserRepository.findByEmail
   -> calls PasswordHasher.verify
   -> calls TokenService.generate

5. goToDefinition: TokenService.generate
   -> src/auth/token.ts:42

6. documentSymbol: src/auth/token.ts
   [... continue chain ...]

7. Dead end: jwt.sign (external)
   -> Start new chain or conclude

Result: Complete auth flow mapped with exact locations
```
