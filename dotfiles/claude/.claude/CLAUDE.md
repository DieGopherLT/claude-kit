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
- On user prompt, **proactively verify** if an **agent** or **skill** can fulfill the request before addressing it yourself.

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

### MCPs

#### Sequential Thinking

- **Purpose**: Dynamic problem-solving through structured thought processes
- **Use proactively when**:
  - User message is 150+ words describing a complex problem
  - User presents multiple potential solutions/approaches
  - Problem scope is unclear or has multiple interacting factors
  - Evaluating trade-offs between 3+ viable options
  - Need to filter relevant from irrelevant information
  - **After 2-3 failed attempts** (STOP and reassess strategy before trying more)
  - Debugging requires tracing through multiple layers/modules

#### Context7

- **Purpose**: up-to-date third-party package documentation for quick reference
- Do not sleep on `agent-dependency-docs-collector` existence, especially when integrating new packages or troubleshooting.

- **Use Context7 directly when**:
  - Quick API reference (e.g., "how to use `useQuery` hook?")
  - Syntax verification during active coding
  - Single method/function lookup
  - User asks specific "how to..." questions about known packages (e.g. express, lodash)

- **Use agent-dependency-docs-collector when**:
  - Integrating new package from scratch
  - Troubleshooting errors with third-party deps
  - Version migrations/upgrades
  - Need installation + configuration plan
  - Multiple dependencies setup

- When user mentions a third-party package, analyze intent:
  - Quick question → Context7 direct
  - Setup/integration → agent-dependency-docs-collector
  - If unsure, ask the user

**NEVER use context7 for language standard library documentation.**

### General Operations

- File moves: use `git mv` instead of rewriting
- When commiting code, do not include any co-authorying information.
