---
description: Project-wide React JSX refactoring (clsx + conditional rendering). ⚠️ CRITICAL: Full codebase operation. Triggers: migrate clsx, refactor all jsx, codebase-wide react modernization
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
