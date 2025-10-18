# Propuesta TP DSW

## Grupo Shelby

### Integrantes

- 53483 - Peralta, Lautaro Martín
- 50215 - Delprato, Luca
- 51665 - Splivalo, Tomas

### Repositorios

- **Frontend:** [Tsplivalo/TGS-Frontend](https://github.com/Tsplivalo/TGS-Frontend)
- **Backend:** [lautaro-peralta/TGS-Backend](https://github.com/lautaro-peralta/TGS-Backend)
- **Repositorio Principal:** [lautaro-peralta/TP-Desarrollo-de-Software](https://github.com/lautaro-peralta/TP-Desarrollo-de-Software)

## The Garrison System

### Descripción

The Garrison System (TGS) es un sistema de ventas y gestion de recursos ambientado en el Birmingham de los años 1920. Simula una red comercial con elementos de riesgo, corrupción y toma de decisiones estratégicas.

### Modelo
![Diagrama Entidad–Relación - The Garrison](./The_Garrison_SYS-DER.png)

## Alcance Funcional

### Alcance Mínimo

| Tipo de Funcionalidad | Descripción |
|------------------------|-------------|
| *CRUD Simple* | 1. CRUD Gestión de Productos<br>2. CRUD Gestión de Clientes<br>3. CRUD Gestión de Ventas|
| *CRUD Dependiente* | 1. CRUD Gestión de Distribuidores {depende de} CRUD Gestión de Zonas<br>2. CRUD Gestión de Autoridades {depende de} CRUD Gestión de Zonas |
| *Listado + Detalle* | 1. Listado de ventas con búsqueda y filtrado avanzado: muestra cliente, distribuidor, autoridad y monto total. → Detalle: productos vendidos con cantidad y precio, sobornos asociados.<br>2. Listado de decisiones estratégicas con búsqueda: muestra descripción, estado y fecha. → Detalle: socios que participaron y tema de la decisión. |
| *CUU / Epic* | 1. Generar resumen de ventas por fecha con totales y estadísticas.<br>2. Registrar venta con detalles de productos y cálculo automático de totales. |

---

### Alcance Adicional para Aprobación

| Tipo de Funcionalidad | Descripción |
|------------------------|-------------|
| *CRUD* | - CRUD Gestión de Socios<br>- CRUD Gestión de Administradores<br>- CRUD Decisiones Estratégicas<br>- CRUD Gestión de Zonas<br>- CRUD Gestión de Sobornos {depende de} CRUD Ventas y CRUD Autoridades<br>- CRUD Gestión de Acuerdos Clandestinos<br>- CRUD Gestión de Temas (para decisiones estratégicas)|
| *CUU / Epic* | - Registrar venta de productos ilegales con autoridad asociada y generación automática de soborno pendiente.<br>- Registrar acuerdos clandestinos entre la sociedad Shelby y autoridades de una zona.<br>- Registrar el pago de sobornos (individual o masivo) y actualizar su estado a pagado.<br>- Búsqueda avanzada de sobornos por múltiples criterios (estado, autoridad, venta).|
---

### Alcance Adicional Voluntario

| Tipo de Funcionalidad | Descripción |
|------------------------|-------------|
| *CRUD Adicionales* | - CRUD Gestión del Consejo Shelby (registro de sesiones y decisiones del consejo)<br>- CRUD Gestión de Productos con diferenciación entre legales e ilegales mediante flag|
| *Listados Avanzados* | - Listado de productos con búsqueda y filtrado por tipo (legal/ilegal)<br>- Listado de acuerdos clandestinos con búsqueda avanzada<br>- Listado de sesiones del Consejo Shelby con búsqueda|
| *Funcionalidades de Búsqueda* | - Búsqueda avanzada de clientes por múltiples criterios<br>- Búsqueda de distribuidores por zona y otros filtros<br>- Búsqueda de autoridades con filtros personalizados<br>- Búsqueda de decisiones estratégicas por socio, tema y estado|
| *Gestión de Roles y Autenticación* | - Sistema completo de autenticación con JWT<br>- Gestión de roles (Admin, Partner, User)<br>- Verificación de email con códigos de verificación<br>- Modo demo para evaluación sin configuración de email|
