# Minuta individual
Fecha: 09/10/25

Responsable: Lautaro

### Resumen de Cambios

**Refactorización de Autenticación y Usuarios:**

*   Se implementó un sistema completo de **refresh tokens** para mejorar la seguridad y la persistencia de la sesión.
*   Se reestructuró el módulo `auth`, moviendo todo lo relacionado a `user` a su propio subdirectorio (`auth/user/`).
*   Se añadió un nuevo módulo para gestionar solicitudes de roles (`auth/roleRequest/`).
*   El logout ahora invalida los tokens en el servidor.

**Nuevos Módulos:**

*   Se agregó el módulo `monthlyReview` completo (CRUD y búsqueda).
*   Se agregó el módulo `admin` completo (CRUD y búsqueda).
*   Se agregó el módulo `shelbyCouncil` completo (CRUD y búsqueda).
*   Se agregó el módulo `clandestineAgreement` completo (CRUD y búsqueda).

**Mejoras en Endpoints Existentes:**

*   Se añadió **paginación** a varios listados (ej. `authorities`).
*   La búsqueda fue mejorada en `authorities`, `sales`, `clients`, etc.
*   El endpoint para pagar sobornos (`bribes`) ahora devuelve un resumen más detallado.
*   Se actualizó la documentación en el `README` y se mejoraron los archivos `.http` para testing.

**En resumen:** se metió un refactor grande en autenticación, se añadieron nuevos módulos de negocio y se pulieron varios endpoints existentes.
