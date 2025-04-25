# Propuesta TP DSW

## Grupo Shelby

### Integrantes

- 53483 - Peralta, Lautaro Martín
- 50215 - Delprato, Luca
- 51665 - Splivalo, Tomas

### Repositorios

- [frontend app](http://hyperlinkToGihubOrGitlab)
- [backend app](http://hyperlinkToGihubOrGitlab)

## The Garrison System

### Descripción

The Garrison System (TGS) es un sistema de ventas y gestion de recursos ambientado en el Birmingham de los años 1920. Simula una red comercial con elementos de riesgo, corrupción y toma de decisiones estratégicas.

### Modelo

![Diagrama Entidad-Relación](https://private-user-images.githubusercontent.com/205333171/435520921-858a3469-f6b5-41a5-ae8e-d9360c69d137.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDUyMDI1MTUsIm5iZiI6MTc0NTIwMjIxNSwicGF0aCI6Ii8yMDUzMzMxNzEvNDM1NTIwOTIxLTg1OGEzNDY5LWY2YjUtNDFhNS1hZThlLWQ5MzYwYzY5ZDEzNy5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNDIxJTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDQyMVQwMjIzMzVaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0xYWU5ZjNkZTlkYzg0NWE0Y2VjZDI1NWQzMzU0MzA4ZDhjMzU1YmUzYTNhNmZhM2Y0NWM2NmQ4MjNlMTIxOTNkJlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.NMrFBij0tsz5KgfP2NeVA7EXSdVXHN0gJMpwUKNgTCs)

## Alcance Funcional

### Alcance Mínimo

| Tipo de Funcionalidad | Descripción |
|------------------------|-------------|
| *CRUD Simple* | 1. CRUD Gestión de Productos<br>2. CRUD Gestión de Clientes<br>3. CRUD Gestión de Ventas|
| *CRUD Dependiente* | 1. CRUD Productos Ilegales {depende de} CRUD Gestión de Productos<br> 2. CRUD Productos Legales {depende de} CRUD Gestión de Productos |
| *Listado + Detalle* | 1. Listado de ventas filtrado por fecha y zona: muestra monto, productos vendidos y distribuidor. → Detalle: productos, tipo (legal/ilegal), soborno si aplica.<br>2. Listado de decisiones estratégicas por socio: muestra descripción, estado, fechas. → Detalle: quién la tomó, qué temas incluye, qué ventas se revisaron. |
| *CUU / Epic* | 1. Generar informe de venta con productos legales o ilegales asociados.<br>2. Generar registro de compras y una consulta de historial por cliente. |

---

### Alcance Adicional para Aprobación

| Tipo de Funcionalidad | Descripción |
|------------------------|-------------|
| *CRUD* | - CRUD Gestión de Socios<br>- CRUD Gestión de Administradores<br>- CRUD Decisiones Estrategicas<br>- CRUD Gestión de Zonas<br>- CRUD Gestion de Distribuidores {depende de} CRUD Zonas<br>- CRUD Gestion de Autoridades {depende de} CRUD Zonas|
| *CUU / Epic* | - Asociar una decisión estratégica a una venta.<br>- Registrar una compra de productos ilegales.<br>- Registrar acuerdos clandestinos entre sociedad y autoridad.|
---

### Alcance Adicional Voluntario

| Tipo de Funcionalidad | Descripción |
|------------------------|-------------|
| *Listado* | - Listado de productos ilegales por zona y autoridad involucrada (incluye monto de soborno) |
| *CUU / Epic* | - Generar informe mensual de ventas y sobornos asociados.<br>- Registrar acciones del Consejo Shelby frente a incidentes de intervención policial. |
