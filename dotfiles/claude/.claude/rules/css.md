---
paths: **/*.css
---

# CSS Standards

These are my standards for writing CSS in my projects.

## Mobile first

- Write styles for mobile devices first, then use media queries for larger screens.
- Use relative units (em, rem, %) for sizing to ensure responsiveness and consistency.
- Keep classes and their respective media queries together instead of separating them by screen size.

### Mobile first examples

```css
/* Mobile base */
.card {
  padding: 1rem;
  width: 100%;
}

/* Tablet */
@media (min-width: 768px) {
  .card {
    padding: 1.5rem;
    width: 50%;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .card {
    padding: 2rem;
    width: 33.333%;
  }
}
```

## Layout and positioning

- Prefer flexbox for one-dimensional layouts (either row or column).
  - Make flexbox the default layout option, specially on mobile first designs.
- Use CSS Grid for two-dimensional layouts (both rows and columns).
- Avoid using fixed or absolute positioning unless necessary for specific UI elements that:
  - Need to overlay other content (e.g., modals, tooltips).
  - Require specific placement that cannot be achieved with normal flow (e.g., sticky headers).
- Never use floats.

## Naming conventions

- Use BEM (Block Element Modifier) methodology for class naming to ensure clarity and maintainability.
  - Block: Represents a standalone component (e.g., `.button`).
  - Element: Represents a part of a block (e.g., `.button__icon`).
  - Modifier: Represents a different state or variation of a block or element (e.g., `.button__icon--active`).
- Use lowercase letters and hyphens for block names (e.g., `.main-header`, `.footer-links`).
- Avoid using IDs for styling; prefer classes for better reusability.
- Use descriptive names that reflect the purpose of the class (e.g., `.nav-bar`, `.card-title`).

## Transitions and animations

- Prefer native CSS animations over JavaScript for better performance and smoother effects.
- Use transitions for simple state changes (e.g., hover effects) and keyframes for more complex animations.
- Use `transform` and `opacity` properties for animations to leverage GPU acceleration.

### Transitions and animations examples

```css
/* Transition for state change */
.button {
  transition: transform 0.2s ease;
}
.button:hover {
  transform: scale(1.05);
}

/* Keyframe animation */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.modal {
  animation: fadeIn 0.3s ease;
}
```
