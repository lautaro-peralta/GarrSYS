# 📝 Minuta de Cambios – Frontend  
**Nombre:** Tomás  
**Fecha:** 28/09/2025  
**Sprint:** -  
**Rol asignado:** dev  


### ✅ Tareas realizadas  
- Implementación del nuevo estilo **Liquid Glass** en todo el sistema:  
  - Aplicación de **tarjetas con efecto vidrio** (blur, transparencia, borde iluminado) en secciones principales (Clientes, Productos, Ventas, Zonas, Autoridades, Sobornos, Decisiones, Temáticas).  
  - Ajuste de **tablas** y **formularios** para integrarse con el nuevo diseño (filtros, inputs, botones).  
  - Se unificó la tipografía global en componentes clave (títulos y encabezados).  
  - Se mejoró la **jerarquía visual** con bordes iluminados, sombras internas y externas.  

- Navegación:  
  - Se integró la nueva entidad **Socios** al menú **Gestión** y se configuró su ruta en el router (`/socio`).  
  - Navbar actualizado con subrayado animado y resaltado dinámico en botones **Inicio** y **Gestión**.  

- UX/UI:  
  - Formularios como **Nuevo Cliente, Nueva Venta, Nueva Zona, etc.** se adaptaron para plegarse o mostrar solo cuando son necesarios, evitando sobrecargar la vista.  
  - Ajustes de espaciado entre tablas y cards para mejorar la legibilidad.  
  - Rediseño de dropdowns (Gestión, filtros) con fondo difuminado más realista y mejor contraste.  

### 🧩 Problemas encontrados  
- Algunas inconsistencias de estilos entre componentes (ej. títulos que no aplicaban la nueva fuente).  
- Superposición de rectángulos y bordes duplicados al aplicar el efecto vidrio en secciones anidadas.  
- Ajuste fino requerido en alineación de cabeceras de tablas.  

### 🔜 Cambios pendientes  
- Implementar toda la parte de **login y registro de usuarios**.  
- Crear un **submenú de navegación para no logueados**, que oculte las opciones de **Gestión** y muestre otras secciones (a definir en futuras versiones).  
- Corregir y completar el **funcionamiento de Zonas**.  
- Refinar el módulo de **Socios** para ajustar funcionamiento y diseño, logrando coherencia total con el resto de componentes.  
