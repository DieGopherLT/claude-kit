---
name: tdd-workflow
description: "Esta skill debe usarse cuando el usuario pide \"aplicar TDD\", \"desarrollo guiado por tests\", \"red green refactor\", \"escribir tests primero\", \"agregar tests al proyecto\", \"mejorar testabilidad\", \"cobertura de tests\", \"quiero tests para este modulo\", o menciona test-driven development, testing automatizado, o pipeline de testing. Proporciona workflow completo de TDD con agentes especializados para auditoria, adaptacion, investigacion de dependencias e implementacion de tests."
version: 1.0.0
user-invocable: true
---

# TDD Workflow

## Filosofia

Test-Driven Development no es una tecnica de testing. Es una disciplina de diseno donde los tests definen el comportamiento deseado antes de que exista el codigo. El resultado es codigo limpio, desacoplado y verificado por construccion.

### Iron Laws (innegociables)

1. **No escribir codigo de produccion sin un test que falle primero**: Todo codigo nace de un test rojo.
2. **No escribir mas test del necesario para producir un fallo**: Un test minimo, un comportamiento.
3. **No escribir mas codigo de produccion del necesario para pasar el test**: La solucion mas simple que haga pasar el test.

Violar cualquiera de estas leyes invalida el proceso completo.

### Ciclo Red-Green-Refactor

Cada iteracion produce un incremento minimo de funcionalidad verificada:

1. **RED**: Escribir un test que falle. Ejecutarlo. Confirmar que falla por la razon correcta.
2. **GREEN**: Escribir el codigo minimo para pasar el test. Ejecutar toda la suite. Confirmar cero regresiones.
3. **REFACTOR**: Mejorar codigo y tests sin cambiar comportamiento. Ejecutar suite despues de cada cambio.

Cada ciclo completo toma entre 1 y 10 minutos. Si un ciclo toma mas de 15 minutos, el incremento es demasiado grande.

## Agentes disponibles

El plugin provee 4 agentes especializados que forman un pipeline:

### Pipeline completo (para proyectos existentes)

```
testability-auditor --> code-adapter --> testing-deps-investigator --> test-implementer
     (analiza)          (adapta)           (investiga deps)           (implementa)
```

| Agente | Funcion | Cuando usarlo |
|--------|---------|---------------|
| **testability-auditor** | Analiza testabilidad del codigo, genera score 0-100 | Antes de escribir tests para codigo existente |
| **code-adapter** | Refactoriza para testabilidad sin cambiar comportamiento | Cuando el score de testabilidad es menor a 80 |
| **testing-deps-investigator** | Investiga y recomienda dependencias de testing | Cuando el proyecto no tiene infraestructura de tests |
| **test-implementer** | Implementa tests con TDD estricto | Para escribir tests siguiendo Red-Green-Refactor |

### Uso individual de agentes

Cada agente puede usarse de forma independiente:

- **Solo auditoria**: Invocar `testability-auditor` para obtener un reporte sin hacer cambios
- **Solo investigacion**: Invocar `testing-deps-investigator` para saber que instalar
- **Solo implementacion**: Invocar `test-implementer` directamente si el codigo ya es testeable

## Comandos disponibles

### `/tdd:add-testing [path]`
Pipeline completo para agregar tests a un proyecto o modulo existente. Ejecuta los 4 agentes en secuencia, adaptando el codigo si es necesario e instalando dependencias.

### `/tdd:tdd-feature <descripcion>`
Desarrollo de una feature nueva usando TDD estricto. Hace un scan rapido de testabilidad, verifica dependencias, y ejecuta el ciclo Red-Green-Refactor para la feature.

## Objetivo de cobertura

El objetivo base es **80%+ de cobertura de lineas**. Este numero no es un fin en si mismo, sino un indicador de TDD bien aplicado. Si se sigue TDD estricto, la cobertura alta es consecuencia natural.

Herramientas por lenguaje:
- **Go**: `go test -cover ./...`
- **TypeScript**: `vitest run --coverage` o `jest --coverage`
- **C#**: `dotnet test --collect:"XPlat Code Coverage"`

## Lenguajes soportados

- **Go**: table-driven tests, `t.Run`, testify, gomock
- **TypeScript**: describe/it, AAA, vitest/jest, testing-library, msw
- **C#**: xUnit Fact/Theory, InlineData, FluentAssertions, Moq

## Rules de testing

El plugin incluye rules por lenguaje en `rules/`. Las rules no se auto-descubren desde plugins, por lo que deben copiarse al proyecto o al directorio global de Claude Code para activarlas.

Para copiar al proyecto actual:
```bash
mkdir -p .claude/rules
cp "$(claude plugin path tdd)/rules/go-testing.md" .claude/rules/
cp "$(claude plugin path tdd)/rules/ts-testing.md" .claude/rules/
cp "$(claude plugin path tdd)/rules/csharp-testing.md" .claude/rules/
```

Para copiar al directorio global (aplica a todos los proyectos):
```bash
cp "$(claude plugin path tdd)/rules/go-testing.md" ~/.claude/rules/
cp "$(claude plugin path tdd)/rules/ts-testing.md" ~/.claude/rules/
cp "$(claude plugin path tdd)/rules/csharp-testing.md" ~/.claude/rules/
```

Copiar solo las rules del lenguaje que aplique. Se activan automaticamente al editar archivos de test (`*_test.go`, `*.test.ts`, `*Tests.cs`).

## Material de referencia

Para informacion detallada, consultar:

- **[Anti-patrones de testing](references/testing-anti-patterns.md)**: 5 anti-patrones criticos y las 3 iron laws explicadas en detalle
- **[Ciclo Red-Green-Refactor](references/red-green-refactor.md)**: Ciclo detallado con ejemplos en Go, TypeScript y C#
- **[Estrategias de cobertura](references/coverage-strategies.md)**: Herramientas por lenguaje, interpretacion de reportes, estrategias para 80%+
