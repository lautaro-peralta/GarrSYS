# Minuta de Cambios - TGS Backend

## 1. Búsqueda Genérica (/search) en Módulos
Se implementó el endpoint /search en los siguientes módulos:

- client
- distributor
- decision
- bribe

Todos estos endpoints utilizan una función utilitaria genérica (searchEntity) para realizar búsquedas por campos relevantes (por ejemplo, description, name, amount, etc.).
# Nueva función utilitaria (searchEntityByBoolean)
Función que permite búsquedas por campos booleanos en la API, como el campo paid de los sobornos. Ahora, al buscar con q=true o q=false, la API retorna correctamente los resultados filtrados por ese valor. 

## 2. Validaciones y Schemas
Se mejoró la validación de campos en los schemas de Zod, permitiendo que IDs como zoneId sean aceptados tanto como string o number y transformados correctamente.
Se revisaron y ajustaron los schemas de creación y actualización en los módulos afectados.

## 3. Refactorización de Controladores
Se refactorizaron los controladores para:
Utilizar siempre ResponseUtil para respuestas exitosas y de error.
Centralizar la lógica de búsqueda y validación.
Mejorar el manejo de errores y mensajes de conflicto o no encontrado.
Se agregaron métodos de búsqueda (searchX) en los controladores de cada módulo.

## 4. Rutas y Endpoints
Se agregaron las rutas /search en los archivos de rutas de cada módulo.
Se ajustaron los endpoints para reflejar los cambios de nombres y consistencia en la API.

5. Otros Cambios
Se corrigieron errores de duplicación y organización de métodos en los controladores.
Se revisaron y ajustaron manualmente los archivos afectados para asegurar el correcto funcionamiento tras los cambios automáticos.

# Falta
Implementar distribcuidores en el proceso de una venta. Es decir, decidir como se va a asignar un distribuidor a esa venta. Además, se debe continuar con partner para luego ir a la autenticación.
