---
name: multirepo-plan
description: Esta skill debe usarse cuando el usuario pide "planear feature multi-repo", "coordinar cambios entre repositorios", "tienes acceso a ambos repositorios", "tienes acceso al repo del backend", "tienes acceso al repo del frontend", "feature que toca backend y frontend", "sincronizar APIs entre proyectos", o necesita planificar implementaciones coordinadas en multiples codebases con endpoints HTTP/REST como puntos de integracion.
model: claude-opus-4-5-20251101
version: 0.1.0
---

# Multi-Repository Planning

Skill for planning features that require coordinated changes across multiple repositories, generating flow documentation and independent implementation plans.

## Prerequisites

Before starting, gather from user:

1. **Path to second repository** (cwd is the first)
2. **Feature description** to implement

Do not assume roles (backend/frontend). Roles are determined by analysis.

## Workflow

### Phase 1: Shallow Indexing

Apply LSP Chain directly (without subagents) on both repositories. The goal is to identify integration candidates, not to deep dive.

Follow the flow described in [`references/lsp-chain-multirepo.md`](references/lsp-chain-multirepo.md), applying search patterns on each repo sequentially.

**Expected output:**

| Repo | Producer Candidates | Consumer Candidates |
|------|---------------------|---------------------|
| A (cwd) | [file:symbol, ...] | [file:symbol, ...] |
| B ({path}) | [...] | [...] |

### Phase 2: Selective Deep Dive

With identified candidates, determine if deeper analysis is needed. Invoke `explore-lsp` agents only when:

- Request/response types are unclear from documentSymbol
- Multiple abstraction layers exist (services calling other services)
- Data flow is not evident

**Invocation criteria:**

| Situation | Action |
|-----------|--------|
| Simple endpoint with clear types | Do not invoke, use hover/goToDefinition directly |
| Internal call chain | Invoke explore-lsp to trace flow |
| Generic types or any | Invoke explore-lsp to resolve actual types |
| Legacy code without types | Invoke explore-lsp + selective Read |

**Prompt for explore-lsp (when invoked):**

```text
Deep dive into {repo-path} for the following symbols: {candidate-list}.

Goal: Obtain concrete request/response types and trace internal dependencies.

Apply LSP Chain:
1. hover on each candidate symbol
2. goToDefinition for types
3. findReferences/incomingCalls if intermediate layers exist
4. Selective Read only if context is insufficient

Deliver:
- Symbol: {name}
  - Type: producer | consumer
  - Request: {type or schema}
  - Response: {type or schema}
  - Internal dependencies: [{file:symbol}, ...]
```

### Phase 3: Integration Mapping

With collected information (shallow + selective deep dive):

1. **Determine roles by correlation**
   - Cross-reference exposed endpoints with consumed APIs
   - Assign labels: `producer`, `consumer`, or `bidirectional`
   - A repo is `bidirectional` if it both exposes and consumes from the other

2. **Correlate contracts**
   - Endpoint in repo X -> Consumption in repo Y
   - Validate schemas match or document discrepancies
   - Identify shared vs duplicated types

3. **Identify change points**
   - New endpoints required
   - Modifications to existing endpoints
   - New consumers or modifications

4. **Determine implementation order**
   - Producers generally first (endpoint must exist)
   - In bidirectional flows, identify the "entry point"
   - Shared type dependencies
   - Deploy considerations

Generate `MULTIREPO-FLOW.md` using template in `templates/flow-diagram.md`.

### Phase 4: Parallel Planning

Launch two `Plan` agents with opus model in parallel:

**Plan Agent A:**

```text
Plan implementation of feature "{feature}" in {repo-a-name}.

FIRST: Use TaskCreate to create tasks representing the plan steps.
This enables tracking implementation progress.

Context:
- This repo is: {rol-repo-a}
- Flow diagram: @MULTIREPO-FLOW.md
- Identified files: {file-list}

Generate plan in standard plan mode format.
Include "Multi-Repo Dependencies" section indicating what must be ready in the other repo.
```

**Plan Agent B:**

```text
Plan implementation of feature "{feature}" in {repo-b-name}.

FIRST: Use TaskCreate to create tasks representing the plan steps.
This enables tracking implementation progress.

Context:
- This repo is: {rol-repo-b}
- Flow diagram: @MULTIREPO-FLOW.md
- Identified files: {file-list}

Generate plan in standard plan mode format.
Include "Multi-Repo Dependencies" section indicating what is expected from the other repo.
```

### Phase 5: Deliverables

Write generated files:

| File | Repo A Destination | Repo B Destination |
|------|--------------------|--------------------|
| `MULTIREPO-FLOW.md` | docs/ or root | docs/ or root (copy) |
| `PLAN-{repo-a}.md` | docs/ or root | - |
| `PLAN-{repo-b}.md` | - | docs/ or root |

**Location logic:**

- If `docs/` exists, write there
- Otherwise, write to project root

**File operations:**

```bash
# In repo A (cwd)
Write: {dest-a}/MULTIREPO-FLOW.md
Write: {dest-a}/PLAN-{repo-a}.md

# In repo B
cp {dest-a}/MULTIREPO-FLOW.md {path-b}/{dest-b}/
mv {cwd}/PLAN-{repo-b}.md {path-b}/{dest-b}/
```

## Resources

### Templates

- **[`templates/flow-diagram.md`](templates/flow-diagram.md)** - Mermaid template for flow diagram and contracts
- **[`templates/repo-plan.md`](templates/repo-plan.md)** - Wrapper for individual plans with multi-repo section

### References

- **[`references/lsp-chain-multirepo.md`](references/lsp-chain-multirepo.md)** - LSP Chain guide adapted for multi-repo context
