---
paths: **/*.go
---

# Go Standards

- Follow standard Go conventions (gofmt, golint)
- Error handling: always check errors, wrap with context using fmt.Errorf or errors package
- Naming: use MixedCaps, not underscores; short names for local scope, descriptive for exported
- Interfaces: define at consumer side, keep small (1-3 methods)
- Concurrency: prefer channels for communication, sync primitives for state protection
- Structure: group related declarations, blank line between logical sections
