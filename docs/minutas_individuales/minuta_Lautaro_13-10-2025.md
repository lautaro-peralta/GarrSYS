### **Minuta individual**

Responsable: Lautaro

Fecha: 13/10/25

**Objetivo:** Fortalecer la seguridad y garantizar la validez de los correos electrónicos de los usuarios mediante la implementación de un flujo de verificación obligatorio.

**Resumen de Cambios Técnicos:**

1.  **Flujo de Autenticación y Registro (`auth`):**
    *   **Registro:** Al crear una cuenta, el sistema ahora envía automáticamente un email de verificación. La respuesta de la API informa que la cuenta requiere verificación.
    *   **Login:** Se implementó un bloqueo que **impide iniciar sesión** a los usuarios cuyo email no ha sido verificado. Se devuelve un error `403 Forbidden` específico.

2.  **Módulo de Verificación de Email (`emailVerification`):**
    *   **Seguridad Reforzada:**
        *   Las solicitudes de verificación (`/request`) y reenvío (`/resend`) ahora **requieren autenticación**, previniendo que usuarios anónimos puedan enviar emails.
        *   Se valida que un usuario autenticado solo pueda solicitar la verificación para **su propio email**, evitando que pueda intentar verificar correos de terceros.
    *   **Nuevo Endpoint Público:** Se añadió la ruta `POST /resend-unverified` para que los usuarios que no han verificado su cuenta (y no pueden loguear) puedan solicitar un nuevo email de verificación usando solo su correo.
    *   **Gestión de Tokens y Cooldown:**
        *   El token de verificación ahora tiene una vida útil de **15 minutos** (reducido de 48 horas).
        *   Se estableció un **cooldown de 2 minutos** para las solicitudes, previniendo spam. Una nueva solicitud después de este tiempo invalida la anterior.
    *   **Actualización de Estado:** Al verificar un token exitosamente, el campo `emailVerified` del usuario correspondiente se actualiza a `true`.

3.  **Servicio de Emails (`email.service.ts`):**
    *   **Integración con SendGrid:** El servicio fue refactorizado para utilizar **SendGrid** en el entorno de producción (mediante API Key), mientras se mantiene el uso de **SMTP (Mailtrap)** para desarrollo.
    *   **Plantillas:** Las plantillas de email fueron actualizadas para incluir información del proyecto académico.

4.  **Entidad `User` y Esquemas:**
    *   Se renombró el campo `emailValidated` a `emailVerified` en la entidad `User` y en todos los esquemas y controladores relacionados para mayor consistencia y claridad.

5.  **Dependencias y Configuración:**
    *   Se añadieron las dependencias `@sendgrid/mail` y `mailgun.js`.
    *   Se agregaron nuevas variables de entorno (`SENDGRID_API_KEY`, `SENDGRID_FROM`) para la configuración de SendGrid.

6.  **Pruebas y Documentación de API (`.http`):**
    *   El archivo `emailVerification.http` fue reescrito por completo para reflejar los nuevos flujos de autenticación, endpoints y escenarios de prueba, incluyendo casos de éxito, fallos de seguridad y uso del nuevo endpoint público.
