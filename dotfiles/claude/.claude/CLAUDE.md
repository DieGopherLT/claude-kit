# User Preferences for Claude

## User Identity

- **Name**: Diego
- **GitHub**: DieGopherLT
- **Role**: Software Engineer
- **Email**: <diego@diegopher.dev>

## User relevant information

- **Preferred programming languages**: Go, TypeScript, C#
- Preferred and default shell is **fish**.

## Session Behavior

- When asking questions, use proactively `AskUserQuestion` tool.
  - Especially when presenting multiple approaches or when clarification is needed.
- If not in plan mode and user suggests a plan or a request is beyond a few edits, then **enter plan mode**.

## Code Standards

### Naming Conventions

- Variables/functions: descriptive intent over generic terms (calculateTotalPrice not process, userAccountBalance not data)
- Classes: specific purpose names (PaymentProcessor not Helper)
- Avoid: data, info, handler, manager, helper, utils without context

### Structure

- Immutability: create new objects/arrays instead of mutating existing ones
- Control flow: guard clauses at function start, return early to avoid nesting
- Function parameters: use config object when 3+ parameters
- Organization: group related code with blank lines between distinct concepts
- Comments: only for non-obvious technical decisions, never for self-explanatory code or redundant information

### Language

- Code: English only
- Responses: match user's language

### Error Handling

- Fail fast: validate inputs early, return errors immediately
- Provide context: error messages should include what failed and why
- Never silently swallow errors

### Logging

- Use structured logging (JSON) for production systems
- Log levels: ERROR for failures, WARN for degraded state, INFO for key events
- Never log sensitive data (passwords, tokens, PII)
- Include correlation IDs for distributed tracing when applicable

## Tools & Workflows

- Prioritize using `dotclaudefiles` plugin skills.
  - That plugin is user's set of custom skills for his personal workflows.
- The `frontend-design/frontend-design` skill is useful for UI/UX tasks, use it proactively when working on front-end code.
  - Of course follow project's design system and guidelines first.

### The LSP Chain (Code Exploration Methodology)

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
[Selective Read] → Only if you need context
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

---

**Explore and Plan sub-agents:**

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

### Git operations

- File moves: use `git mv` instead of rewriting
- File deletions: use `git rm` instead of regular `rm`.
- When committing code, do not include any CLAUDE co-authoring information.
- Branch names: short, descriptive, kebab-case (feature/add-login, fix/payment-bug)
  - **Personal repos**: Commit to main by default; use `AskUserQuestion` to confirm if user wants a branch for larger changes
  - **Collaborative repos**: Always create a branch for features/fixes
  - When unsure if repo is personal or collaborative, ask using `AskUserQuestion`
- Do not commit changes until user approves them.
- Commit messages: **single line only**, max 96 chars, no body, using prefixes (feat:, fix:, docs:, style:, refactor:, test:, chore:, wip:)
  - Example: `feat: add user authentication with JWT`, `fix: resolve payment processing bug`
  - Never add multi-line bodies or bullet points after the summary
- Pull requests: **ALWAYS** use the `dotclaudefiles:create-pr` skill unless told otherwise.
