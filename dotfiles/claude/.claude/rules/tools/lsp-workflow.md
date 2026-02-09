---
paths: **/*.{js,jsx,ts,tsx,go}
---

# LSP-First Workflow

**PREFER `LSP` tool over Grep/Glob** for code navigation in supported languages (more precise, fewer tokens, AND **NO FALSE POSITIVES**):

- Finding definitions: `goToDefinition` → jump directly to where symbol is defined
- Finding all usages: `findReferences` → only real usages, not comments/strings
- Understanding structure: `documentSymbol` → see all methods/properties without reading full file
- Tracing call flows: `incomingCalls`/`outgoingCalls` → who calls this function, what does it call
- Type information: `hover` → get types/docs without opening files
- **Use Grep/Glob only for**: text patterns, multi-file search, non-code files, initial exploration

## The LSP Chain (Code Exploration Methodology)

**Applies to**: `.js`, `.jsx`, `.ts`, `.tsx`, `.go`

Hybrid flow combining text search for discovery with LSP for deep semantic analysis.

**Flow:**

```text
[Glob/Grep] → Candidate file
    ↓
[Already indexed?] ──Yes──→ Skip documentSymbol
    ↓ No                          ↓
[documentSymbol] ←────────────────┘
    ↓
[Selective Read] → Only if you need context of implementation
    ↓
[hover/goToDefinition] → Understand symbol
    ↓
[findReferences/incomingCalls] → Expand to other files
    ↓
[Dead end?]
    ↓ No              ↓ Yes
    ↻ next            [Glob/Grep] → New chain
      file
```

**Dead end** = references lead to external dependencies (node_modules, stdlib) OR symbol is a leaf (no internal dependencies).

**Memoization rules:**

- `documentSymbol` only once per file (no re-indexing)
- `Read` optional even on already indexed files
- Cache is contextual during the session

**When to use each tool:**

| Tool                          | Use for                                            |
| ----------------------------- | -------------------------------------------------- |
| `Glob/Grep`                   | Initial discovery, non-code files, text patterns   |
| `documentSymbol`              | File index (functions, classes, exports)           |
| `hover`                       | Symbol types and documentation                     |
| `goToDefinition`              | Jump to definition                                 |
| `findReferences`              | All usages of a symbol                             |
| `incomingCalls/outgoingCalls` | Trace call flow                                    |

**For other languages** (Python, Rust, C#, etc.): use standard Glob/Grep/Read.

## When Invoking Sub-agents

When invoking sub-agents to explore JS/TS/Go code, include in the prompt:

```text
[Task description]

**Exploration with "The LSP Chain":**
1. Use Glob/Grep to find candidate files
2. documentSymbol to index structure (only once per file)
3. Selective Read if you need full context
4. hover/goToDefinition to understand specific symbols
5. findReferences/incomingCalls to expand to other files
6. Repeat until dead end (external dependency or leaf symbol)
7. New chain with Glob/Grep from another file

Do not re-index already visited files.
```

## Reasoning

This strategy leverages the strengths of LSP for semantic understanding while using text search for broad discovery. By indexing files only once and selectively reading content, it minimizes redundant operations and optimizes performance. The flow ensures that exploration is systematic, allowing for deep dives into code structure while avoiding unnecessary reprocessing of already analyzed files. This approach is particularly effective for languages with robust LSP support, enabling efficient navigation and comprehension of complex codebases.

Also, it is way more token efficient than reading entire files upfront, especially in large codebases and the most important perk of this strategy is that it does not allow false positives from text search alone since every symbol is verified through LSP.
