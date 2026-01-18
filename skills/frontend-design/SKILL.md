---
name: frontend-design
description: Esta skill debe usarse cuando el usuario pide "crea una interfaz", "diseña un componente", "necesito un frontend", "construye una página web", "implementa esta UI", "desarrolla la interfaz de usuario", o menciona diseño web, componentes React/Vue, o aplicaciones web. Proporciona interfaces frontend distintivas con alta calidad de diseño, evitando estéticas genéricas de IA mediante código creativo y pulido.
user-invocable: true
---

Esta skill guía la creación de interfaces frontend distintivas y con calidad de producción, evitando las estéticas genéricas que suelen generar las IA. Implementar código funcional real con atención excepcional a los detalles estéticos y decisiones creativas.

El usuario proporciona los requisitos del frontend: un componente, página, aplicación o interfaz a construir. Puede incluir contexto sobre el propósito, audiencia o restricciones técnicas.

## Pensamiento de diseño

Antes de codificar, comprender el contexto y apostar por una dirección estética AUDAZ:

- **Propósito**: ¿Qué problema resuelve esta interfaz? ¿Quién la usa?
- **Tono**: Elegir un extremo: brutalmente minimalista, caos maximalista, retro-futurista, orgánico/natural, lujo/refinado, juguetón/infantil, editorial/revista, brutalista/crudo, art déco/geométrico, suave/pastel, industrial/utilitario, etc. Existen infinidad de sabores para elegir. Usar estos como inspiración pero diseñar uno que sea fiel a la dirección estética.
- **Restricciones**: Requisitos técnicos (framework, rendimiento, accesibilidad).
- **Diferenciación**: ¿Qué hace esto INOLVIDABLE? ¿Cuál es ese elemento único que alguien recordará?

**CRÍTICO**: Elegir una dirección conceptual clara y ejecutarla con precisión. Tanto el maximalismo audaz como el minimalismo refinado funcionan - la clave es la intencionalidad, no la intensidad.

Luego implementar código funcional (HTML/CSS/JS, React, Vue, etc.) que sea:

- Listo para producción y completamente funcional
- Visualmente impactante y memorable
- Cohesivo con un punto de vista estético claro
- Meticulosamente refinado en cada detalle

## Directrices estéticas de frontend

Enfocarse en:

- **Tipografía**: Elegir fuentes hermosas, únicas e interesantes. Evitar fuentes genéricas como Arial e Inter; elegir opciones distintivas que realcen la estética del frontend; fuentes inesperadas y con carácter. Combinar una fuente display distintiva con una fuente de cuerpo refinada.
- **Color y tema**: Comprometerse con una estética cohesiva. Usar variables CSS para consistencia. Los colores dominantes con acentos marcados superan a las paletas apagadas y uniformemente distribuidas.
- **Movimiento**: Usar animaciones para efectos y microinteracciones. Priorizar soluciones exclusivamente CSS para HTML. Usar la biblioteca Motion para React cuando esté disponible. Enfocarse en momentos de alto impacto: una carga de página bien orquestada con revelaciones escalonadas (animation-delay) genera mayor impacto que microinteracciones dispersas. Usar scroll-triggering y estados hover que sorprendan.
- **Composición espacial**: Layouts inesperados. Asimetría. Superposición. Flujo diagonal. Elementos que rompen el grid. Espacio negativo generoso O densidad controlada.
- **Fondos y detalles visuales**: Crear atmósfera y profundidad en lugar de recurrir por defecto a colores sólidos. Agregar efectos contextuales y texturas que coincidan con la estética general. Aplicar formas creativas como gradient meshes, texturas de ruido, patrones geométricos, transparencias en capas, sombras dramáticas, bordes decorativos, cursores personalizados y overlays de grano.

NUNCA usar estéticas genéricas generadas por IA como familias tipográficas sobreutilizadas (Inter, Roboto, Arial, fuentes del sistema), esquemas de color cliché (particularmente gradientes morados sobre fondos blancos), layouts y patrones de componentes predecibles, y diseño genérico que carece de carácter específico al contexto.

Interpretar creativamente y tomar decisiones inesperadas que se sientan genuinamente diseñadas para el contexto. Ningún diseño debe ser igual a otro. Variar entre temas claros y oscuros, diferentes fuentes, diferentes estéticas. NUNCA converger en elecciones comunes (Space Grotesk, por ejemplo) entre generaciones.

**IMPORTANTE**: La complejidad de la implementación debe corresponder a la visión estética. Los diseños maximalistas necesitan código elaborado con animaciones y efectos extensivos. Los diseños minimalistas o refinados necesitan moderación, precisión y atención cuidadosa al espaciado, tipografía y detalles sutiles. La elegancia proviene de ejecutar bien la visión.

Recuerda: Claude es capaz de trabajo creativo extraordinario. No contenerse, mostrar lo que realmente puede crearse al pensar fuera de la caja y comprometerse completamente con una visión distintiva.
