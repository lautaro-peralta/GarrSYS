# 📝 Minuta técnica de avances (detallada)

**Fecha:** 25/07/2025  
**Responsable:** Lautaro

---

## Resumen de avances recientes:

### Autoridad:

- Se completó la implementación de endpoints `crear`, `listar`, `eliminar`, `obtener por DNI` y `actualizar` (PUT y PATCH) para la entidad Autoridad.
- Se incorporaron validaciones con Zod para los inputs del body (`crearAutoridadSchema`, `actualizarAutoridadSchema`) y para los parámetros de URL (`dniParamSchema`).
- Se integraron middlewares de autenticación y autorización para restringir el acceso solo a usuarios administradores.
- Se modularizó correctamente la lógica en controller, schema, middleware y routes.

### Zona:

- Se desarrolló la función `crearZonaDev()` que crea manualmente una zona con ID 1 , pensada como sede central especial (si no existe dicha sede aún).
- Se evaluaron distintas alternativas para mantener una zona "especial" sin comprometer la lógica de asignación automática de IDs.

### Validaciones y estructura general:

- Se reforzó la estructura de rutas usando `validarConSchema` como middleware base.
- Se aplicó una política uniforme de validación para params y body, dejando el sistema preparado para escalar con nuevas entidades.
- Se aclararon y documentaron decisiones técnicas en los controladores y esquemas.

---

## Próximas tareas pendientes:

- Actualizar zonas para usar los schemas de validación de la librería zod.
- Comenzar con la implementación del módulo Producto para conectar con Detalles de Venta. Usar los schemas de validación de la librería zod
- Incorporar integración de la entidad `Autoridad` con otras entidades.
- Implementar reglas de negocio para calcular la comisión de una autoridad según su rango.
- Evaluar la lógica de actualización del rol en usuarios desde el módulo de administración.
- Asegurar consistencia en el naming y estructura de DTOs para futuras respuestas del backend.
