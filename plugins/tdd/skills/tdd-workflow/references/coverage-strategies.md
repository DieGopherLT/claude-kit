# Estrategias de cobertura por lenguaje

## Objetivo de cobertura

El objetivo base es **80%+ de cobertura de lineas** en codigo de produccion. Este numero no es un fin en si mismo, sino un indicador de que el TDD se esta aplicando correctamente. Si se sigue TDD estricto, la cobertura alta es consecuencia natural.

## Que medir y que no

### Medir
- Cobertura de lineas (line coverage): metrica principal
- Cobertura de ramas (branch coverage): complementaria para condicionales
- Codigo de logica de negocio: prioridad maxima
- Funciones publicas de librerias/paquetes

### No medir (excluir de reportes)
- Archivos de configuracion
- Codigo generado automaticamente
- DTOs/modelos sin logica
- Puntos de entrada (main, bootstrap)
- Adaptadores de infraestructura triviales (wrappers directos)

## Go

### Herramientas

**go test (built-in):**
```bash
# Cobertura basica
go test -cover ./...

# Generar perfil de cobertura
go test -coverprofile=coverage.out ./...

# Ver cobertura por funcion
go tool cover -func=coverage.out

# Reporte HTML interactivo
go tool cover -html=coverage.out -o coverage.html
```

**Opciones avanzadas:**
```bash
# Cobertura de multiples paquetes con race detector
go test -race -coverprofile=coverage.out -covermode=atomic ./...

# Excluir paquetes especificos
go test -coverprofile=coverage.out $(go list ./... | grep -v /generated/ | grep -v /mocks/)
```

### Patrones de cobertura Go
- Usar `t.Run` para subtests que cubran multiples ramas
- Table-driven tests generan alta cobertura naturalmente
- `testdata/` para fixtures de archivos
- Build tags `//go:build integration` para separar tests de integracion

### Interpretacion
```
ok    mypackage    0.003s    coverage: 85.2% of statements
```
- `85.2%` es cobertura de sentencias del paquete
- Paquetes con <60% necesitan atencion inmediata
- `coverage.html` muestra lineas no cubiertas en rojo

## TypeScript

### Herramientas

**Vitest (recomendado):**
```bash
# Cobertura con vitest
vitest run --coverage

# Con provider especifico
vitest run --coverage --coverage.provider=v8

# Con umbrales
vitest run --coverage --coverage.thresholds.lines=80 --coverage.thresholds.branches=75
```

Configuracion en `vitest.config.ts`:
```typescript
export default defineConfig({
    test: {
        coverage: {
            provider: 'v8',
            reporter: ['text', 'html', 'lcov'],
            include: ['src/**/*.ts'],
            exclude: [
                'src/**/*.d.ts',
                'src/**/*.test.ts',
                'src/**/*.spec.ts',
                'src/**/index.ts',
                'src/types/**',
            ],
            thresholds: {
                lines: 80,
                branches: 75,
                functions: 80,
                statements: 80,
            },
        },
    },
});
```

**Jest:**
```bash
# Cobertura con jest
jest --coverage

# Con umbrales en jest.config.ts
coverageThreshold: {
    global: {
        branches: 75,
        functions: 80,
        lines: 80,
        statements: 80,
    },
},
```

**c8 (standalone para Node.js):**
```bash
c8 node --test
c8 report --reporter=html
```

### Patrones de cobertura TypeScript
- Co-localizar tests (`feature.test.ts` junto a `feature.ts`)
- `describe`/`it` para organizar por comportamiento
- Patron AAA (Arrange-Act-Assert) en cada test
- Testing Library para componentes de UI

### Interpretacion
```
-----------|---------|----------|---------|---------|
File       | % Stmts | % Branch | % Funcs | % Lines |
-----------|---------|----------|---------|---------|
All files  |   87.23 |    75.00 |   90.00 |   87.23 |
 utils.ts  |   95.00 |    85.71 |  100.00 |   95.00 |
 api.ts    |   72.00 |    60.00 |   80.00 |   72.00 |
-----------|---------|----------|---------|---------|
```
- Archivos con `% Branch` bajo tienen condicionales no testeados
- `% Funcs` bajo indica funciones exportadas sin tests

## C#

### Herramientas

**coverlet (recomendado con xUnit):**
```bash
# Cobertura basica
dotnet test --collect:"XPlat Code Coverage"

# Con reportgenerator para HTML
dotnet test --collect:"XPlat Code Coverage" --results-directory ./coverage
reportgenerator -reports:"coverage/**/coverage.cobertura.xml" -targetdir:"coverage/report" -reporttypes:Html

# Con umbrales
dotnet test /p:CollectCoverage=true /p:Threshold=80 /p:ThresholdType=line
```

Configuracion en `.runsettings`:
```xml
<?xml version="1.0" encoding="utf-8" ?>
<RunSettings>
  <DataCollectionRunSettings>
    <DataCollectors>
      <DataCollector friendlyName="XPlat code coverage">
        <Configuration>
          <Format>cobertura</Format>
          <Exclude>[*]*.Migrations.*,[*]*.Program,[*]*.Startup</Exclude>
          <ExcludeByAttribute>GeneratedCodeAttribute,CompilerGeneratedAttribute</ExcludeByAttribute>
        </Configuration>
      </DataCollector>
    </DataCollectors>
  </DataCollectionRunSettings>
</RunSettings>
```

**dotnet-coverage (alternativa):**
```bash
dotnet-coverage collect "dotnet test" --output coverage.xml --output-format cobertura
```

### Patrones de cobertura C#
- `[Fact]` para tests simples, `[Theory]` con `[InlineData]` para parametrizados
- Separar proyectos de test (`MyProject.Tests`)
- `FluentAssertions` para assertions legibles
- `Moq` o `NSubstitute` para dependencias de I/O

### Interpretacion
```
+----------+------+--------+--------+
| Module   | Line | Branch | Method |
+----------+------+--------+--------+
| MyApp    | 82%  | 71%    | 88%    |
+----------+------+--------+--------+
```
- `Branch` bajo indica `if`/`switch` sin cubrir todas las ramas
- `Method` bajo indica metodos publicos sin testear

## Estrategias para llegar a 80%+

### 1. Identificar codigo no cubierto
Generar reporte HTML y revisar archivos con menor cobertura. Priorizar:
- Logica de negocio critica
- Funciones publicas de APIs
- Codigo con condicionales complejos

### 2. Aplicar TDD para codigo nuevo
Todo codigo nuevo debe seguir Red-Green-Refactor. La cobertura de codigo nuevo deberia ser 90%+.

### 3. Agregar tests a codigo existente (retrofit)
Para codigo existente sin tests:
1. Escribir tests de caracterizacion que documenten comportamiento actual
2. Refactorizar para testabilidad si es necesario
3. Agregar tests de comportamiento enfocados

### 4. No perseguir 100%
- 100% de cobertura no garantiza ausencia de bugs
- Retornos decrecientes despues de 90%
- Enfocar esfuerzo en codigo de alto riesgo
- Algunos paths (panic handlers, unreachable code) no vale la pena cubrir

### 5. CI/CD integration
Configurar umbrales de cobertura en CI para evitar regresiones:
- Pull requests no pueden reducir cobertura global
- Codigo nuevo debe cumplir umbral minimo
- Reportes de cobertura como comentario en PRs
