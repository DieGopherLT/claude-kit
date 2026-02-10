---
description: "Desarrollo de una feature nueva usando TDD estricto"
argument-hint: "<descripcion de la feature>"
allowed-tools: None
---

# TDD Feature - Desarrollo guiado por tests

Desarrollar una nueva feature usando TDD estricto con ciclo Red-Green-Refactor.

**Feature a desarrollar:** $ARGUMENTS

## Pipeline de ejecucion

### Paso 1: Quick scan de testabilidad

Invocar el agente `testability-auditor` enfocado en el area del proyecto donde se implementara la feature:
- Scan rapido del modulo o directorio relevante
- Identificar si el area es testeable o necesita adaptacion
- Si el score es menor a 80, invocar `code-adapter` antes de continuar

### Paso 2: Verificacion de dependencias

Verificar si el proyecto tiene infraestructura de testing:
- Buscar archivos de test existentes
- Verificar frameworks de testing instalados
- Si no hay infraestructura, invocar `testing-deps-investigator`
- Preguntar al usuario antes de instalar dependencias nuevas

### Paso 3: Descomposicion de la feature

Antes de escribir codigo, descomponer la feature en comportamientos testeables:
1. Identificar los comportamientos atomicos que componen la feature
2. Ordenarlos por complejidad (degenerado -> simple -> general -> borde -> error)
3. Presentar el plan de implementacion al usuario

### Paso 4: Ciclo TDD estricto

Invocar el agente `test-implementer` para implementar la feature:
- Para cada comportamiento identificado en el paso 3:
  1. **RED**: Escribir test que falle
  2. Ejecutar y verificar que falla por la razon correcta
  3. **GREEN**: Implementar codigo minimo
  4. Ejecutar y verificar que pasa (toda la suite)
  5. **REFACTOR**: Mejorar si es necesario
  6. Ejecutar y verificar que sigue verde

### Paso 5: Reporte de cobertura

Al terminar la feature:
- Ejecutar herramienta de cobertura del lenguaje
- Reportar cobertura de los archivos nuevos/modificados
- Verificar que la feature alcanza 80%+ de cobertura
- Listar todos los tests creados con sus nombres
