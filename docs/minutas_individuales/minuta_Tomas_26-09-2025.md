# 📝 Minuta Individual de Trabajo Frontend

**Nombre:** Tomás  
**Fecha:** 26/09/2025  
**Sprint:** -  
**Rol asignado:** dev  

---

### ✅ Tareas realizadas  
- **Navbar**  
  - Se agregó la sección **Inicio** que redirige al Home.  
  - Se creó el menú desplegable **Negocio** para agrupar Productos, Clientes, Ventas, etc.  
  - Se incorporó el **logo** en la barra superior con bordes redondeados y efectos de hover.  
  - Se aplicó un **fondo con gradiente oscuro + desenfoque** para un look más elegante.  

- **Home**  
  - Se centró el mensaje de bienvenida.  
  - Se aplicaron fondos dinámicos/animaciones para darle un aspecto más profesional.  
  - Se corrigió el scroll extra que desajustaba la vista.  

- **Estilos globales**  
  - Ajuste de **variables SCSS** para mantener coherencia (paleta carbón + dorado).  
  - Gradiente más oscuro en el navbar y sombras consistentes.  
  - Correcciones en difuminados, bordes y tipografías.  

- **Módulo de Productos**  
  - Reorganización del **HTML y SCSS** para una mejor estructura visual.  
  - Toolbar clara con título y acción principal.  
  - Sección de filtros alineada y más prolija.  
  - Tabla estilizada: cabecera sticky, hover en filas y acciones alineadas.  
  - Empty state con título, subtítulo y CTA.  
  - Formulario en grilla, más ordenado y responsivo.  
  - Se eliminaron dependencias de `[(ngModel)]`, reemplazándolas por signals con `set/get`.  

- **Consistencia visual general**  
  - Unificación de la estructura de módulos (toolbar → filtros → tabla/listado → formulario).  
  - Uso coherente de **cards, badges, alerts y empty states**.  
  - Mejoras en responsividad con `hide-sm` / `hide-lg`.  

---

### 🧩 Problemas encontrados  
- El menú desplegable de **Negocio** se cerraba rápido al pasar el cursor.  
- El logo en el navbar inicialmente no se cargaba desde `public/assets`.  
- En **Home**, el contenido quedaba descentrado por el cálculo de la altura y el scroll adicional.  
- En Productos, el uso de `[(ngModel)]` con signals generaba errores → se pasó a `value` + `set()`.  
- Estilos de highlight en el navbar generaban cortes poco estéticos → se reemplazaron por un gradiente más oscuro y sutil.  

---

### 🔜 Cambios pendientes  
- Limitar el **DNI de clientes**.  
- Implementar **auth y login**.  
- Arreglar módulo de **Autoridades**.  
- Arreglar módulo de **Productos** .  
- Arreglar módulo de **Decisiones**.  
