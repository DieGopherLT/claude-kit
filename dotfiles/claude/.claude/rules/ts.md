---
paths: **/*.{ts,js,tsx,jsx}
---

# TypeScript and JavaScript

When about to install, update or delete dependencies, check which package manager is being used in the project (npm, yarn or pnpm) and use it consistently.

## LSP Tool - Mandatory

- **PREFER `LSP` tool over Grep/Glob** for code navigation (more precise, fewer tokens, AND **NO FALSE POSITIVES**):
  - Finding definitions: `goToDefinition` → jump directly to where symbol is defined
  - Finding all usages: `findReferences` → only real usages, not comments/strings
  - Understanding structure: `documentSymbol` → see all methods/properties without reading full file
  - Tracing call flows: `incomingCalls`/`outgoingCalls` → who calls this function, what does it call
  - Type information: `hover` → get types/docs without opening files
  - **Use Grep/Glob only for**: text patterns, multi-file search, non-code files, initial exploration

## Promises

- Use `Promise.allSettled()` instead of `Promise.all()` unless you need to fail fast
- Never use async inside forEach - create promise arrays and use `Promise.allSettled()`
- Same applies to for-await pattern

```typescript
// Bad
items.forEach(async (item) => {
  const result = await asyncOperation(item);
  results.push(result);
});
// Good
const promises = items.map(item => asyncOperation(item));
const results = await Promise.allSettled(promises);
```

## Conditionals

- Avoid nested conditions by using guard clauses to improve code readability and maintainability.
  - If a condition triggers a single line of code, do not add braces `{}` to it.
  - And do not write the triggered code in a separate line, keep it in the same line as the condition.
- Prefer using switch statements over multiple if-else statements when dealing with multiple discrete values for a single variable.
- Never use inline objects or arrays when using ternary operators, as it makes code harder to read. Make sure to define them outside the ternary expression.
- Avoid using `else` keyword unless its necessary for clarity. Instead, use early returns to reduce nesting and improve readability. Find alternatives to `else` whenever possible.

## Use guard clauses instead of nested conditions

- Prefer switch over multiple if-else for discrete values
- Never inline objects/arrays in ternaries - define outside
- Avoid `else` - use early returns

```typescript
// Bad - nested conditions
if (user) {
  if (user.isActive) {
    if (user.hasPermission) {
      return processUser(user);
    }
  }
}
return null;

// Good - guard clauses
if (!user) return null;
if (!user.isActive) return null;
if (!user.hasPermission) return null;
return processUser(user);

// Bad - multiple if-else
if (status === 'pending') {
  return 'yellow';
} else if (status === 'approved') {
  return 'green';
} else if (status === 'rejected') {
  return 'red';
} else {
  return 'gray';
}

// Good - switch
switch (status) {
  case 'pending': return 'yellow';
  case 'approved': return 'green';
  case 'rejected': return 'red';
  default: return 'gray';
}

// Bad - inline objects in ternary
const config = isProduction ? { api: 'prod.com', timeout: 5000 } : { api: 'dev.com', timeout: 10000 };

// Good - define outside
const prodConfig = { api: 'prod.com', timeout: 5000 };
const devConfig = { api: 'dev.com', timeout: 10000 };
const config = isProduction ? prodConfig : devConfig;

// Bad - unnecessary else
function getDiscount(amount) {
  if (amount > 100) {
    return 0.2;
  } else {
    return 0.1;
  }
}

// Good - early return
function getDiscount(amount) {
  if (amount > 100) return 0.2;
  return 0.1;
}paradigm for data transformations and operations, specially when
working with arrays.
```

## Functional paradigm

- Prefer using array methods like `map`, `filter`, and `reduce` over traditional loops for better readability and maintainability.
- Avoid mutating state directly; instead, return new instances of objects or arrays to maintain immutability.
- Use pure functions that do not have side effects, making them easier to test and reason about
- Embrace higher-order functions to create more abstract and reusable code components.
- When adding an element to an array, prefer using the spread operator or `concat` method to create a new array instead of using `push`, which mutates the original array.
- When removing an element from an array, prefer using `filter` to create a new array without the unwanted element instead of using `splice`, which mutates the original array.
- Make sure to create a copy of an array when using `reverse`, as it mutates the original array.

### Functional paradigm code examples (oversimplified)

```typescript
// Bad - push mutates
numbers.push(4);
// Good - spread creates new
const newNumbers = [...numbers, 4];

// Bad - splice mutates
items.splice(1, 1);
// Good - filter creates new
const newItems = items.filter((_, i) => i !== 1);

// Bad - reverse mutates
original.reverse();
// Good - copy then reverse
const reversed = [...original].reverse();

// Bad - loop
const names = [];
for (let i = 0; i < users.length; i++) {
  names.push(users[i].name);
}
// Good - map
const names = users.map(u => u.name);

// Bad - mutation
const updateUser = (user) => {
  user.lastUpdated = new Date();
  return user;
};
// Good - new object
const updateUser = (user) => ({ ...user, lastUpdated: new Date() });

// Bad - side effects
const processItems = (items) => {
  let total = 0;
  for (const item of items) {
    total += item.price;
    item.processed = true;
  }
  return total;
};
// Good - pure functions
const calculateTotal = (items) => items.reduce((sum, item) => sum + item.price, 0);
const markProcessed = (items) => items.map(item => ({ ...item, processed: true }));
```
