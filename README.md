# The Garrison System (TGS)

**Trabajo Práctico - Desarrollo de Software**

**UTN FRRo - Grupo Shelby**

---

The Garrison System es un sistema de ventas y gestión de recursos ambientado en el Birmingham de los años 1920. Simula una red comercial con elementos de riesgo, corrupción y toma de decisiones estratégicas, inspirado en la serie _Peaky Blinders_.

---

## 📋 Contenidos

- [Inicio Rápido](#-inicio-rápido)
- [Sobre este Proyecto](#sobre-este-proyecto)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Tecnologías](#tecnologías)
- [Instalación](#instalación)
- [Ejecución](#ejecución)
- [Cargar Datos de Prueba](#cargar-datos-de-prueba)
- [Documentación](#documentación)
- [Troubleshooting](#troubleshooting)
- [Equipo](#equipo)

---

## 🚀 Inicio Rápido

### Desarrollo Local

**Configuración simplificada con Docker para la infraestructura:**

```bash
# 1. Clonar con submódulos
git clone --recurse-submodules https://github.com/Lau-prog/GarrSYS.git
cd GarrSYS

# 2. Levantar infraestructura (PostgreSQL + Redis) con Docker
cd infra
docker compose up -d

# 3. Backend
cd ../apps/backend
pnpm install
cp .env.example .env.development
pnpm start:dev

# 4. Frontend (en otra terminal)
cd apps/frontend
pnpm install
pnpm start
```

**Acceder a:**
- Frontend: http://localhost:4200
- Backend API: http://localhost:3000
- Swagger Docs: http://localhost:3000/api-docs

### Producción en la Nube

El proyecto está desplegado en producción utilizando servicios en la nube:
- **Neon.tech** - PostgreSQL serverless
- **Redis Cloud** - Cache distribuido
- **Render** - Backend API
- **Vercel** - Frontend estático

---

## Sobre este Proyecto

Trabajo Práctico de la materia **Desarrollo de Software** de la UTN FRRo. El proyecto usa submódulos de Git para separar frontend, backend e infraestructura.

**Funcionalidades principales:**
- Gestión de productos (legales e ilegales)
- Clientes y ventas
- Socios y distribuidores
- Zonas de operación
- Autoridades y sobornos
- Decisiones del Consejo Shelby

---

## Estructura del Proyecto

```
TP-Desarrollo-de-Software/
├── apps/
│   ├── backend/              → Submódulo: API REST (Node.js + TypeScript)
│   └── frontend/             → Submódulo: SPA (Angular + TypeScript)
├── infra/
│   └── docker-compose.yml    → PostgreSQL 16 y Redis 7
├── scripts/
│   └── load-test-data.sh/.bat → Script para cargar datos
└── Makefile                  → Comandos simplificados
```

---

## Tecnologías

### Stack de Desarrollo

**Backend:** Node.js 18+ | TypeScript | Express.js | MikroORM | PostgreSQL 16 | Redis | JWT

**Frontend:** Angular 18+ | TypeScript | SCSS

**Infraestructura Local:** Docker | Docker Compose | Git (submódulos)

### Stack de Producción (Cloud)

**Database:** Neon.tech (PostgreSQL 16 serverless)

**Cache:** Redis Cloud (Redis 7)

**Backend Hosting:** Render (Node.js containers)

**Frontend Hosting:** Vercel (Edge Network)

---

## Instalación

### Requisitos

- **Node.js** >= 18
- **pnpm** >= 9
- **Docker** >= 24 y Docker Compose >= 2
- **Git**

### Pasos de Instalación

#### 1. Clonar el repositorio con submódulos

```bash
git clone --recurse-submodules https://github.com/Lau-prog/GarrSYS.git
cd GarrSYS
```

#### 2. Levantar infraestructura (PostgreSQL + Redis) con Docker

```bash
cd infra
docker compose up -d
```

Esto iniciará:
- **PostgreSQL** 16 en el puerto 5432
- **Redis** 7 en el puerto 6379

#### 3. Configurar el Backend

```bash
cd ../apps/backend
pnpm install
cp .env.example .env.development
```

Edita `.env.development` con las siguientes configuraciones importantes:

```env
# Database - Conexión a PostgreSQL de Docker
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=tpdesarrollo

# Redis - Opcional pero recomendado
REDIS_ENABLED=true
REDIS_HOST=localhost
REDIS_PORT=6379

# JWT Secret - Cambiar en producción
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production

# Email - Configurar con tus credenciales de Mailtrap o SMTP
SMTP_HOST=sandbox.smtp.mailtrap.io
SMTP_PORT=2525
SMTP_USER=tu-usuario
SMTP_PASS=tu-password

# Modo demo (sin verificación de email obligatoria)
EMAIL_VERIFICATION_REQUIRED=false
```

#### 4. Configurar el Frontend

```bash
cd ../frontend
pnpm install
```

El frontend ya está configurado para hacer proxy al backend en `http://localhost:3000` mediante `proxy.conf.json`.

---

## Ejecución

### Orden de Ejecución Recomendado

#### 1. Verificar que la infraestructura Docker esté corriendo

```bash
cd infra
docker compose ps
```

Deberías ver los servicios `mysql` y `redis` como "healthy" o "running".

#### 2. Iniciar el Backend

```bash
cd apps/backend

# Modo desarrollo (con verificación de email)
pnpm start:dev

# O modo demo (sin verificación de email obligatoria)
pnpm start:demo
```

El backend estará disponible en:
- **API**: http://localhost:3000
- **Swagger Docs**: http://localhost:3000/api-docs
- **Health Check**: http://localhost:3000/health

#### 3. Iniciar el Frontend (en otra terminal)

```bash
cd apps/frontend
pnpm start
```

El frontend estará disponible en:
- **App**: http://localhost:4200

### Comandos Útiles

#### Infraestructura Docker

```bash
# Ver logs de la infraestructura
cd infra
docker compose logs -f

# Detener infraestructura
docker compose down

# Reiniciar infraestructura
docker compose restart

# Detener y eliminar datos (¡CUIDADO!)
docker compose down -v
```

#### Backend

```bash
cd apps/backend

# Ejecutar migraciones
pnpm mikro-orm migration:up

# Limpiar build
pnpm clean

# Type check
pnpm type-check
```

#### Frontend

```bash
cd apps/frontend

# Build para producción
pnpm build

# Run tests
pnpm test
```

---

## Cargar Datos de Prueba

Después de levantar el backend por primera vez:

**Opción 1 - Script automático:**
```bash
# Desde la raíz del proyecto
bash scripts/load-test-data.sh    # Linux/Mac/Git Bash
scripts\load-test-data.bat        # Windows

# O con Make:
make load-data
```

**Opción 2 - Manual:**
```bash
cd apps/backend
node scripts/seed-test-data.mjs
```

**Datos incluidos:** 5 zonas, 10 productos, 12 usuarios, 4 ventas, 3 sobornos.

**Usuarios de prueba** (password: `password123`):
- **ADMIN:** `thomas.shelby@shelbyltd.co.uk`
- **PARTNERS:** `arthur.shelby@shelbyltd.co.uk`, `polly.gray@shelbyltd.co.uk`
- **DISTRIBUTORS:** `john.shelby@shelbyltd.co.uk`, `michael.gray@shelbyltd.co.uk`, `isaiah.jesus@shelbyltd.co.uk`
- **CLIENTS:** `alfie@solomonsltd.co.uk`, `johnny@example.com`, `aberama@goldltd.com`
- **AUTHORITIES:** `campbell@birminghampd.gov.uk`, `moss@birminghampd.gov.uk`

---

## Documentación

- **[Propuesta del Proyecto](docs/proposal.md)** - Alcance funcional
- **[Swagger UI](http://localhost:3000/api-docs)** - Documentación API (con backend corriendo)
- **[README Backend](apps/backend/README.md)** - Arquitectura y endpoints
- **[README Frontend](apps/frontend/README.md)** - Componentes y servicios

---

## Deployment en Producción

El sistema está desplegado en la nube utilizando una arquitectura distribuida:

### 🌐 Arquitectura de Producción

```
                    Internet
                       │
                       ↓
        ┌──────────────────────────┐
        │   Vercel Edge Network    │  ← Frontend (Angular SPA)
        │                          │     • Hosting estático global
        └──────────┬───────────────┘     • SSL/TLS automático
                   │
                   ↓ HTTPS API calls
        ┌──────────────────────────┐
        │   Render Cloud Platform  │  ← Backend (Node.js + Express)
        │                          │     • Contenedores Docker
        └──────────┬───────────────┘     • Health monitoring
                   │
                   ├─────────────────────┐
                   ↓                     ↓
        ┌──────────────────┐  ┌──────────────────┐
        │   Neon.tech      │  │  Redis Cloud     │
        │                  │  │                  │
        │ PostgreSQL 16    │  │  Redis 7         │
        │ Serverless DB    │  │  Cache layer     │
        └──────────────────┘  └──────────────────┘
```

**Componentes de la infraestructura:**

- **Frontend**: Aplicación Angular servida desde Vercel con CDN global
- **Backend**: API REST en Node.js/Express desplegada en Render
- **Base de Datos**: PostgreSQL 16 serverless en Neon.tech con pooling de conexiones
- **Cache**: Redis 7 en Redis Cloud para optimización de consultas y sesiones

---

## Equipo

**Grupo Shelby - UTN FRRo**

| Nombre | Legajo | GitHub |
|--------|--------|--------|
| Peralta, Lautaro Martín | 53483 | [@lautaro-peralta](https://github.com/lautaro-peralta) |
| Delprato, Luca | 50215 | [@LucaDelpra](https://github.com/LucaDelpra) |
| Splivalo, Tomas | 51665 | [@Tsplivalo](https://github.com/Tsplivalo) |

---

## 🔗 Repositorios

- **Principal:** [lautaro-peralta/GarrSYS](https://github.com/Lau-prog/GarrSYS)
- **Backend:** [lautaro-peralta/TGS-Backend](https://github.com/lautaro-peralta/TGS-Backend)
- **Frontend:** [Tsplivalo/TGS-Frontend](https://github.com/Tsplivalo/TGS-Frontend)

---

## Troubleshooting

### Error: "Cannot connect to PostgreSQL"

**Problema**: El backend no puede conectarse a la base de datos.

**Solución**:
1. Verifica que Docker esté corriendo:
   ```bash
   docker compose ps
   ```
2. Verifica que el puerto 5432 esté libre:
   ```bash
   netstat -ano | findstr :5432  # Windows
   lsof -i :5432                  # Linux/Mac
   ```
3. Revisa las credenciales en `.env.development`:
   ```env
   DB_HOST=localhost
   DB_PORT=5432
   DB_USER=postgres
   DB_PASSWORD=postgres
   DB_NAME=tpdesarrollo
   ```

### Error: "Redis connection failed"

**Problema**: El backend no puede conectarse a Redis.

**Solución**:
1. Si Redis es opcional, desactívalo en `.env.development`:
   ```env
   REDIS_ENABLED=false
   ```
2. O verifica que Redis esté corriendo:
   ```bash
   docker compose ps redis
   ```

### Error: "Port 3000 already in use"

**Problema**: El puerto del backend está ocupado.

**Solución**:
1. Encuentra el proceso que usa el puerto:
   ```bash
   netstat -ano | findstr :3000  # Windows
   lsof -i :3000                  # Linux/Mac
   ```
2. Cierra ese proceso o cambia el puerto en `.env.development`:
   ```env
   PORT=3001
   ```

### Error: "Submódulos vacíos"

**Problema**: Las carpetas `apps/backend` y `apps/frontend` están vacías.

**Solución**:
```bash
git submodule update --init --recursive
```

### Error: "CORS policy" en el frontend

**Problema**: El frontend no puede hacer requests al backend.

**Solución**:
1. Verifica que el backend esté corriendo en `http://localhost:3000`
2. Verifica `proxy.conf.json` en el frontend
3. Verifica la variable `ALLOWED_ORIGINS` en el backend:
   ```env
   ALLOWED_ORIGINS=http://localhost:4200
   ```

### La base de datos está vacía

**Solución**: Carga los datos de prueba siguiendo la sección [Cargar Datos de Prueba](#cargar-datos-de-prueba).

### Limpiar y empezar de nuevo

Si tienes problemas persistentes:

```bash
# 1. Detener todo
cd infra
docker compose down -v

# 2. Limpiar backend
cd ../apps/backend
rm -rf node_modules dist
pnpm install

# 3. Limpiar frontend
cd ../frontend
rm -rf node_modules .angular dist
pnpm install

# 4. Levantar infraestructura de nuevo
cd ../../infra
docker compose up -d

# 5. Iniciar backend y frontend
```

---

**Materia:** Desarrollo de Software | **Universidad:** UTN FRRo | **Año:** 2025
