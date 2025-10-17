# 📝 Minuta de Avance - The Garrison System (Frontend)
**Nombre:** Tomás  
**Fecha:** 27/09/2025  
**Sprint:** -  
**Rol asignado:** dev  

---


### ✅ Tareas realizadas
- **Clientes**
  - DNI limitado a **8 dígitos** (inputs y filtros relevantes).
  - Servicio ajustado a **usar `PATCH`** (se quitó `PUT`) en updates.
- **Productos**
  - Servicio y componente migrados a **`PATCH`** para edición.
  - Mantenimiento de alta/listado/eliminación OK.
- **Ventas**
  - Se **sacó la edición** en UI (solo crear y listar, según regla).
  - Se **deshabilitó eliminar** ventas (regla de negocio).
  - Vista mejorada: ahora muestra **descripción de ítems** de cada venta (no “#undefined”).
  - **Total**: se toma del back (campo `montoVenta` → `total`) cuando llega; si no, se **recalcula** con los detalles.
  - **Stock**: validación para **no permitir** cantidades mayores al stock (máximo en input + validación en `guardar()`).
- **Autoridades & Temática**
  - Listado/filtros y formularios funcionando.
- **Sobornos (UI)**
  - Botón **“Nuevo”** y formulario de creación/edición **removidos temporalmente**; queda listado + **“Marcar pagado”**.
  - Servicio alineado para `PATCH` y con fallbacks plural/singular.
- **Estilos**
  - Se agregó **tema global** + **capa compat** (cards, tablas, inputs, botones) para homogeneizar todas las vistas.

---

### 🧩 Problemas encontrados
- **Desfase HTTP**: el back expone **`PATCH`** y el front llamaba **`PUT`** → 404 “ruta no encontrada”.
- **Ventas/Total**: el back envía `montoVenta` y el front esperaba `total` → mostraba **0**; se normalizó (usar `total` o recalcular).
- **Ventas/Detalles**: aparecía “#undefined” si el back no populaba `detalles.producto` → se agregó fallback y rendering seguro.
- **Sobornos/Rutas**: en el router del back faltaban `POST /api/sobornos` y `PATCH /api/sobornos/:id`; además inconsistencia `/:id/pagar` vs `req.params.dni`.
- **Autoridad ID/DNI**: en sobornos el front mostraba `a.id` pero a veces venía solo `dni` → se manejó con fallback en template.
- **Angular**: errores por métodos `private` usados en template y expresiones complejas en bindings → se expusieron helpers públicos y se movió lógica al TS.

---

### 🔜 Cambios pendientes
- **Decisiones**  
  - Verificar existencia de entidad/CRUD en back y enlazar con **Socios** (1:N) (tengo que crear socios en el back).  
  - Implementar/ajustar vistas y servicio front (listar/crear/patch/cambiar estado).
- **Zonas**  
  - Revisar endpoints y wiring en front (filtros, relaciones con distribuidores/autoridades).
- **Estilos**  
  - Impementar especie de liquid glass en el menu de negocio.
  - Tratar de correr todo mas a los bordes 
- **Soborno**
  - Falta que funcione el "marcar como pago" 
  - Chequear si funciona todo bien 
- **Animaciones**
  - Analizar donde se pueden agregar mas animaciones
