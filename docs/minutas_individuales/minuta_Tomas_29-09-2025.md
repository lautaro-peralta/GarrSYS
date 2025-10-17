# 📝 Minuta de Cambios – Frontend
**Nombre:** Tomás  
**Fecha:** 29/09/2025  
**Sprint:** -  
**Rol asignado:** dev  

---
## ✅ Tareas realizadas
- **Autenticación completa (Auth):** integración de login, registro y logout con cookies `httpOnly` y endpoint `/usuarios/me` para hidratar sesión.
- **Login / Register funcionales:**
  - Navegación entre pantallas: “¿No tenés cuenta? Crear cuenta” → `/register` y “¿Ya tenés cuenta? Iniciar sesión” → `/login`.
  - Validación de contraseña mejorada: mínimo 8 caracteres, mayúscula, minúscula, número y **símbolo** (incluye **punto `.`**), sin espacios.
  - Opción de **mostrar/ocultar contraseña** en login y register.
- **Logout operativo:** botón **Salir** en el navbar limpia estado local y hace redirect a `/login` (incluso si el endpoint falla).
- **Navbar – estado deslogueado:** ahora muestra **Sobre nosotros**, **FAQs**, **Contáctanos** (oculta opciones de gestión).
- **Navbar – estado logueado:** oculta el botón **Inicio** según la lógica acordada.
- **No se tocó el estilo/estética del navbar**, solo comportamiento.

## 🧩 Problemas detectados y solucionados
- **Register no navegaba** desde el link en Login → faltaba `RouterModule` en los componentes de Auth.
- **Register fallaba validación** → se ajustó el patrón de contraseña para alinearse con el backend y permitir más símbolos (incluye `.`).
- **Logout no hacía nada** → el `AuthService.logout()` ahora se **suscribe internamente** y garantiza limpieza de sesión + redirect.
- **Hidratación de sesión** tras login → el front ahora llama a `/usuarios/me` para setear `user` y `isLoggedIn`.

## 🔧 Archivos afectados (frontend)
- `src/app/services/auth/auth.ts`
- `src/app/components/auth/login/login.ts`
- `src/app/components/auth/login/login.html`
- `src/app/components/auth/register/register.ts`
- `src/app/components/auth/register/register.html`

## 🔍 Pruebas realizadas (smoke tests)
1. **Registro:** crear usuario con contraseña válida (ej. `Qwerty12.`) → redirige a `/login`.
2. **Login:** ingresar credenciales válidas → redirige a `/` y estado queda hidratado.
3. **Navegación entre Auth:** links bidireccionales entre login/register funcionan.
4. **Mostrar/ocultar contraseña:** toggle cambia type entre `password`/`text`.
5. **Logout:** botón **Salir** → limpia estado y va a `/login`.
6. **Navbar:** en **deslogueado** se ven Sobre nosotros/FAQ/Contáctanos; en **logueado** no aparece **Inicio**.

## 🔜 Pendientes 
- Corregir y completar el **funcionamiento de Zonas**.  
- Refinar el módulo de **Socios** para ajustar funcionamiento y diseño, logrando coherencia total con el resto de componentes.  
- Hacer rediseño completo del home, para cambiar la forma en la que te logueas y registras. 

