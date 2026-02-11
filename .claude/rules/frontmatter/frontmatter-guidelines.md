---
paths:
  - "**/agents/**/*.md"
  - "**/skills/**/*.md"
  - "**/commands/**/*.md"
---

# Frontmatter Best Practices

## Language: Spanish (Español)

**All agent and skill frontmatter descriptions MUST be written in Spanish.** This facilitates activation since Diego interacts with Claude in Spanish.

## Description Format

### For Skills (Third Person)

Skills must use third-person format with specific trigger phrases:

```yaml
---
name: skill-name
description: Esta skill debe usarse cuando el usuario pide "frase específica 1", "frase específica 2", "frase específica 3", o menciona contextos relevantes. Proporciona [breve descripción de lo que ofrece].
---
```

**Characteristics:**

- Start with "Esta skill debe usarse cuando el usuario pide..."
- Include 5-8 specific phrases users would say (between quotes)
- Add contextual mentions after "o menciona..."
- End with value proposition ("Proporciona...")
- Use concrete, action-oriented triggers

**Good example:**

```yaml
description: Esta skill debe usarse cuando el usuario pide "dominar el sistema de tipos de TypeScript", "implementar tipos genéricos", "crear tipos condicionales", "refactorizar biblioteca TypeScript", "refactorizar tipados", "migrar de JavaScript a TypeScript", o menciona tipos mapeados, tipos literales de plantilla, o tipos utilitarios. Proporciona guía completa para construir aplicaciones type-safe.
```

**Bad example:**

```yaml
description: Use when working with TypeScript types.  # Wrong language, vague, no triggers
```

### For Agents (Third Person)

Agents also use third-person format with triggering conditions:

```yaml
---
name: agent-name
description: Este agente debe usarse cuando [condición específica 1], [condición específica 2], o cuando se necesite [capacidad específica]. [Descripción de lo que hace].
---
```

**Characteristics:**

- Start with "Este agente debe usarse cuando..."
- Describe conditions, not user phrases (agents are invoked by Claude, not users)
- Focus on scenarios and technical conditions
- Be specific about what the agent analyzes, generates, or validates

**Good example:**

```yaml
description: Este agente debe usarse cuando se crean nuevos módulos de 3+ archivos, se modifican 4+ archivos, o tras ejecutar un plan aprobado con 5+ archivos. Asegura que el código nuevo siga los patrones y convenciones del proyecto existente.
```

## Validation Checklist

Before finalizing agent/skill:

- [ ] Description in Spanish
- [ ] Third-person format ("Esta skill debe usarse cuando..." / "Este agente debe usarse cuando...")
- [ ] Up to 8 specific trigger phrases (skills) or conditions (agents)
- [ ] Contextual mentions included
- [ ] Value proposition clear
- [ ] Body uses imperative form
- [ ] Progressive disclosure applied (skills)
- [ ] Introspection performed with Diego for activation keywords
