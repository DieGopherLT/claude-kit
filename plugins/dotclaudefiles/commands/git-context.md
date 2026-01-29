---
description: Obtiene contexto de los ultimos N commits de una rama especifica
argument-hint: "<count> [branch]"
allowed-tools:
  - Bash
---

# Git Context - Resumen de Commits Recientes

Obtener contexto de los commits especificados para entender el estado actual del desarrollo.

**Argumentos recibidos:** $ARGUMENTS

## Interpretacion de Argumentos

- Primer argumento (numerico): cantidad de commits (default: 5)
- Segundo argumento (opcional): rama objetivo. Si no se proporciona, usar la rama actual con `git rev-parse --abbrev-ref HEAD`

Formatos validos:
- `/git-context 10 develop` - 10 commits de develop
- `/git-context 5` - 5 commits de la rama actual
- `/git-context` - 5 commits de la rama actual

## Pasos de Ejecucion

### 1. Identificar Parametros

Parsear $ARGUMENTS:
- Si hay un numero, usarlo como `count`
- Si hay un segundo argumento, usarlo como `branch`
- Si no hay branch, obtenerlo con: `git rev-parse --abbrev-ref HEAD`
- Si no hay count, usar 5 por defecto

### 2. Obtener Log con Cambios

Ejecutar un solo comando para obtener commits y archivos modificados:

```bash
git log --stat --oneline -n <count> <branch>
```

Para mas detalle de operaciones (A/M/D):

```bash
git log --name-status --oneline -n <count> <branch>
```

### 3. Analizar Patrones

Identificar:
- Areas del codigo mas activas
- Tipo de cambios predominantes (features, fixes, refactors)
- Dependencias entre commits si las hay

### 4. Presentar Resumen

Formato de salida:

```
## Contexto: Ultimos N commits de [rama]

### Commits Analizados
| Hash | Mensaje | Archivos |
|------|---------|----------|
| ...  | ...     | ...      |

### Areas Activas
- [directorio/archivo]: N cambios

### Patron de Desarrollo
[Breve descripcion del tipo de trabajo reciente]

### Contexto Relevante
[Informacion util para continuar el desarrollo]
```

## Notas

- Este comando es de solo lectura - no realiza cambios al repositorio
- Si la rama no existe, informar el error
- Si hay menos commits que los solicitados, mostrar los disponibles
- Incluir advertencia si hay cambios sin commitear que podrian afectar el contexto
