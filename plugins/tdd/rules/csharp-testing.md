---
paths: "**/*{Test,Tests}.cs"
---

# C# Testing Standards

## Test structure

### xUnit Fact y Theory

Usar `[Fact]` para tests sin parametros y `[Theory]` con `[InlineData]` para tests parametrizados:

```csharp
[Fact]
public void CreateUser_ValidData_ReturnsUser()
{
    var service = new UserService(new InMemoryUserRepo());

    var user = service.CreateUser("Diego", "diego@example.com");

    user.Name.Should().Be("Diego");
}

[Theory]
[InlineData(0, 0)]
[InlineData(1, 10)]
[InlineData(5, 50)]
public void CalculatePrice_VariousQuantities_ReturnsCorrectTotal(
    int quantity, decimal expected)
{
    var calculator = new PriceCalculator(pricePerUnit: 10m);

    var result = calculator.Calculate(quantity);

    result.Should().Be(expected);
}
```

### Naming convention
Formato: `[Metodo]_[Escenario]_[ResultadoEsperado]`
```csharp
CreateUser_DuplicateEmail_ThrowsConflictException
CalculateDiscount_OrderAboveHundred_ReturnsTenPercent
Validate_EmptyInput_ReturnsFalse
```

## Proyecto de tests

Crear un proyecto separado para tests:
```
MyProject/
  MyProject.csproj
MyProject.Tests/
  MyProject.Tests.csproj
```

Referenciar el proyecto principal desde el proyecto de tests.

## FluentAssertions

Usar FluentAssertions para assertions legibles:
```csharp
result.Should().Be(expected);
result.Should().NotBeNull();
result.Should().BeOfType<User>();
collection.Should().HaveCount(3);
collection.Should().Contain(x => x.Name == "Diego");
action.Should().Throw<ArgumentException>()
    .WithMessage("*invalid*");
```

## Mocking con Moq

Mockear interfaces para dependencias de I/O:
```csharp
var mockRepo = new Mock<IUserRepository>();
mockRepo.Setup(r => r.FindByEmail("diego@example.com"))
    .ReturnsAsync(new User("Diego"));

var service = new UserService(mockRepo.Object);
```

Preferir interfaces pequenas y especificas. No mockear clases concretas.

## Constructor injection

Los tests deben crear instancias del SUT (System Under Test) con dependencias inyectadas via constructor:
```csharp
var sut = new OrderService(
    new InMemoryOrderRepo(),
    new Mock<IEmailSender>().Object,
    new FakeClock(fixedDate)
);
```

## Cobertura con coverlet

```bash
dotnet test --collect:"XPlat Code Coverage"
```

Generar reportes HTML:
```bash
reportgenerator \
    -reports:"**/coverage.cobertura.xml" \
    -targetdir:"coverage/report" \
    -reporttypes:Html
```

Objetivo: 80%+ de cobertura de lineas en codigo de negocio. Excluir migrations, DTOs sin logica y codigo generado.
