# 📝 Minuta Individual – Implementación de `searchUtil` y ajustes en módulos

**Fecha:** 02/10/2025  
**Responsable:** Lautaro  

## 1. Creación de `searchUtil` (archivo `search.util.ts`)
- Se creó un utilitario compartido para centralizar la lógica de búsqueda en entidades.  
- Funciones implementadas:
  - `searchEntity`: búsqueda por campo de texto.
  - `searchEntityByDate`: búsqueda por rango de fechas.  

## 2. Cambios por módulo

### 📦 Product
- Eliminada lógica de búsqueda en el controlador → reemplazada por `searchEntity`.  
- Creado endpoint `/api/products/search`.  
- Validación de duplicados mejorada en la creación de productos.  
- Actualización de archivo de rutas y `.http`.  

### 💰 Sale
- Creado endpoint `/api/sales/search` → búsqueda por fecha con `searchEntityByDate`.  
- Controlador delega lógica a utilitario.  
- Actualización de archivo de rutas y `.http`.  

### 📝 Topic
- Creado endpoint `/api/topics/search` con `searchEntity`.  
- Ajuste en controlador para usar el utilitario.  
- Cambios en esquemas y rutas: `description` en lugar de `descripcion`.  
- Actualización de archivo `.http`.  

### 🌍 Zone
- Creado endpoint `/api/zones/search` con `searchEntity`.  
- Ajuste en controlador para usar el utilitario.  
- Cambios en esquemas y rutas: `name` en lugar de `nombre`.  
- Actualización de archivo `.http`.  

## 3. Cambios generales
- Estándar en nombres de campos (`description`, `name`, etc.).  
- Endpoints `/search` homogéneos en cada módulo.  
- Mejor reutilización y mantenibilidad al centralizar la lógica de búsqueda.  

## ✅ Resumen
Se consolidó la búsqueda en los módulos **Product, Sale, Topic y Zone** mediante la creación de `searchUtil`. Ahora la lógica está centralizada y los endpoints `/search` son consistentes, mejorando la calidad del código y reduciendo duplicación.

## Falta
Corregir mensajes de error al inglés. Terminar los search, con el resto de entidades.
