# Propuesta TP DSW

## Grupo Shelby

### Integrantes

- 53483 - Peralta, Lautaro Martín
- 50215 - Delprato, Luca
- 51665 - Splivola, Tomas

### Repositorios

- [frontend app](http://hyperlinkToGihubOrGitlab)
- [backend app](http://hyperlinkToGihubOrGitlab)
  _Nota_: si utiliza un monorepo indicar un solo link con fullstack app.

## The Garrison System

### Descripción

The Garrison System (TGS) es un sistema de ventas y gestion de recursos ambientado en el Birmingham de los años 1920. Simula una red comercial con elementos de riesgo, corrupción y toma de decisiones estratégicas.

### Modelo

![Diagrama Entidad-Relación](https://private-user-images.githubusercontent.com/205333171/435422156-0a19fc9a-4a20-416b-ad70-2f0a516c9eea.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDUwOTYwNTgsIm5iZiI6MTc0NTA5NTc1OCwicGF0aCI6Ii8yMDUzMzMxNzEvNDM1NDIyMTU2LTBhMTlmYzlhLTRhMjAtNDE2Yi1hZDcwLTJmMGE1MTZjOWVlYS5wbmc_WC1BbXotQWxnb3JpdGhtPUFXUzQtSE1BQy1TSEEyNTYmWC1BbXotQ3JlZGVudGlhbD1BS0lBVkNPRFlMU0E1M1BRSzRaQSUyRjIwMjUwNDE5JTJGdXMtZWFzdC0xJTJGczMlMkZhd3M0X3JlcXVlc3QmWC1BbXotRGF0ZT0yMDI1MDQxOVQyMDQ5MThaJlgtQW16LUV4cGlyZXM9MzAwJlgtQW16LVNpZ25hdHVyZT0yNGY1ODYyOTZhOWY0Zjc0ZTc5NmNiMWMyYmZjMGQyMWZjMWJiMmNiYzA4OTBmYzczNjRiZDVmYjhkM2IwZWU0JlgtQW16LVNpZ25lZEhlYWRlcnM9aG9zdCJ9.GBQVquXTsfgCpaDj1mYIaVDdjy2QIoidr2rBpjI5oSI)

## Alcance Funcional

### Alcance Mínimo

_Nota_: el siguiente es un ejemplo para un grupo de 3 integrantes para un sistema de hotel. El

Regularidad:
|Req|Detalle|
|:-|:-|
|CRUD simple|1. CRUD Gestion Productos<br>2. CRUD Gestion RRHH<br>3. CRUD Gestion de Rutas|
|CRUD dependiente|1. CRUD Habitación {depende de} CRUD Tipo Habitacion<br>2. CRUD Cliente {depende de} CRUD Localidad|
|Listado<br>+<br>detalle| 1. Listado de habitaciones filtrado por tipo de habitación, muestra nro y tipo de habitación => detalle CRUD Habitacion<br> 2. Listado de reservas filtrado por rango de fecha, muestra nro de habitación, fecha inicio y fin estadía, estado y nombre del cliente => detalle muestra datos completos de la reserva y del cliente|
|CUU/Epic|1. Reservar una habitación para la estadía<br>2. Realizar el check-in de una reserva|

Adicionales para Aprobación
|Req|Detalle|
|:-|:-|
|CRUD |1. CRUD Tipo Habitacion<br>2. CRUD Servicio<br>3. CRUD Localidad<br>4. CRUD Provincia<br>5. CRUD Habitación<br>6. CRUD Empleado<br>7. CRUD Cliente|
|CUU/Epic|1. Reservar una habitación para la estadía<br>2. Realizar el check-in de una reserva<br>3. Realizar el check-out y facturación de estadía y servicios|

### Alcance Adicional Voluntario

_Nota_: El Alcance Adicional Voluntario es opcional, pero ayuda a que la funcionalidad del sistema esté completa y será considerado en la nota en función de su complejidad y esfuerzo.

| Req      | Detalle                                                                                                                                                                                                             |
| :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Listados | 1. Estadía del día filtrado por fecha muestra, cliente, habitaciones y estado <br>2. Reservas filtradas por cliente muestra datos del cliente y de cada reserve fechas, estado cantidad de habitaciones y huespedes |
| CUU/Epic | 1. Consumir servicios<br>2. Cancelación de reserva                                                                                                                                                                  |
| Otros    | 1. Envío de recordatorio de reserva por email                                                                                                                                                                       |
