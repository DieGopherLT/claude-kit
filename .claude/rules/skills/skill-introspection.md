---
paths:
  - "**/skills/**"
---

# Skill Development & Introspection

## Progressive Disclosure (Skills Only)

Skills should follow progressive disclosure:

1. **SKILL.md body**: Core concepts, essential procedures (1,500-2,000 words ideal, <3,000 max)
2. **references/**: Detailed patterns, advanced techniques, comprehensive docs (2,000-5,000+ words each)
3. **examples/**: Working code, configuration files, templates
4. **scripts/**: Validation, testing, automation utilities

Keep frontmatter + core content lean; move detailed information to references.

## Introspection for Activation Keywords

When creating or refining skill frontmatter, engage in collaborative introspection:

- **Ask Diego about real usage patterns**: "¿Cómo describirías esta tarea cuando me la pides?"
- **Test trigger phrases**: Present 3-4 trigger phrase options and ask which feels most natural
- **Explore related vocabulary**: "¿Qué otras palabras usarías para pedir esto?"
- **Validate context mentions**: "Además de estas frases, ¿qué conceptos o términos técnicos mencionarías?"
- **Iterate based on feedback**: After creating frontmatter, ask "¿Estas frases de activación capturan bien cuándo usarías esta skill?"

**Introspection benefits:**

- Captures Diego's natural language patterns
- Increases activation accuracy
- Reduces false negatives (skill not triggering when it should)
- Creates more intuitive plugin experience

## Writing Style

**Body content:**

- Use imperative/infinitive form (verb-first instructions)
- NOT second person ("you should...")
- Objective, instructional language

**Correct:**

```markdown
Para crear un hook, definir el tipo de evento.
Validar la configuración antes de usar.
```

**Incorrect:**

```markdown
Debes crear un hook definiendo el tipo de evento.
Tienes que validar la configuración.
```
