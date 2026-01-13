---
paths: **/*.{html,tsx,jsx}
---

# HTML Semantics

Guidelines for writing semantic and accessible HTML.

## Structural elements

- Use `<main>` for the primary content of the page (only one per page).
- Use `<section>` for thematic groupings of content with a heading.
- Use `<article>` for self-contained, independently distributable content (blog posts, comments, widgets).
- Use `<aside>` for tangentially related content (sidebars, pull quotes).
- Avoid generic `<div>` elements when semantic alternatives exist.

### Structural elements examples

```html
<main>
  <section>
    <h2>Featured Products</h2>
    <article>
      <h3>Product Name</h3>
      <p>Description</p>
    </article>
  </section>
</main>
```

## Sectioning content

- Every `<section>`, `<article>`, and `<aside>` can have its own `<header>` and `<footer>`.
- Page-level `<header>` contains site branding and main navigation.
- Page-level `<footer>` contains site-wide information (copyright, links).
- Section-level headers/footers contain content specific to that section.

### Sectioning content examples

```html
<!-- Page level -->
<header>
  <h1>Site Name</h1>
  <nav><!-- main navigation --></nav>
</header>

<main>
  <!-- Section level -->
  <article>
    <header>
      <h2>Article Title</h2>
      <p>By Author • Date</p>
    </header>
    <p>Content...</p>
    <footer>
      <p>Tags: HTML, CSS</p>
    </footer>
  </article>
</main>

<footer>
  <p>&copy; 2026 Company</p>
</footer>
```

## Navigation

- Use `<nav>` for major navigation blocks (main menu, table of contents, pagination).
- Not every group of links needs `<nav>` (e.g., footer links can be a simple list).
- Prefer one main `<nav>` inside the page `<header>` for primary navigation.

### Navigation examples

```html
<header>
  <nav aria-label="Main navigation">
    <ul>
      <li><a href="/">Home</a></li>
      <li><a href="/about">About</a></li>
    </ul>
  </nav>
</header>
```

## Lists and text

- Use `<ul>` for unordered lists, `<ol>` for ordered lists.
- Use `<dl>`, `<dt>`, `<dd>` for term-definition pairs (glossaries, metadata).
- Never use `<br>` for spacing; use CSS margins/padding instead.
- Use `<strong>` for importance, `<em>` for emphasis (not `<b>` or `<i>` unless purely stylistic).

### Lists and text examples

```html
<!-- Definition list -->
<dl>
  <dt>HTML</dt>
  <dd>HyperText Markup Language</dd>
  <dt>CSS</dt>
  <dd>Cascading Style Sheets</dd>
</dl>

<!-- Emphasis -->
<p>This is <strong>very important</strong> and <em>emphasized</em>.</p>
```
