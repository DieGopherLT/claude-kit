---
paths: "**/*_test.go"
---

# Go Testing Standards

## Test structure

### Table-driven tests
Preferir table-driven tests para funciones con multiples casos:

```go
tests := []struct {
    name string
    // inputs
    // expected outputs
}{
    {"descriptive case name", /* ... */},
}

for _, tt := range tests {
    t.Run(tt.name, func(t *testing.T) {
        // arrange, act, assert
    })
}
```

### Subtests con t.Run
Organizar tests relacionados con `t.Run` para:
- Nombres descriptivos en output
- Ejecucion selectiva con `-run`
- Setup/teardown por subtest

### t.Helper()
Marcar funciones helper con `t.Helper()` para que los errores reporten la linea correcta del caller, no del helper.

## Black-box testing

Preferir black-box testing usando `package foo_test` en lugar de `package foo`. Testear solo la API publica del paquete. Usar white-box testing (`package foo`) solo cuando sea estrictamente necesario para alcanzar paths internos criticos.

## Assertions con testify

Usar `assert` para checks no fatales y `require` para precondiciones que invalidan el resto del test:

```go
require.NoError(t, err)        // falla el test si hay error
assert.Equal(t, expected, got) // reporta fallo pero continua
```

No usar `if got != want { t.Errorf(...) }` cuando testify esta disponible.

## Fixtures con testdata/

Archivos de test (JSON, XML, fixtures) van en `testdata/` dentro del paquete. Go ignora este directorio en builds.

## Test de errores

Verificar tanto la presencia del error como su tipo o mensaje:
```go
err := doSomething(invalidInput)
require.Error(t, err)
assert.ErrorIs(t, err, ErrInvalidInput)
```

## Mocking

Generar mocks desde interfaces con `gomock`/`mockgen`. No crear mocks manuales para interfaces grandes. Preferir interfaces pequenas y especificas (Interface Segregation).

## Cobertura

```bash
go test -coverprofile=coverage.out ./...
go tool cover -func=coverage.out
```

Objetivo: 80%+ en paquetes de logica de negocio.
