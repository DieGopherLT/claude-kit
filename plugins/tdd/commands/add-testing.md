---
description: "Pipeline completo para agregar tests a un proyecto o modulo existente"
argument-hint: "[path]"
allowed-tools: None
---

# Add Testing - Pipeline completo de TDD

Agregar tests a un proyecto o modulo existente siguiendo el pipeline TDD completo.

**Path objetivo:** $ARGUMENTS (si esta vacio, usar el directorio del proyecto actual)

## Pipeline de ejecucion

### Paso 1: Auditoria de testabilidad

Invocar el agente `testability-auditor` en el path indicado:
- Analizar acoplamiento, estado global, dependencias ocultas
- Generar reporte con score 0-100
- Identificar issues criticos y moderados por archivo

### Paso 2: Adaptacion de codigo (condicional)

Si el score de testabilidad es **menor a 80**:
- Invocar el agente `code-adapter` con el reporte del paso 1
- Aplicar refactorings: extraccion de interfaces, inyeccion de dependencias, separacion I/O
- Verificar compilacion despues de cada cambio
- Re-evaluar score si es necesario

Si el score es **80 o superior**, saltar al paso 3.

### Paso 3: Investigacion de dependencias

Invocar el agente `testing-deps-investigator`:
- Detectar lenguaje y ecosistema del proyecto
- Evaluar dependencias de testing existentes
- Recomendar frameworks, assertion libraries y herramientas de cobertura
- Presentar comandos de instalacion al usuario

Preguntar al usuario antes de instalar dependencias. Usar `AskUserQuestion` para confirmar las dependencias a instalar.

### Paso 4: Implementacion de tests

Invocar el agente `test-implementer` modulo por modulo:
- Seguir TDD estricto: RED -> GREEN -> REFACTOR
- Ejecutar cada test y confirmar que falla antes de implementar
- Verificar que toda la suite pasa despues de cada implementacion
- Cubrir: casos degenerados, simples, generales, borde y error

Si el path contiene multiples modulos independientes, procesar en paralelo cuando sea posible.

### Paso 5: Reporte final

Ejecutar herramienta de cobertura del lenguaje y reportar:
- Cobertura total del proyecto/modulo
- Cobertura por archivo
- Archivos que no alcanzan 80%
- Numero de tests creados
- Resumen de refactorings aplicados (si hubo)
