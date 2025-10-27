---
description: |
  Automatically invoked for FULL PROJECT refactoring of React JSX code involving template strings in className attributes and conditional rendering patterns. This is NOT a partial or incremental refactoring tool - it performs a comprehensive codebase-wide transformation.

  **Critical: This is a project-wide operation**
  - Scans and refactors the ENTIRE codebase, not individual files or components
  - Typically used once during codebase modernization or migration efforts
  - Requires careful planning and review due to its extensive scope
  - Best executed on a dedicated feature branch with proper backup

  **Primary Use Cases:**
  - One-time migration from template string className to clsx across entire project
  - Codebase-wide standardization of conditional rendering patterns
  - Major refactoring initiative to eliminate all ternary conditionals in JSX
  - Adopting clsx as a project-wide standard for className management

  **Automatic Invocation Triggers:**
  - User requests project-wide or codebase-wide React refactoring
  - Discussion about migrating entire project to clsx
  - Mentions of full codebase modernization or standardization
  - Planning large-scale refactoring of conditional rendering patterns

  **What This Command Does:**
  1. Launches parallel exploration agents to discover ALL occurrences across the entire project
  2. Installs clsx dependency if not present
  3. Refactors EVERY template string className pattern to clsx syntax
  4. Converts ALL conditional ternaries to && operators with proper edge case handling
  5. Adds imports to every affected file

  **Manual Invocation:**
  Use /refactor-conditional-jsx when initiating a complete project refactoring, typically as part of a planned codebase modernization effort or technical debt reduction sprint.

model: haiku
---

# JSX Refactor: Template Strings & Conditional Rendering

## Objective

Refactor JSX code to replace template strings with `clsx` and improve conditional rendering patterns.

## Steps

### 1. Discovery Phase (Parallel Execution)

Launch two explorer agents simultaneously:

**Agent 1 - Template String Hunter:**

- Search for template strings in JSX className attributes
- Pattern: `className={\`...\`}`
- Capture all occurrences with file paths and line numbers

**Agent 2 - Ternary Hunter:**

- Search for ternary operators used for conditional rendering in JSX
- Pattern: `{condition ? <Component /> : null}` and variations
- Capture all occurrences with file paths and line numbers

Wait for both agents to complete before proceeding.

### 2. Installation

Check if `clsx` is installed. If not:

```bash
npm install clsx
```

### 3. Refactor Template Strings

Replace all findings from Agent 1:

**Before:**

```jsx
className={`base-class ${isActive ? 'active' : ''} ${variant}`}
```

**After:**

```jsx
className={clsx('base-class', isActive && 'active', variant)}
```

Add import: `import clsx from 'clsx';`

### 4. Refactor Conditional Rendering

Replace all findings from Agent 2, handling edge cases:

**Edge cases to handle:**

- Numeric values (0 should not render)
- Empty strings
- Empty arrays
- Nullish values

**Before:**

```jsx
{count > 0 ? <Component /> : null}
{items.length ? <List items={items} /> : null}
```

**After:**

```jsx
{count > 0 && <Component />}
{items.length > 0 && <List items={items} />}
```

**Critical:** Ensure `&&` left side is always boolean to avoid rendering `0`, `""`, or `NaN`.

## Expected Outcome

- All template strings in className replaced with `clsx`
- All conditional ternaries replaced with `&&` operator
- No false-positive renders
- Proper `clsx` imports added
