# Infraestructura - The Garrison System

Esta carpeta contiene la configuración de infraestructura para el proyecto TGS.

---

## 📁 Contenido

```
infra/
├── docker-compose.yml          # Configuración de servicios Docker
├── init-test-data.sql          # Datos de prueba del sistema
├── .env.production.example     # Template para producción (opcional)
└── README.md                   # Este archivo
```

---

## 🐳 Servicios Docker

### MySQL 8.0 (Percona Server)
- **Container**: `ps8-dsw-tgs`
- **Puerto**: 3307 (host) → 3306 (container)
- **Credenciales**:
  - Usuario root: `root`
  - Base de datos: `tpdesarrollo`
  - Usuario app: `dsw` / `dsw`
- **Volumen**: `tgs-mysql-data` (persistente)

### Redis 7
- **Container**: `redis-dsw-tgs`
- **Puerto**: 6379
- **Volumen**: `tgs-redis-data` (persistente)
- **Persistencia**: AOF (append-only file) activado

### Backend (solo en modo producción)
- **Container**: `tgs-backend-prod`
- **Puerto**: 3000
- **Nota**: Solo se levanta con `--profile production`

### Frontend (solo en modo producción)
- **Container**: `tgs-frontend-prod`
- **Puerto**: 80
- **Servidor**: Nginx
- **Nota**: Solo se levanta con `--profile production`

---

## 🚀 Uso

### Modo Desarrollo (Recomendado)

**Solo levanta MySQL + Redis**. Backend y frontend corren localmente con hot-reload.

```bash
# Levantar infraestructura
cd infra
docker compose up -d

# Verificar estado
docker compose ps

# Ver logs
docker compose logs -f

# Detener
docker compose down
```

**Luego, en terminales separadas:**
```bash
# Terminal 1 - Backend
cd apps/backend
pnpm start:dev

# Terminal 2 - Frontend
cd apps/frontend
pnpm start
```

**Acceder:**
- Frontend: http://localhost:4200
- Backend: http://localhost:3000
- Swagger: http://localhost:3000/api-docs

---

### Modo Producción (Opcional)

**Levanta todo el stack** (MySQL + Redis + Backend + Frontend) en contenedores.

**¿Necesito el archivo `.env.production`?**

- **NO es estrictamente necesario** si solo usas valores por defecto
- **SÍ es necesario** si quieres configurar:
  - Contraseñas seguras (producción real)
  - JWT secret personalizado
  - Configuración SMTP real
  - Dominios específicos para CORS

**Para desarrollo local en producción mode:**
```bash
# 1. Levantar con valores por defecto (sin .env.production)
cd infra
docker compose --profile production up -d

# 2. O configurar valores personalizados (con .env.production)
cp .env.production.example .env.production
nano .env.production  # Editar valores
docker compose --profile production --env-file .env.production up -d

# Ver logs
docker compose --profile production logs -f

# Detener
docker compose --profile production down
```

**Acceder:**
- Frontend: http://localhost (puerto 80)
- Backend: http://localhost:3000
- Desde otra máquina en la red: http://TU_IP

---

## 📊 Cargar Datos de Prueba

**Después de levantar el backend por primera vez**, carga los datos de prueba:

### Opción 1: Script automático (Recomendado)
```bash
# Desde la raíz del proyecto
bash scripts/load-test-data.sh    # Linux/Mac/Git Bash
scripts\load-test-data.bat        # Windows

# O con Make:
make load-data
```

### Opción 2: Manual
```bash
# 1. Asegúrate que el backend esté corriendo (crea las tablas)
cd apps/backend
pnpm start:dev  # Espera a ver "Server running..."

# 2. En otra terminal, ejecuta el script de carga
cd apps/backend
node scripts/seed-test-data.mjs
```

### Opción 3: Directo a MySQL (requiere tablas creadas)
```bash
docker compose exec mysql mysql -u dsw -pdsw tpdesarrollo < init-test-data.sql
```

---

## 🧪 Datos de Prueba Incluidos

El script `init-test-data.sql` carga:

### Usuarios (password: `password123`)
**Nota:** Contraseñas hasheadas con Argon2.

**Roles:**
- **ADMIN:** thomas.shelby@shelbyltd.co.uk
- **PARTNERS:** arthur.shelby@shelbyltd.co.uk, polly.gray@shelbyltd.co.uk
- **DISTRIBUTORS:** john.shelby@shelbyltd.co.uk, michael.gray@shelbyltd.co.uk, isaiah.jesus@shelbyltd.co.uk
- **CLIENTS:** alfie@solomonsltd.co.uk, johnny@example.com, aberama@goldltd.com
- **AUTHORITIES:** campbell@birminghampd.gov.uk, moss@birminghampd.gov.uk
- **USER (no verificado):** new.user@example.com

### Datos del Sistema
- **5 Zonas** de Birmingham (Small Heath, Camden Town, Digbeth, Sparkbrook, Bordesley)
- **10 Productos**
  - Legales: whiskey, gin, tabaco, carbón, metales
  - Ilegales: cocaína, opio, armas, arreglo de carreras, protección
- **4 Ventas** completas con detalles
- **3 Sobornos** a autoridades
- **Relaciones** entre distribuidores, productos y zonas

### Estructura de Relaciones
```
zones (5 zonas)
  ↓
products (10 productos)
  ↓
users (12 usuarios)
  ↓
persons (información personal)
  ↓
partners, distributors, clients, authorities
  ↓
sales → sale_details
  ↓
bribes
```

---

## 🛠️ Comandos Útiles

### Infraestructura

```bash
# Ver estado de contenedores
docker compose ps

# Ver logs en tiempo real
docker compose logs -f mysql
docker compose logs -f redis

# Reiniciar un servicio
docker compose restart mysql

# Conectarse a MySQL
docker compose exec mysql mysql -u dsw -pdsw tpdesarrollo

# Conectarse a Redis CLI
docker compose exec redis redis-cli

# Backup de base de datos
docker compose exec mysql mysqldump -u root -proot tpdesarrollo > backup.sql

# Restaurar base de datos
docker compose exec -T mysql mysql -u root -proot tpdesarrollo < backup.sql
```

### Limpiar y Empezar de Nuevo

```bash
# Detener y eliminar TODO (incluye datos)
docker compose down -v

# Levantar de nuevo
docker compose up -d
```

---

## 🌐 Acceso desde Otras Máquinas

### Desarrollo Local
Mantén `docker compose up -d` y corre backend/frontend con binding de red:

**Backend:**
```bash
# En .env.development
HOST=0.0.0.0

# Iniciar
pnpm start:dev
```

**Frontend:**
```bash
ng serve --host 0.0.0.0
```

**Acceder desde otra máquina:**
```
http://TU_IP:4200
```

### Modo Producción Completo
```bash
# Levantar stack completo
docker compose --profile production up -d

# Acceder desde otra máquina
http://TU_IP
```

### Firewall (si es necesario)
```bash
# Windows
netsh advfirewall firewall add rule name="TGS" dir=in action=allow protocol=TCP localport=80

# Linux (ufw)
sudo ufw allow 80/tcp
```

---

## 🔧 Troubleshooting

### Error: "Cannot connect to MySQL"
```bash
# Verificar que esté corriendo
docker compose ps

# Ver logs
docker compose logs mysql

# Verificar puerto libre
netstat -ano | findstr :3307  # Windows
lsof -i :3307                  # Linux/Mac
```

### Puerto ocupado
```bash
# Cambiar puerto en docker-compose.yml
ports:
  - "3308:3306"  # Usar 3308 en lugar de 3307

# Actualizar .env.development del backend
DB_PORT=3308
```

### Contenedor no arranca
```bash
# Ver logs detallados
docker compose logs mysql -f

# Eliminar y recrear
docker compose down -v
docker compose up -d
```

### Base de datos vacía
```bash
# Cargar datos de prueba
make load-data

# O manual
cd apps/backend
node scripts/seed-test-data.mjs
```

---

## 📋 Tecnologías

- **MySQL:** Percona Server 8.0 (100% compatible con MySQL)
- **Redis:** Cache y sesiones
- **Docker Compose:** Orquestación de servicios
- **Nginx:** Servidor web (solo en modo producción)

---

## 📝 Notas

- **Volúmenes persistentes**: Los datos se guardan en volúmenes Docker y persisten entre reinicios
- **Network**: Todos los servicios están en la red `tgs-network`
- **Health checks**: MySQL y Redis tienen verificaciones de salud automáticas
- **Seguridad**: Las contraseñas por defecto son para desarrollo. **CAMBIARLAS en producción**

---

## 🎓 Nota para Evaluación

Esta configuración permite al evaluador:
1. ✅ Levantar el proyecto con un solo comando (`docker compose up -d`)
2. ✅ Tener datos representativos de TODAS las funcionalidades
3. ✅ Probar flujos completos sin crear datos manualmente
4. ✅ Ver ejemplos de productos legales/ilegales, ventas, sobornos, etc.

Los volúmenes de datos (`mysql-data/`, `redis-data/`) están en `.gitignore`.

---

**Proyecto:** The Garrison System | **Materia:** Desarrollo de Software | **UTN FRRo**
