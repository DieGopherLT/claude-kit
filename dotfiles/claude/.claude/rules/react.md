---
paths: **/*.{tsx,jsx}
---

# React Standards

- useEffect: aggressively minimize dependencies, find alternative patterns before adding deps
- Avoid: useCallback/useMemo unless proven performance issue
- State: lift state only when necessary, prefer local state
- className: use clsx or similar library over template strings
- JSX conditionals: use && operator, handle all cases explicitly (no ternaries)

## When proposing UI/UX changes

- Read theme configuration first (tailwind.config.js, theme.ts, design tokens, explore for styles)
- Detect existing color palette and spacing scale
- Respect established patterns unless there's a strong reason to deviate
- Ask before introducing new colors or breaking existing design system
- Validate information hierarchy (primary user goal = visual dominance)
