Luca Delprato
Fecha: 03/10/2025

✅ Mejoras completadas en SocioController

Populate corregido

getAllSocios ahora solo popula usuario.

Imports innecesarios eliminados.

Respuestas unificadas con ResponseUtils

Métodos getAllSocios, getOneSocioByDni, createSocio, patchUpdateSocio, deleteSocio migrados a ResponseUtils.

Manejo estandarizado de ok, created, notFound, conflict, badRequest y serverError.

Responsabilidad única en createSocio

Ahora solo crea Socio.

Lógica de creación de Usuario separada a otro flujo.

Validaciones simplificadas

Eliminadas comprobaciones manuales (if !dni || !nombre...) ya que Zod valida previamente.

Código más limpio y mantenible

Reducción de redundancia.

Mensajes consistentes en toda la API.

✅ Mejoras completadas en socio.router.ts

Instancia del controlador renombrada a partnerController (convención de proyecto).

Secciones separadas para:

CRUD de Socios

Relaciones con Decisiones (listDecisiones, linkDecision, unlinkDecision)

Relaciones con Ventas (listVentasBySocio)

Ruta createVentaForSocio aún presente pero pendiente de mover a VentaController según arquitectura.

📊 Estado actual

SocioController refactorizado con las correcciones 1–7.

SocioRouter corregido con la convención partnerController.

Endpoints placeholder devuelven notImplemented hasta su desarrollo.

📌 Próximos pasos

Mover createVentaForSocio a VentaController para respetar la separación de responsabilidades.

Implementar lógica de listDecisiones y listVentasBySocio alineadas al DER.

Aplicar el mismo patrón de ResponseUtils en otros controladores.
