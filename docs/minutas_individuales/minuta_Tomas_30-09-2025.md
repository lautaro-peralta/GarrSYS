# Minuta — Cambios en Home

## ✅ Tareas realizadas

### Auth unificado en Home
- Panel de vidrio dividido en dos mitades (**Login / Registro**) dentro de la página principal.
- Cambio de modo tocando cada mitad (sin rutas `/login` ni `/register`).
- Línea divisoria animada entre ambas secciones.
- El panel se oculta automáticamente al iniciar sesión y reaparece al desloguear.

### Flujo de autenticación
- Registro con **auto-login** tras crear la cuenta (si falla, vuelve a Login y precarga el email).
- Estado del panel mejorado: desaparece/aparece sin necesidad de recargar la página.

### Branding del Home
- Título **GarrSYS** con tagline: _“La plataforma que lleva tu negocio al siguiente nivel”_.
- Ajuste de tamaños y alineación visual entre logo y wordmark (sin subrayado bajo “GarrSYS”).
- Espaciado refinado: logo y texto más cercanos; la tagline baja un poco para respirar.

### Saludo al usuario
- Badge de bienvenida: **“Bienvenido/a, {usuario}”** cuando el panel de auth está oculto (sesión iniciada).

### Polish / Correcciones
- Se retiró la línea decorativa bajo “GarrSYS” en el Home.
- Transiciones y animaciones más suaves.
- Inputs/formularios mantienen el estilo original (sin botón de “mostrar contraseña” en la versión final).


## 🔜 Pendientes
- Corregir y completar el **funcionamiento de Zonas**.  
- Refinar el módulo de **Socios** para ajustar funcionamiento y diseño, logrando coherencia total con el resto de componentes.
- Implementar las paginas de "sobre nosotros", "FAQs", "Contactanos"

