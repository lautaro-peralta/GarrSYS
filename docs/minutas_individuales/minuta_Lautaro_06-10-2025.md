### **Minuta Individual de Cambios: Módulo de Búsqueda Avanzada**

**Fecha:** 06/10/2025
**Responsable:** Lautaro

---

#### **Resumen**

He implementado un nuevo sistema de búsqueda genérico y reutilizable en el backend, aplicándolo en un nuevo endpoint para la entidad `Sale`.

#### **Cambios Clave**

1.  **Creación de `search.util.ts`:**
    *   Desarrollé un nuevo módulo de utilidades (`src/shared/utils/search.util.ts`) para centralizar y estandarizar las operaciones de búsqueda en la base de datos.
    *   **Funcionalidades incluidas:**
        *   Búsqueda por **fecha** con rangos (`exact`, `before`, `after`, `between`).
        *   Búsqueda por **texto** case-insensitive en campos simples y anidados (ej. `client.name`).
        *   Búsqueda en **múltiples campos** de texto simultáneamente.
        *   Manejo automático de `populate` para cargar relaciones necesarias.

2.  **Nuevo Endpoint `searchSales` en `sale.controller.ts`:**
    *   Creé el método `searchSales` que utiliza las nuevas utilidades para ofrecer una búsqueda multifacética de ventas.
    *   Permite filtrar ventas por:
        *   **Fecha de venta** (`saleDate`), utilizando la utilidad `searchEntityByDate`.
        *   **Nombre del cliente** (`client.name`), utilizando la utilidad `searchEntity`.
        *   **Nombre del distribuidor** (`distributor.name`), utilizando la utilidad `searchEntity`.
        *   **Nombre de la zona** (`zone.name`), con una lógica personalizada que primero busca las zonas y luego las ventas asociadas.
    *   El endpoint prioriza la búsqueda por fecha. Si se provee el parámetro `date`, se ignora la búsqueda por texto.

#### **Impacto**

*   **Reusabilidad:** Las funciones en `search.util.ts` pueden ser utilizadas por cualquier controlador para implementar búsquedas complejas de forma rápida y segura.
*   **Mejora de UX:** Se provee una API de búsqueda potente y flexible para la entidad `Sale`, mejorando la capacidad de consulta desde el frontend.
*   **Calidad de Código:** Se centraliza la lógica de filtrado, se mejora la legibilidad y se reduce la duplicación de código en los controladores.

