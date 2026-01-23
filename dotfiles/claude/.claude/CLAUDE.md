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

### Git operations

- File moves: use `git mv` instead of rewriting
- File deletions: use `git rm` instead of regular `rm`.
- When committing code, do not include any CLAUDE co-authoring information.
- Branch names: short, descriptive, kebab-case (feature/add-login, fix/payment-bug)
  - Always create a branch when user requests a feature or bugfix.
- Do not commit changes until user approves them.
- Commit messages: one line summary up to 96 chars using prefixes (feat:, fix:, docs:, style:, refactor:, test:, chore:, wip:)
  - Example: `feat: add user authentication with JWT`, `fix: resolve payment processing bug`
- Pull requests: **ALWAYS** use the `dotclaudefiles:create-pr` skill unless told otherwise.
- Branch order: user likes the cleanest possible history.
  - Prefer rebase and squash over merge commits; only merge when fast-forward is possible.
  - Avoid unnecessary commits that don't add value.
  - Combine small related changes into single commits.
