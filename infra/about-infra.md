# Infraestructura - The Garrison System

Esta carpeta contiene la configuración de infraestructura para el proyecto.

## Contenido

### [docker-compose.yml](docker-compose.yml)
Configuración de servicios Docker:
- **MySQL 8.0** (Percona Server) - Puerto 3307
- **Redis 7** - Puerto 6379

### [init-test-data.sql](init-test-data.sql)
Script SQL con datos de prueba. **Se carga mediante script Node.js después de que el backend cree las tablas**.

## Uso

### Levantar servicios
```bash
docker-compose up -d
```

### Cargar datos de prueba
```bash
# 1. Primero, levanta el backend para que cree las tablas
cd ../apps/backend
pnpm dev  # Espera hasta ver "Server running..."

# 2. En otra terminal, ejecuta el script de carga
cd ../apps/backend
node scripts/seed-test-data.mjs
```

### Recargar datos desde cero
```bash
# 1. Elimina volúmenes y recrea
docker-compose down -v
docker-compose up -d

# 2. Levanta el backend para recrear tablas
cd ../apps/backend
pnpm dev

# 3. Recarga datos
node scripts/seed-test-data.mjs
```

### Ver logs de MySQL
```bash
docker-compose logs -f mysql
```

### Conectarse a MySQL manualmente
```bash
docker exec -it ps8-dsw-tgs mysql -u dsw -pdsw tpdesarrollo
```

## Datos de Prueba Incluidos

El script `init-test-data.sql` carga:

### Usuarios (password: `password123`)
**Nota:** Las contraseñas están hasheadas con **Argon2**, el algoritmo usado por el backend.

- **ADMIN:** thomas.shelby
- **PARTNERS:** arthur.shelby, polly.gray
- **DISTRIBUTORS:** john.shelby, michael.gray, isaiah.jesus
- **CLIENTS:** alfie.solomons, johnny.dogs, aberama.gold
- **AUTHORITIES:** insp.campbell, moss.officer
- **USER no verificado:** new.user

### Datos del Sistema
- **5 Zonas** de Birmingham (Small Heath, Camden Town, Digbeth, Sparkbrook, Bordesley)
- **10 Productos** (5 legales: whiskey, gin, tabaco / 5 ilegales: cocaína, opio, armas, arreglo de carreras, protección)
- **4 Ventas** con detalles completos
- **3 Sobornos** a autoridades
- **Relaciones completas** entre distribuidores, productos y zonas

### Estructura de Datos
```
zones (5 zonas de Birmingham)
  ↓
products (10 productos legales e ilegales)
  ↓
users (12 usuarios con diferentes roles)
  ↓
persons (información personal)
  ↓
partners, distributors, clients, authorities (entidades específicas)
  ↓
sales → details (ventas con sus detalles)
  ↓
bribes (sobornos a autoridades)
```

## Nota para Evaluación

Este script permite al profesor/evaluador:
1. Levantar el proyecto con un solo comando
2. Tener datos representativos de TODAS las funcionalidades
3. Probar flujos completos sin necesidad de crear datos manualmente
4. Ver ejemplos de productos legales/ilegales, ventas, sobornos, etc.

## Tecnologías

- **MySQL:** Percona Server 8.0 (compatible 100% con MySQL)
- **Redis:** Cache y sesiones
- **Docker Compose:** Orquestación de servicios

---

**Nota:** Los volúmenes de datos (`mysql-data/`, `redis-data/`) están en `.gitignore` para no subir datos locales al repositorio.
