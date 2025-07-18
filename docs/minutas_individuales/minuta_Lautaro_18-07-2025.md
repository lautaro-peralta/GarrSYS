#📝 Minuta técnica de avances (detallada)
Fecha: 18 de julio de 2025
Responsable: Lautaro

##Resumen de avances recientes:

###Cliente:
Se completó la implementación de CRUD (Create, Read, Update, Delete) con MikroORM.
Se corrigieron validaciones y errores comunes relacionados con tipos y objetos requeridos.

###Entidad Venta:
Se definió la entidad Venta, incluyendo relaciones con Cliente (ManyToOne) y Detalle (OneToMany).
Se configuró montoVenta como campo calculado que se completará una vez agregados los detalles.
Se evitó el uso directo de onDelete en MikroORM, optando por controlarlo vía base de datos.

###Entidad Detalle:
Se creó la entidad Detalle con campos: producto, cantidad, precioUnitario y subtotal.
La relación con Venta se configuró correctamente (ManyToOne).

###Controlador de Venta:
Se implementó el endpoint add, que permite registrar una venta a partir del nombre del cliente y una lista de detalles.
Se dejó preparada la lógica para añadir productos reales, pero se está usando temporalmente producto: string hasta que el módulo Producto esté disponible.

##Próximas tareas pendientes:
Implementar entidad Producto con sus relaciones y validaciones correspondientes.
Calcular automáticamente el campo montoVenta luego de agregar los detalles.
Validar reglas de negocio adicionales (por ejemplo, evitar ventas sin detalles).
Incorporar autenticación y autorización (roles, middleware de acceso).
Crear DTOs para exportar solo datos relevantes al cliente.
