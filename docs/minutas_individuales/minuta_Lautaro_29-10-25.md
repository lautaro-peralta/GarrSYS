
# Minuta de Cambios - 29 de Octubre de 2025

**Fecha:** 29/10/2025

**Participantes:**
- Lautaro
- Tsplivalo

## Resumen de Cambios Recientes

Esta minuta resume los cambios más significativos realizados en el backend durante la última semana. El cambio más importante es la migración de la base de datos de MySQL a PostgreSQL. Además, se han realizado varias actualizaciones en la lógica de negocio, permisos y datos de prueba.

## Nuevas Características y Mejoras

- **Migración a PostgreSQL:** Se ha migrado completamente la base de datos de MySQL a PostgreSQL para mejorar la escalabilidad y el rendimiento. Esto incluyó la actualización de la configuración de TypeORM, los scripts de conexión y la sintaxis de las consultas SQL.
- **Actualización del Script de Seed:** El script `seed-test-data.mjs` ha sido actualizado para funcionar con PostgreSQL. También se ha mejorado el resumen de datos de prueba para que sea más claro y conciso.
- **Mejoras en las Validaciones:** Se han mejorado las validaciones para los detalles de productos y ventas, asegurando una mayor integridad de los datos.
- **Actualización de Template de Email:** Se ha actualizado el template de `emailVerification` para mejorar la comunicación con el usuario.

## Corrección de Errores

- **Actualización de Accesos por Roles:** Se han corregido y actualizado los permisos de acceso basados en roles para varios endpoints, asegurando que los usuarios solo puedan acceder a los recursos autorizados.

## Otros Cambios

- Se han realizado varias fusiones de pull requests con cambios menores y correcciones.
- Se ha actualizado el archivo `.env.example` para reflejar los cambios de la base de datos.
- Se ha actualizado la documentación en `README.md`.

## Título para el Commit

feat(core): minuta de cambios y resumen de la migración a PostgreSQL
