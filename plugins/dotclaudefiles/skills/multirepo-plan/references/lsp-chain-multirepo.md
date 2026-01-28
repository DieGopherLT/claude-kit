# LSP Chain for Multi-Repository Context

Adaptation of LSP Chain for coordinated exploration of multiple repositories.

## Base Flow (Reminder)

```text
[Glob/Grep] -> Candidate
    |
[documentSymbol] -> Index (once per file)
    |
[hover/goToDefinition] -> Understand symbol
    |
[findReferences/incomingCalls] -> Expand
    |
[Dead end?] -> New chain or done
```

## Multi-Repo Adaptations

### Search Patterns (Without Assuming Roles)

Each repo can be producer, consumer, or both. Search both patterns in each repo.

**Producer Patterns (exposes endpoints):**

```bash
# Routes/handlers
Glob: **/routes/**/*.{ts,js,go}
Glob: **/handlers/**/*.{ts,js,go}
Glob: **/controllers/**/*.{ts,js,go}
Grep: "router\.(get|post|put|delete|patch)"
Grep: "@(Get|Post|Put|Delete|Patch)\("

# Exposed schemas
Glob: **/dto/**/*.{ts,go}
Glob: **/schemas/**/*.{ts,js}
```

**Consumer Patterns (consumes APIs):**

```bash
# HTTP calls
Grep: "fetch\(|axios\.|http\."
Grep: "useSWR|useQuery|useMutation"
Glob: **/api/**/*.{ts,js}
Glob: **/services/**/*.{ts,js}
Glob: **/clients/**/*.{ts,js,go}

# Expected types
Glob: **/types/**/*.{ts,d.ts}
Grep: "interface.*Response|type.*Response"
```

**Bidirectional Patterns (gRPC, events):**

```bash
Grep: "grpc|protobuf|\.proto"
Glob: **/proto/**/*
Grep: "EventEmitter|\.emit\(|\.on\("
```

### Type Correlation

When finding an endpoint in repo A and its consumer in repo B:

1. **In repo A**: `hover` over response type
2. **In repo B**: `hover` over expected type
3. **Compare**: Fields, types, optionality

Document discrepancies in the flow diagram.

### Multi-Repo Dead End Signals

Beyond standard dead ends (node_modules, stdlib):

- **Outgoing HTTP call**: Flow continues in another repo
- **Type imported from shared package**: May require reviewing the package
- **Event emitter/queue**: Consumer is in another service

Mark these points as **"Boundary"** instead of dead end.

### Multi-Repo Memoization

Maintain separate indexes per repository:

```text
repo-a-index:
  - src/routes/users.ts: [symbols...]
  - src/handlers/auth.ts: [symbols...]

repo-b-index:
  - src/api/userService.ts: [symbols...]
  - src/hooks/useAuth.ts: [symbols...]
```

Do not mix indexes between repos to avoid path confusion.

## Prompt for Explore-LSP Agents

Unified prompt that searches both roles in any repository:

```text
Explore {repo-path} to map integration points related to "{feature}".

Apply LSP Chain searching BOTH patterns:

**As Producer (if exposes APIs):**
1. Glob: **/routes/**/*.{ts,js,go}, **/handlers/**/*.{ts,js,go}
2. Grep: "router\.(get|post|put|delete)" or HTTP decorators
3. documentSymbol + hover for request/response types
4. findReferences for internal usage

**As Consumer (if consumes APIs):**
1. Grep: "fetch|axios|http\." in **/*.{ts,tsx,js,go}
2. documentSymbol on files with matches
3. goToDefinition on URLs/endpoints
4. findReferences to see where data is used

Deliver neutral structure:
- Exposed endpoints: [{method, path, requestType, responseType, file:line}]
- Consumed APIs: [{url, method, expectedType, file:line}]
- Files relevant to the feature
```

## Troubleshooting

### LSP not responding in secondary repo

LSP may not be initialized for the second repo. Solutions:

1. Open the repo in IDE first to initialize LSP
2. Use Glob/Grep as fallback with selective Read
3. Trust naming patterns and structure

### Types don't match between repos

Common when there's no shared package. Document in diagram:

```markdown
## Type Discrepancies

| Field | Repo A | Repo B | Action |
|-------|--------|--------|--------|
| userId | string | number | Align to string |
```

### Too many candidate files

Add filters to initial Glob:

```bash
# Instead of **/*.ts
Glob: src/routes/**/*.ts  # More specific
Grep: "userRouter|authRouter"  # By naming
```
