# Anti-patrones de Testing y Iron Laws

## Las 3 Iron Laws del TDD

### 1. No escribir codigo de produccion sin un test que falle primero

Esta es la ley fundamental. Todo codigo de produccion debe nacer de un test que falle. Si se escribio codigo antes que tests, ese codigo debe eliminarse por completo y reimplementarse desde los tests. No hay excepciones para "referencia" o "adaptacion".

### 2. No escribir mas test del necesario para producir un fallo

Escribir un solo test minimo que demuestre el comportamiento deseado. No escribir multiples tests a la vez. Confirmar que falla por la razon correcta antes de proceder.

### 3. No escribir mas codigo de produccion del necesario para pasar el test

Implementar la solucion mas simple posible que haga pasar el test. Evitar sobreingeniera, violaciones de YAGNI o feature creep. No refactorizar otro codigo en esta fase.

## 5 Anti-patrones criticos

### 1. The Liar (El Mentiroso)

Tests que pasan pero no verifican nada real. Aparentan cobertura sin validar comportamiento.

**Senales:**
- Assertions vacias o triviales (`assert(true)`)
- Tests que verifican la implementacion en lugar del comportamiento
- Mocks que retornan exactamente lo que el test espera sin verificar interaccion

**Solucion:** Cada test debe poder fallar si el comportamiento cambia. Aplicar mutation testing para detectar tests mentirosos.

### 2. The Giant (El Gigante)

Tests que verifican demasiados comportamientos en un solo caso. Si el nombre del test contiene "and", probablemente es un gigante.

**Senales:**
- Multiples assertions no relacionadas
- Setup extenso con muchas dependencias
- Nombre del test describe multiples acciones
- Fallo del test no indica claramente que se rompio

**Solucion:** Un comportamiento por test. Dividir en tests enfocados con nombres descriptivos.

### 3. The Mockery (La Burla)

Abuso de mocks que resulta en tests que verifican la implementacion interna, no el comportamiento. Los tests se rompen con cualquier refactor aunque el comportamiento externo no cambie.

**Senales:**
- Mas lineas de setup de mocks que de assertions
- Tests que fallan al refactorizar sin cambiar comportamiento
- Verificacion de orden de llamadas internas
- Mock de todo excepto la unidad bajo test

**Solucion:** Preferir codigo real sobre mocks. Usar mocks solo para boundaries de I/O (red, filesystem, bases de datos). Verificar outputs, no interacciones internas.

### 4. The Inspector (El Inspector)

Tests que acceden a estado interno privado de la unidad bajo test. Crean acoplamiento fragil con la implementacion.

**Senales:**
- Acceso a campos privados via reflexion
- Tests que conocen la estructura interna de la clase
- Verificacion de variables intermedias que no son parte del contrato publico

**Solucion:** Testear solo a traves de la interfaz publica. Si necesitas inspeccionar estado interno, es senal de que la API publica es insuficiente.

### 5. The Slow Poke (El Lento)

Tests que dependen de I/O real, timers, o recursos externos sin necesidad. Hacen que la suite sea lenta y fragil.

**Senales:**
- `time.Sleep()` / `setTimeout()` / `Thread.Sleep()` en tests
- Conexiones reales a bases de datos para tests unitarios
- Llamadas HTTP reales para logica de negocio
- Tests que tardan mas de 100ms individualmente

**Solucion:** Aislar I/O detras de interfaces. Usar implementaciones in-memory para tests. Reservar integraciones reales para tests de integracion separados.

## Racionalizaciones comunes y realidad

| Excusa | Refutacion |
|--------|-----------|
| "Es demasiado simple para testear" | El codigo simple se rompe; testear toma esfuerzo minimo |
| "Lo testeare despues" | Un test que pasa inmediatamente no prueba nada sobre la funcion |
| "Testing manual es suficiente" | Testing ad-hoc carece de cobertura sistematica y repetibilidad |
| "Borrar X horas de trabajo es desperdicio" | Falacia de costo hundido; codigo no verificado es deuda tecnica |
| "Tests despues = mismo resultado" | Tests-antes responden "que deberia pasar"; tests-despues responden "que construi" |

## Red flags que requieren reinicio

- Escribir codigo antes de tests
- Tests que pasan inmediatamente al escribirlos
- Tests agregados retroactivamente
- Racionalizaciones "solo esta vez"
- "Ya pase X horas en esto"
- Mantener codigo como referencia mientras se escriben tests
