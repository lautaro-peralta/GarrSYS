

# Minuta individual

**Responsable:** Lautaro

**Fecha:** 12/10/25

Mejoras significativas y nuevas características centradas en la seguridad, el rendimiento y la robustez de la aplicación.

# Nuevas Características

## **Configuración de Entorno**
Se ha añadido un archivo .env.example y se ha mejorado la configuración para soportar diferentes entornos (desarrollo, producción) y ser compatible con Docker.

## **Seguridad Avanzada**
Se ha implementado helmet para añadir cabeceras de seguridad esenciales.
Se ha configurado express-rate-limit para proteger la API contra ataques de fuerza bruta y abuso.
Se han añadido middlewares para protección contra HPP (HTTP Parameter Pollution), sanitización de entradas y monitoreo de actividades sospechosas.

## **Sistema de Verificación de Email**
Se ha creado un flujo completo para la verificación automática de la dirección de correo electrónico del usuario a través de un token enviado por email.

## **Sistema de Verificación de Usuario**
Se ha añadido un nuevo flujo para la verificación manual de la identidad del usuario por parte de un administrador, lo cual es un requisito para realizar compras.

## **Servicio de Email**
Se ha implementado un servicio de envío de correos (nodemailer) con plantillas HTML profesionales para notificaciones.

## **Caché con Redis**
Se ha integrado un servicio de caché de dos capas (Redis y en memoria) para mejorar el rendimiento de las consultas a la base de datos.

## **Endpoints de Health Check**
Se han añadido rutas (/health, /detailed, etc.) para monitorear el estado de la aplicación, compatibles con sistemas como Kubernetes.

# Mejoras y Refactorización

## **Manejo de Errores**

Se ha implementado un sistema de errores personalizado y un middleware global para un manejo de errores más consistente y robusto.

## **Logging**

Se ha reemplazado el uso de console.log por un logger estructurado (pino) en toda la aplicación.

## **Validación**

Se han mejorado los esquemas de validación (Zod) para ser más estrictos y profesionales.

## **Entidad User**

Se ha diferenciado entre la validación de email (emailValidated) y la verificación completa del usuario (isVerified).

## **Dependencias**

Se han añadido y actualizado varias dependencias clave para soportar las nuevas funcionalidades.
