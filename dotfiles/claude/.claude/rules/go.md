---
paths: **/*.go
---

# Go Standards

These are my preferences and guidelines for writing Go code.

## General

- Always ensure code compiles and passes tests before submitting changes.
- Do not sleep on `LSP` tool for code navigation and symbol exploration.
- Use `go fmt` to format code consistently when finishing coding.
- Use a `bin` directory in projects to output compiled binaries.

## Package naming guidelines

Choose one of the following strategies for naming packages:

- According to its functionality, using a single, concise word (e.g., `http`, `json`, `util`).
- According to the domain or context it serves (e.g., `auth`, `payment`, `storage`).

### Naming conventions for symbols inside a package

- Play with the package name to create meaningful symbol names (e.g., `http.Client`, `json.Marshal`).
  - Avoid redundant package prefixes in symbol names (e.g., `util.UtilFunction`) is bad
  - Think of the package as a namespace to avoid redundancy.
  - Think about how the symbol will look when used outside the package.
- Use pascal case for exported symbols (e.g., `GetUser`, `ProcessData`).
- Use camel case for unexported symbols (e.g., `calculateSum`, `fetchData`).
- When exporting a function that serves as a constructor for a struct, name it `New<Type>` (e.g., `NewClient`, `NewServer`).
  - Unless it is obvious from the package name (e.g., `database.NewDB`, it should be `database.New`).

## Concurrency

- Do not use anonymous goroutines for long-running tasks; always name them for better stack traces.
  - In general, avoid anonymous goroutines unless they are very short-lived and simple.
- When using `sync.WaitGroup`, always pass it by parameters (reference) to goroutines for better traceability.

## Libraries

Always install these libraries on personal projects, confirm with user that is ok to add them.

- [Loadash like Go library](https://github.com/samber/lo), useful to work with collections in a functional way.
