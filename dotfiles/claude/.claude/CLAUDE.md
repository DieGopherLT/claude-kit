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

### Explore and Plan sub-agents

**AGENT SELECTION - LSP-Optimized vs Standard:**

When exploring codebases with TypeScript (.ts, .tsx), JavaScript (.js, .jsx), or Go (.go) files, **PREFER** the `dotclaudefiles:explore-lsp` agent over the standard `Explore` agent.

**Use `dotclaudefiles:explore-lsp` when:**

- ✅ Codebase contains .ts, .tsx, .js, .jsx, .go files
- ✅ Need to understand module structure, exports, or architecture
- ✅ Tracing call flows or dependencies
- ✅ Finding symbol definitions or usages
- ✅ Want 50%+ token savings vs file reading
- ✅ Need zero false positives in symbol searches

**Use standard `Explore` when:**

- ❌ Codebase is Python, Rust, C#, or other non-LSP languages
- ❌ Exploring non-code files (markdown, configs, data files)
- ❌ Broad text pattern searches across mixed file types

**Why explore-lsp is superior for TS/JS/Go:**

- Built with LSP-first philosophy (documentSymbol, findReferences, hover, call tracing)
- Type-aware analysis (understands code semantics, not just text)
- Exact line/character positions for every symbol
- Zero false positives (no matches in comments/strings)
- Configured with Haiku model for fast, cost-effective exploration

---

**CRITICAL**: When invoking Explore or Plan agents for codebases containing TypeScript (.ts, .tsx), JavaScript (.js, .jsx), or Go (.go) files, you MUST include explicit LSP usage instructions in your prompt.

**Mandatory prompt format:**

```
[Your task description]

**CRITICAL INSTRUCTION - LSP Tool Usage:**
This codebase contains [TypeScript/JavaScript/Go] files. You MUST use the LSP tool for all code navigation tasks:

- **Finding symbols/functions**: Use `documentSymbol` (NOT Grep) to list all symbols in a file
- **Finding definitions**: Use `goToDefinition` (NOT Grep) to jump to where a symbol is defined
- **Finding usages**: Use `findReferences` (NOT Grep) to find all real usages with ZERO false positives
- **Understanding types**: Use `hover` to get type information and documentation
- **Tracing calls**: Use `incomingCalls`/`outgoingCalls` to understand call flows

**Why LSP is mandatory:**
- ✅ Zero false positives (Grep finds matches in comments/strings)
- ✅ Precise navigation (exact line/character positions)
- ✅ Token efficiency (no need to read full files)
- ✅ Type-aware analysis (understands code semantics)

Only use Grep/Glob for:
- Text pattern searches across multiple files
- Non-code files (markdown, config files)
- Initial broad exploration when you don't know symbol names yet

Depth: [quick/medium/very thorough]
```

**Example invocations:**

<example>
Task: "Explore the authentication module"
Prompt includes: "This TypeScript codebase requires LSP. Use `documentSymbol` on auth files to see all exported functions, then `findReferences` to trace usage, NOT Grep."
</example>

<example>
Task: "Plan implementation for new API endpoint"
Prompt includes: "This Go codebase requires LSP. Use `goToDefinition` to understand existing handler patterns, `hover` for type info, NOT file reading."
</example>

**Violation consequences:** Using Grep/Glob instead of LSP on TS/JS/Go files wastes tokens and produces false positives that mislead the analysis.

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
