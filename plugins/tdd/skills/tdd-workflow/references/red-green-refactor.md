# Ciclo Red-Green-Refactor

## Filosofia del ciclo

El ciclo Red-Green-Refactor es el corazon del TDD. Cada iteracion produce un incremento minimo de funcionalidad verificada. La disciplina esta en respetar cada fase sin saltarse ninguna.

## Fase RED: Escribir un test que falle

### Objetivo
Definir el comportamiento deseado a traves de un test ejecutable que falle.

### Proceso
1. Identificar el proximo comportamiento minimo a implementar
2. Escribir un test que demuestre ese comportamiento
3. Ejecutar el test y confirmar que falla
4. Verificar que falla por la razon correcta (feature faltante, no error de sintaxis)

### Criterios de un buen test RED
- Nombre descriptivo del comportamiento esperado
- Un solo comportamiento por test
- Muestra la API deseada (el test define el diseno)
- Falla por la razon correcta

### Ejemplo por lenguaje

**Go:**
```go
func TestCalculateDiscount_AppliesTenPercentForOrdersAboveHundred(t *testing.T) {
    order := NewOrder(150.00)

    discount := order.CalculateDiscount()

    assert.Equal(t, 15.00, discount)
}
```

**TypeScript:**
```typescript
describe('calculateDiscount', () => {
    it('should apply 10% discount for orders above 100', () => {
        const order = new Order(150.00);

        const discount = order.calculateDiscount();

        expect(discount).toBe(15.00);
    });
});
```

**C#:**
```csharp
[Fact]
public void CalculateDiscount_AppliesTenPercentForOrdersAboveHundred()
{
    var order = new Order(150.00m);

    var discount = order.CalculateDiscount();

    Assert.Equal(15.00m, discount);
}
```

## Fase GREEN: Codigo minimo para pasar

### Objetivo
Escribir la implementacion mas simple posible que haga pasar el test.

### Proceso
1. Implementar la solucion mas simple (incluso hard-coded si es un primer test)
2. Ejecutar el test y confirmar que pasa
3. Ejecutar toda la suite y confirmar que no hay regresiones
4. Verificar output limpio (sin warnings ni errores)

### Reglas estrictas
- No agregar funcionalidad extra "porque la vamos a necesitar"
- No refactorizar durante esta fase
- No optimizar prematuramente
- Si la solucion parece trivial, probablemente lo es (y esta bien)

### Ejemplo por lenguaje

**Go:**
```go
func (o *Order) CalculateDiscount() float64 {
    if o.Total > 100 {
        return o.Total * 0.10
    }
    return 0
}
```

**TypeScript:**
```typescript
calculateDiscount(): number {
    if (this.total > 100) {
        return this.total * 0.10;
    }
    return 0;
}
```

**C#:**
```csharp
public decimal CalculateDiscount()
{
    if (Total > 100m)
        return Total * 0.10m;
    return 0m;
}
```

## Fase REFACTOR: Mejorar sin cambiar comportamiento

### Objetivo
Mejorar la calidad del codigo (produccion y tests) manteniendo todos los tests verdes.

### Proceso
1. Identificar oportunidades de mejora (duplicacion, nombres, estructura)
2. Aplicar un refactor a la vez
3. Ejecutar tests despues de cada cambio
4. Confirmar que todo sigue verde

### Que refactorizar
- Eliminar duplicacion (DRY aplicado con criterio)
- Mejorar nombres de variables, funciones, tipos
- Extraer funciones helper cuando hay logica reutilizable
- Simplificar condicionales complejos
- Mejorar estructura de tests (extraer setup comun)

### Que NO hacer durante refactor
- Agregar funcionalidad nueva
- Cambiar comportamiento observable
- Introducir nuevas dependencias
- "Preparar" codigo para features futuras

## Velocidad del ciclo

### Iteraciones rapidas
Cada ciclo completo deberia tomar entre 1 y 10 minutos. Si un ciclo toma mas de 15 minutos, el incremento es demasiado grande. Dividir en pasos mas pequenos.

### Orden de complejidad
Atacar casos en este orden:
1. **Caso degenerado**: Input vacio, null, cero
2. **Caso simple**: Un solo elemento, valor basico
3. **Caso general**: Multiples elementos, valores variados
4. **Casos borde**: Limites, overflow, caracteres especiales
5. **Casos de error**: Inputs invalidos, estados inesperados

## Bug fixes con TDD

Nunca corregir un bug sin un test:
1. Escribir un test que reproduzca el bug (debe fallar)
2. Confirmar que falla por la razon correcta (el bug)
3. Corregir el codigo minimo para pasar el test
4. Confirmar que el test pasa y no hay regresiones
5. El test previene regresion futura del mismo bug

## Checklist de verificacion

Antes de considerar el trabajo completo:
- [ ] Cada funcion tiene un test que se vio fallar antes de implementar
- [ ] Codigo minimo escrito para pasar cada test
- [ ] Todos los tests pasan con output limpio
- [ ] Codigo real testeado (mocks minimizados)
- [ ] Casos borde y errores cubiertos
- [ ] Refactoring aplicado sin romper tests

Si algun punto queda sin marcar: reiniciar con TDD.
