# User Preferences for Claude

## User Identity

- **Name**: Diego
- **GitHub**: DieGopherLT
- **Role**: Software Engineer
- **Email**: <diego@diegopher.dev>

## User relevant information

- **Preferred programming languages**: Go, TypeScript, C#
- My terminal shell is **fish**.

## Session Behavior

- When asking questions, use proactively `AskUserQuestion` tool.
  - Specially when you have suggestions or questions are closed.
- If not in plan mode and user suggests a plan or a request is is beyond a few edits, then **enter plan mode**.

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

## Tools & Workflows

- Prioritize using `claudefiles` plugin skills.
  - That plugin is user's set of custom skills for his personal workflows.
- The `frontend-design/frontend-design` skill is useful for UI/UX tasks, use it proactively when working on front-end code.
  - Of course follow project's design system and guidelines first.

### Git operations

- File moves: use `git mv` instead of rewriting
- When commiting code, do not include any co-authorying information.
- Branch names: short, descriptive, kebab-case (feature/add-login, fix/payment-bug)
  - Always create a branch when user requests a feature or bugfix.
- Do not commit changes until user approves them.
- Commit messages: one line summary up to 72 chars using prefixes (feat:, fix:, docs:, style:, refactor:, test:, chore:, wip:)
  - Example: `feat: add user authentication with JWT`
- Pull requests: **ALWAYS** use the `claudefiles:create-pr` skill unless told otherwise.
- Branch order: user's like the cleanest possible history.
  - Prefer rebase and squash over merge commits; only merge when fast-forward is possible.
  - Avoid unnecessary commits that don't add value.
  - Combine small related changes into single commits.
