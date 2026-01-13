---
paths: **/*.{tsx,jsx}
---

# React Standards

Guidelines and my preferred practices for writing React components and hooks.

## State management

- On simple components, prefer using `useState` for local state, using an `useState` per piece of state.
  - It means no objects as state unless absolutely necessary.
- When handling 5+ related state variables with complex or batched updates, consider using `useReducer` for better state management.
  - When using `useReducer`, make sure to add data types for all values and actions.
  - Define everything in a separate file, if the component at is about to receive a reducer is a single file component, convert it to a directory with index file.

### Global state

- On new or small projects, install `zustand` for global state management.
- On existing projects using `redux`, continue using it but prefer `redux-toolkit` patterns and hooks API (`useSelector`, `useDispatch`).
- Avoid using Context API for global state management unless it's for theming, localization or building providers.

## UseEffect

- Prefer multiple useEffect hooks for separate concerns instead of combining unrelated logic.
- If a useEffect dependency is a pure function defined in the same component, rewrite it outside the component to avoid re-creation on each render.
- Do not overlook cleanup functions for effects that subscribe to external data sources or set up timers.
- When exhaustive-deps warns about missing dependencies, fix the root cause instead of blindly adding them:
  - Pure functions: move outside component
  - Callbacks: use useCallback only when necessary (child re-renders, external dependencies)
  - Complex objects: extract primitive values (IDs, strings, numbers) to use as dependencies instead of the whole object

### UseEffect examples

```tsx
// BAD: Combining unrelated logic
useEffect(() => {
  fetchUserData();
  startTimer();
}, [userId]);

// GOOD: Separate concerns
useEffect(() => {
  fetchUserData();
}, [userId]);

useEffect(() => {
  const interval = setInterval(() => tick(), 1000);
  return () => clearInterval(interval);
}, []);
```

```tsx
// BAD: Function recreated every render
function MyComponent({ id }) {
  const processData = (data) => data.filter(x => x.id === id);
  
  useEffect(() => {
    const result = processData(apiData);
  }, [processData]); // Runs every render!
}

// GOOD: Pure function outside component
const processData = (data, id) => data.filter(x => x.id === id);

function MyComponent({ id }) {
  useEffect(() => {
    const result = processData(apiData, id);
  }, [id]);
}
```

```tsx
// GOOD: Cleanup for subscriptions
useEffect(() => {
  const subscription = dataSource.subscribe(handleData);
  return () => subscription.unsubscribe();
}, [dataSource]);
```

## Conditional rendering

- Prefer short-circuit evaluation (`&&`) over ternary operators for simple conditional rendering.
  - Use `{condition && <Component />}` instead of `{condition ? <Component /> : null}`
  - Cover all edge cases, so for each ternary, you'll have likely one or two short-circuits.
  - Only use ternaries when rendering alternative content (both branches have JSX).
- Whenever finding too nested conditionals, consider breaking into smaller components or using helper functions.
  - Plus: It's cleaner to write a component that returns null for the negative case than nesting everything inside conditionals.
- When using conditional CSS classes, consider libraries like `clsx` or `classnames` for better readability instead of complex template literals.

## Importation order inside components

I have a preference for the following order:

1. React and related libraries (e.g., `react`, `react-dom`, `react-router`)
2. Third-party libraries (e.g., `lodash`, `axios`, `redux`)
3. Project components (e.g., `components/Button`, `components/Header`)
4. Hooks (e.g., `hooks/useAuth`, `hooks/useFetch`)
5. Utilities and helpers (e.g., `utils/formatDate`, `utils/apiClient`)
6. Styles and assets (e.g., `styles/main.css`, `assets/logo.png`

## Forms

- For simpler forms (1-2 fields), prefer using controlled components with local state management via `useState` or `useReducer`.
- For complex forms (3+ fields, async validation, or multi-step flows), install `react-hook-form` and use it to manage form state and validation.

## Split business logic and rendering

- Separate components into logic (container) and presentation (UI) components when they grow beyond 150 lines or have complex logic.
  - Alternatively, consider using custom hooks to encapsulate logic.
- Logic components handle data fetching, state management, and business logic.
- Presentation components focus solely on rendering UI based on props.

### Split business logic example

```tsx
// useUserProfile.ts
function useUserProfile(userId) {
  const [data, setData] = useState(null);
  useEffect(() => {
    fetch(`/api/users/${userId}`)
      .then(res => res.json())
      .then(setData);
  }, [userId]);
  return data;
}

// UserProfile.tsx
function UserProfile({ userId }) {
  const data = useUserProfile(userId);
  if (!data) return <div>Loading...</div>;
  return <div><h1>{data.name}</h1></div>;
}
```
