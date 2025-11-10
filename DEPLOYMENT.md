# Guía de Deployment - TGS (The Garrison System)

**Guía completa para desplegar The Garrison System** tanto de forma gratuita en la nube como usando Docker.

---

## 🎯 Arquitectura de Deployment

```
┌─────────────────┐
│     Vercel      │  ← Frontend (Angular)
│   (GRATUITO)    │     • Hosting global
└────────┬────────┘     • SSL automático
         │              • CI/CD integrado
         ↓ API calls
┌─────────────────┐
│     Render      │  ← Backend (Express.js)
│   (GRATUITO)    │     • 750 hrs/mes gratis
└────────┬────────┘     • Auto-deploy desde Git
         │
         ↓
┌─────────────────┐
│   Neon.tech     │  ← Database (PostgreSQL)
│   (GRATUITO)    │     • 3GB storage
└─────────────────┘     • Serverless
         +
┌─────────────────┐
│    Upstash      │  ← Redis Cache
│   (GRATUITO)    │     • 10K comandos/día
└─────────────────┘     • Global
```

---

## 📌 Estado Actual del Proyecto

✅ **El proyecto YA está configurado con PostgreSQL**
- Base de datos: PostgreSQL 16
- ORM: MikroORM con driver PostgreSQL
- Docker: Configurado y listo para usar
- Archivos Dockerfile para backend y frontend disponibles

---

## ⚠️ Consideraciones Importantes

### Base de Datos PostgreSQL

El proyecto usa PostgreSQL porque:
- Los servicios gratuitos ofrecen PostgreSQL (no MySQL)
- Mejor soporte para datos JSON y tipos avanzados
- Más robusto para aplicaciones en producción

### Variables de Entorno

**Para deployment en la nube:**
- Los servicios (Vercel, Render) tienen su propia configuración de variables
- NO necesitas crear archivos `.env.production` manualmente
- Configuras las variables directamente en cada plataforma

**Para Docker local:**
- Usa `.env.development` para desarrollo
- Las variables de entorno se configuran en `docker-compose.yml`

---

## 📋 Servicios Gratuitos Recomendados

| Servicio | Propósito | Tier Gratuito | Límites |
|----------|-----------|---------------|---------|
| **Vercel** | Frontend | ✅ Ilimitado | 100GB bandwidth/mes, builds ilimitados |
| **Render** | Backend | ✅ 750 hrs/mes | Duerme tras 15 min inactividad |
| **Neon.tech** | PostgreSQL | ✅ 3GB | 1 proyecto, 10 branches |
| **Upstash** | Redis | ✅ 10K cmds/día | Suficiente para MVP |
| **Mailtrap** | Email (dev) | ✅ Ilimitado | Solo testing, no envío real |
| **Resend** | Email (prod) | ✅ 100 emails/día | Para verificación real |

---

## 🚀 Deployment en la Nube - Paso a Paso

Esta sección cubre el deployment usando servicios gratuitos en la nube.

---

### PASO 1: Database - Neon.tech (PostgreSQL Gratis)

#### 1. Crear cuenta
- Ve a https://neon.tech
- Sign up con GitHub (gratis)

#### 2. Crear proyecto
- Click "Create Project"
- Nombre: `tgs-database`
- Región: `US East (Ohio)` (más cercana)
- PostgreSQL version: 16

#### 3. Obtener connection string
```
Neon te dará algo así:
postgresql://username:password@ep-cool-name-123456.us-east-2.aws.neon.tech/neondb?sslmode=require
```

#### 4. Copiar para más tarde
Guarda esta URL, la usarás en el backend.

---

### PASO 2: Redis - Upstash (Gratis)

#### 1. Crear cuenta
- Ve a https://upstash.com
- Sign up con GitHub

#### 2. Crear Redis database
- Click "Create Database"
- Nombre: `tgs-cache`
- Región: `US-East-1`
- Type: Regional (gratis)

#### 3. Obtener credenciales
En el dashboard verás:
```
Endpoint: redis-12345.upstash.io
Port: 6379
Password: AaBbCc123XxYyZz==
```

#### 4. Copiar para más tarde

---

### PASO 3: Backend - Render (Gratis)

#### 1. Preparar repositorio

**Crear archivo:** `apps/backend/render.yaml`
```yaml
services:
  - type: web
    name: tgs-backend
    runtime: node
    buildCommand: pnpm install && pnpm build
    startCommand: node dist/server.js
    envVars:
      - key: NODE_ENV
        value: production
      - key: PORT
        value: 10000
```

**Actualizar:** `apps/backend/package.json`
```json
{
  "scripts": {
    "start": "node dist/server.js",
    "build": "tsc -p ./tsconfig.json"
  },
  "engines": {
    "node": ">=18"
  }
}
```

#### 2. Crear servicio en Render

- Ve a https://render.com
- Sign up con GitHub
- Click "New +" → "Web Service"
- Conecta tu repositorio GitHub
- **Root Directory**: `apps/backend`
- **Build Command**: `pnpm install && pnpm build`
- **Start Command**: `node dist/server.js`
- **Plan**: Free

#### 3. Configurar variables de entorno

En Render dashboard → Environment:

```env
NODE_ENV=production
PORT=10000

# Database (de Neon.tech)
DATABASE_URL=postgresql://tu-url-de-neon-aqui

# JWT
JWT_SECRET=genera-un-string-aleatorio-seguro-de-32-caracteres-minimo
JWT_EXPIRES_IN=15m

# Redis (de Upstash)
REDIS_ENABLED=true
REDIS_HOST=redis-12345.upstash.io
REDIS_PORT=6379
REDIS_PASSWORD=tu-password-de-upstash
REDIS_TLS=true

# CORS (actualizarás después de deploy de Vercel)
ALLOWED_ORIGINS=https://tu-app.vercel.app,http://localhost:4200

# Email - Opción 1: Mailtrap (solo testing)
SMTP_HOST=sandbox.smtp.mailtrap.io
SMTP_PORT=2525
SMTP_USER=tu-mailtrap-user
SMTP_PASS=tu-mailtrap-pass
SMTP_FROM=noreply@tgs-system.com

# Email - Opción 2: Resend (envío real, 100/día gratis)
# SMTP_HOST=smtp.resend.com
# SMTP_PORT=587
# SMTP_USER=resend
# SMTP_PASS=re_tu-api-key-de-resend
# SMTP_FROM=onboarding@resend.dev

FRONTEND_URL=https://tu-app.vercel.app
EMAIL_VERIFICATION_REQUIRED=true

TRUST_PROXY=true
```

#### 4. Deploy

- Click "Create Web Service"
- Render automáticamente hace deploy
- Anota tu URL: `https://tgs-backend.onrender.com`

**Nota importante:** El tier gratuito de Render **duerme tras 15 minutos de inactividad**. La primera request tras dormir tardará 30-50 segundos en despertar.

---

### PASO 4: Frontend - Vercel (Gratis)

#### 1. Preparar configuración

**Archivo:** `apps/frontend/vercel.json`
```json
{
  "version": 2,
  "name": "tgs-frontend",
  "buildCommand": "pnpm build --configuration production",
  "outputDirectory": "dist/frontend/browser",
  "framework": "angular",
  "installCommand": "pnpm install",
  "regions": ["iad1"],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "https://tgs-backend.onrender.com/api/$1"
    },
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

**Actualizar la URL del backend** con tu URL real de Render.

#### 2. Deploy con Vercel

**Opción A: Vercel Web UI (Más fácil)**

1. Ve a https://vercel.com
2. Sign up con GitHub
3. Click "Add New..." → "Project"
4. Importa tu repositorio
5. Configuración:
   - **Framework Preset**: Angular
   - **Root Directory**: `apps/frontend`
   - **Build Command**: `pnpm build --configuration production`
   - **Output Directory**: `dist/frontend/browser`
6. Click "Deploy"

**Opción B: Vercel CLI**

```bash
# Instalar CLI
pnpm add -g vercel

# Login
vercel login

# Deploy desde apps/frontend
cd apps/frontend
vercel

# Seguir prompts, luego deploy a producción
vercel --prod
```

#### 3. Obtener URL

Vercel te dará: `https://tu-proyecto.vercel.app`

#### 4. Actualizar CORS en backend

Vuelve a Render → Environment → Actualiza:
```env
ALLOWED_ORIGINS=https://tu-proyecto.vercel.app
FRONTEND_URL=https://tu-proyecto.vercel.app
```

Click "Save" (Render re-deploya automáticamente)

---

### PASO 5: Migración de Base de Datos

Una vez que todo esté deployado:

```bash
# 1. Conectarte a Neon.tech localmente
export DATABASE_URL="postgresql://tu-url-de-neon"

# 2. Correr migraciones
cd apps/backend
pnpm mikro-orm migration:up

# 3. Cargar datos de prueba (si tienes un script adaptado para PostgreSQL)
node scripts/seed-test-data.mjs
```

**O desde Render:**
- Ve a Shell en el dashboard de Render
- Ejecuta: `node dist/scripts/seed-test-data.js`

---

## 📊 Resumen de Costos

| Servicio | Costo | Límites |
|----------|-------|---------|
| **Vercel** | $0 | 100GB bandwidth, deployments ilimitados |
| **Render** | $0 | 750 horas/mes (suficiente para 1 app 24/7) |
| **Neon.tech** | $0 | 3GB storage, 1 proyecto |
| **Upstash** | $0 | 10,000 comandos/día |
| **Resend** | $0 | 100 emails/día |
| **TOTAL** | **$0/mes** | ✅ Suficiente para proyecto universitario |

---

## ⚡ Workflow de Desarrollo

### Desarrollo Local
```bash
# Infra
cd infra && docker compose up -d

# Backend
cd apps/backend
pnpm start:dev

# Frontend
cd apps/frontend
pnpm start
```

### Deploy a Producción
```bash
# Backend - Auto-deploy en cada push a main
git push origin main

# Frontend - Auto-deploy en cada push a main
git push origin main

# O manual
cd apps/frontend
vercel --prod
```

---

## 🔍 Monitoreo

### Logs del Backend (Render)
- Dashboard → tu servicio → Logs tab
- Ver en tiempo real

### Logs del Frontend (Vercel)
- Dashboard → Deployments → Ver logs de build

### Base de Datos (Neon.tech)
- Dashboard → Monitoring
- Ver queries, uso de storage

---

## ⚠️ Limitaciones del Tier Gratuito

### Render (Backend)
- ⏰ **Duerme tras 15 min inactivos**
- 🐌 **Primera request: 30-50 segundos** (despertar)
- ✅ **Solución**: Para demo, haz una request 1 minuto antes

### Neon.tech (Database)
- 💾 **3GB storage** (suficiente para MVP)
- 🔌 **Conexiones limitadas** (usar pooling)

### Upstash (Redis)
- 📊 **10K comandos/día** (suficiente para 100-200 usuarios/día)

### Vercel (Frontend)
- 🌐 **100GB bandwidth/mes** (suficiente para 10K-50K visitas)

---

## 🎓 Para Presentación/Demo

**Problema:** Backend tarda 50 segundos en despertar en la primera request.

**Solución:**

### Opción 1: Pre-calentar antes de la demo
```bash
# 1 minuto antes de presentar, hacer una request
curl https://tgs-backend.onrender.com/health

# Esperar 30-50 segundos, luego tu app estará rápida
```

### Opción 2: Keep-alive automático (opcional)

**Crear servicio gratuito de "ping":**
- https://cron-job.org (gratis)
- Configurar ping cada 14 minutos a: `https://tgs-backend.onrender.com/health`
- Mantiene tu app despierta 24/7

**IMPORTANTE:** Esto consume tus 750 horas/mes más rápido. Úsalo solo cerca de la fecha de entrega.

---

## 🆘 Troubleshooting

### Backend no conecta a database
```bash
# Verificar connection string
# Debe incluir ?sslmode=require al final
DATABASE_URL=postgresql://user:pass@host/db?sslmode=require
```

### Frontend no hace requests al backend
```bash
# Verificar CORS en Render
ALLOWED_ORIGINS=https://tu-app.vercel.app

# Verificar proxy en vercel.json
"dest": "https://tu-backend.onrender.com/api/$1"
```

### Emails no llegan
```bash
# Para desarrollo: Usar Mailtrap (no envía emails reales)
# Para producción: Usar Resend (100 emails/día reales)

# Verificar en Render:
SMTP_HOST=smtp.resend.com
SMTP_USER=resend
SMTP_PASS=tu-api-key
```

### Backend muy lento
```bash
# Normal en tier gratuito de Render
# Primera request tras inactividad: 30-50 segundos
# Requests siguientes: normal (100-300ms)

# Solución: Pre-calentar antes de demo
curl https://tu-backend.onrender.com/health
```

---

## 📝 Checklist de Deployment en la Nube

- [ ] Crear cuenta en Neon.tech y obtener DATABASE_URL
- [ ] Crear cuenta en Upstash y obtener credenciales Redis
- [ ] Crear cuenta en Render y configurar backend
- [ ] Configurar todas las variables de entorno en Render
- [ ] Esperar deploy del backend y anotar URL
- [ ] Actualizar `vercel.json` con URL del backend
- [ ] Deploy frontend en Vercel
- [ ] Actualizar CORS en Render con URL de Vercel
- [ ] Correr migraciones en Neon.tech
- [ ] Cargar datos de prueba
- [ ] Probar registro, login, y funcionalidades
- [ ] Pre-calentar backend antes de demo

---

## 🎯 Tiempo Estimado (Deployment en la Nube)

- Setup de servicios (Neon, Upstash, Render, Vercel): **1 hora**
- Configuración y testing: **30 minutos**
- **TOTAL: 1.5 horas**

---

## 🐳 Deployment con Docker

Esta sección explica cómo deployar TGS usando Docker y Docker Compose.

### ¿Qué es Docker y por qué usarlo?

**Docker** es una plataforma que empaqueta tu aplicación y todas sus dependencias en "contenedores". Esto garantiza que tu aplicación funcione exactamente igual en cualquier lugar: tu computadora, un servidor, o la nube.

**Ventajas de Docker para este proyecto:**
- ✅ Todo el stack (frontend, backend, database, Redis) en un solo comando
- ✅ Configuración reproducible y consistente
- ✅ Fácil de deployar en cualquier servidor con Docker
- ✅ Aislamiento: no interfiere con otros proyectos
- ✅ No necesitas instalar PostgreSQL o Redis localmente

### Arquitectura Docker del Proyecto

```
┌─────────────────────────────────────────┐
│         Docker Compose                  │
├─────────────────────────────────────────┤
│                                         │
│  ┌──────────┐  ┌──────────┐           │
│  │ Frontend │  │ Backend  │           │
│  │ (Nginx)  │  │ (Node.js)│           │
│  │ Port: 80 │  │ Port:3000│           │
│  └──────────┘  └──────────┘           │
│       │              │                  │
│       │              ↓                  │
│       │      ┌──────────────┐          │
│       │      │  PostgreSQL  │          │
│       │      │  Port: 5432  │          │
│       │      └──────────────┘          │
│       │              │                  │
│       │              ↓                  │
│       │      ┌──────────────┐          │
│       │      │    Redis     │          │
│       │      │  Port: 6379  │          │
│       └──────┴──────────────┘          │
│                                         │
└─────────────────────────────────────────┘
```

### Configuración Actual del Proyecto

Tu proyecto **ya tiene todo configurado**:
- ✅ `docker-compose.yml` en la carpeta `infra/`
- ✅ `Dockerfile` para backend en `apps/backend/`
- ✅ `Dockerfile` para frontend en `apps/frontend/`
- ✅ PostgreSQL 16 configurado
- ✅ Redis 7 configurado

### Modos de Deployment con Docker

El proyecto soporta 2 modos:

#### 1. Modo Desarrollo (solo infraestructura)
```bash
cd infra
docker compose up -d
```
- Levanta **solo PostgreSQL + Redis**
- Backend y frontend corren en tu máquina (con `pnpm start:dev`)
- Ideal para desarrollo activo con hot-reload

#### 2. Modo Producción (stack completo)
```bash
cd infra
docker compose --profile production up -d
```
- Levanta **todo**: Frontend + Backend + PostgreSQL + Redis
- Backend optimizado (compilado con TypeScript)
- Frontend servido con Nginx
- Ideal para testing de producción o deployment real

### Paso a Paso: Deployment con Docker (Modo Producción)

#### PASO 1: Verificar requisitos

Necesitas tener instalado:
- Docker Desktop (Windows/Mac) o Docker Engine (Linux)
- Docker Compose (incluido en Docker Desktop)

Verificar instalación:
```bash
docker --version       # Debe mostrar v20.10 o superior
docker compose version # Debe mostrar v2.0 o superior
```

#### PASO 2: Configurar variables de entorno (opcional)

El proyecto usa valores por defecto seguros. Si quieres personalizarlos, crea un archivo `.env` en la carpeta `infra/`:

```bash
cd infra
```

**Archivo: `infra/.env`** (opcional, los defaults funcionan bien)
```env
# PostgreSQL
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=tpdesarrollo

# JWT
JWT_SECRET=Th1sIsMyN3wSupaDupaS3cureS3cr3ttt
JWT_EXPIRES_IN=15m

# Redis
REDIS_ENABLED=true

# Security
ALLOWED_ORIGINS=http://localhost
TRUST_PROXY=true

# Email (Mailtrap para testing)
SMTP_HOST=sandbox.smtp.mailtrap.io
SMTP_PORT=2525
SMTP_USER=tu-usuario-mailtrap
SMTP_PASS=tu-password-mailtrap
SMTP_FROM=noreply@tgs-system.com

# Frontend
FRONTEND_URL=http://localhost
EMAIL_VERIFICATION_REQUIRED=true
```

#### PASO 3: Levantar el stack completo

```bash
# Desde la carpeta infra/
cd infra

# Levantar todo el stack (PostgreSQL + Redis + Backend + Frontend)
docker compose --profile production up -d

# Ver los logs en tiempo real
docker compose logs -f
```

**Esto hace lo siguiente:**
1. Construye las imágenes Docker de backend y frontend
2. Levanta PostgreSQL 16 en puerto 5432
3. Levanta Redis 7 en puerto 6379
4. Compila y levanta el backend en puerto 3000
5. Compila y levanta el frontend en puerto 80

#### PASO 4: Esperar a que todo esté listo

Docker tiene health checks configurados. Puedes ver el estado con:

```bash
docker compose ps
```

Espera hasta que todos los servicios muestren `healthy`:
```
NAME                   STATUS
postgres-dsw-tgs       Up (healthy)
redis-dsw-tgs          Up (healthy)
tgs-backend-prod       Up (healthy)
tgs-frontend-prod      Up (healthy)
```

Esto puede tomar 1-2 minutos en el primer inicio.

#### PASO 5: Ejecutar migraciones de base de datos

```bash
# Opción A: Desde tu máquina (conectándote al PostgreSQL de Docker)
cd apps/backend
export DATABASE_URL="postgresql://postgres:postgres@localhost:5432/tpdesarrollo"
pnpm mikro-orm migration:up

# Opción B: Desde dentro del contenedor backend
docker exec tgs-backend-prod node dist/migrations/run-migrations.js
```

#### PASO 6: Cargar datos de prueba (opcional)

```bash
# Opción A: Desde tu máquina
cd apps/backend
export DATABASE_URL="postgresql://postgres:postgres@localhost:5432/tpdesarrollo"
node scripts/seed-test-data.mjs

# Opción B: Desde dentro del contenedor
docker exec tgs-backend-prod node scripts/seed-test-data.mjs
```

#### PASO 7: Acceder a la aplicación

¡Listo! Ahora puedes acceder:

- **Frontend**: http://localhost
- **Backend API**: http://localhost:3000
- **API Docs (Swagger)**: http://localhost:3000/api/docs

### Comandos Útiles de Docker

```bash
# Ver todos los contenedores corriendo
docker compose ps

# Ver logs de todos los servicios
docker compose logs -f

# Ver logs de un servicio específico
docker compose logs -f backend
docker compose logs -f frontend
docker compose logs -f postgres

# Detener todo
docker compose --profile production down

# Detener y borrar volúmenes (CUIDADO: borra la base de datos)
docker compose --profile production down -v

# Reiniciar un servicio específico
docker compose restart backend

# Reconstruir imágenes (después de cambios en código)
docker compose --profile production up -d --build

# Acceder a la shell de un contenedor
docker exec -it tgs-backend-prod sh
docker exec -it postgres-dsw-tgs psql -U postgres -d tpdesarrollo
```

### Troubleshooting con Docker

#### El backend no inicia
```bash
# Ver logs detallados
docker compose logs backend

# Verificar que PostgreSQL esté healthy
docker compose ps postgres

# Reintentar
docker compose restart backend
```

#### Error "port already in use"
```bash
# Algún otro servicio está usando el puerto
# Opción 1: Detener el otro servicio
# Opción 2: Cambiar el puerto en docker-compose.yml

# Por ejemplo, cambiar frontend de puerto 80 a 8080:
# En docker-compose.yml, línea ~122:
# ports:
#   - "8080:80"
```

#### La base de datos está vacía
```bash
# Verificar que las migraciones corrieron
docker exec tgs-backend-prod ls dist/migrations/

# Correr migraciones manualmente
docker exec tgs-backend-prod node dist/migrations/run-migrations.js
```

#### Cambios en el código no se reflejan
```bash
# Reconstruir las imágenes
docker compose --profile production up -d --build

# Si sigue sin funcionar, limpiar todo y empezar de nuevo
docker compose --profile production down
docker compose --profile production up -d --build
```

### Deployment en un Servidor con Docker

Si quieres deployar en un VPS (Virtual Private Server) como DigitalOcean, AWS EC2, o Linode:

#### 1. Requisitos del servidor
- Ubuntu 22.04 o similar
- Mínimo 2GB RAM
- Docker y Docker Compose instalados

#### 2. Preparar el servidor
```bash
# SSH al servidor
ssh tu-usuario@tu-servidor.com

# Instalar Docker (Ubuntu)
sudo apt update
sudo apt install docker.io docker-compose-v2 -y
sudo systemctl enable docker
sudo systemctl start docker

# Agregar tu usuario al grupo docker
sudo usermod -aG docker $USER
```

#### 3. Clonar el repositorio
```bash
git clone https://github.com/tu-usuario/tu-repo.git
cd tu-repo
```

#### 4. Configurar variables de entorno
```bash
cd infra
nano .env  # Editar con tus valores de producción
```

#### 5. Levantar el stack
```bash
docker compose --profile production up -d
```

#### 6. Configurar dominio y SSL (opcional)

Si tienes un dominio, puedes agregar Nginx como reverse proxy y usar Let's Encrypt para SSL:

```bash
# Instalar certbot
sudo apt install certbot python3-certbot-nginx -y

# Obtener certificado SSL
sudo certbot --nginx -d tu-dominio.com
```

### Comparación: Docker vs Deployment en la Nube

| Aspecto | Docker (VPS) | Nube (Vercel + Render) |
|---------|--------------|------------------------|
| **Costo** | ~$5-12/mes (VPS) | $0 (tier gratuito) |
| **Setup** | Más técnico | Más simple (click y listo) |
| **Control** | Control total | Limitado |
| **Escalabilidad** | Manual | Automática |
| **Mantenimiento** | Tú lo haces | Lo hace el proveedor |
| **Sleeping** | Nunca duerme | Backend duerme tras 15 min (Render free) |
| **Ideal para** | Producción real, proyecto grande | MVP, demo, evaluación académica |

---

## 🔗 Links Útiles

**Deployment en la Nube:**
- **Neon.tech**: https://neon.tech/docs/get-started-with-neon
- **Render**: https://render.com/docs/deploy-node-express-app
- **Upstash**: https://upstash.com/docs/redis/overall/getstarted
- **Vercel**: https://vercel.com/docs/frameworks/angular
- **Resend** (email): https://resend.com/docs/send-with-nodejs

**Docker:**
- **Docker Desktop**: https://www.docker.com/products/docker-desktop
- **Docker Compose**: https://docs.docker.com/compose/
- **Docker Hub**: https://hub.docker.com/

---

## 💡 Alternativas y Opciones Adicionales

### Opción 1: Otros servicios de deployment en la nube

**Railway** (crédito limitado)
- $5 de crédito gratis mensual
- PostgreSQL y Redis disponibles
- Buena integración con GitHub
- Pricing por uso después del crédito

**Fly.io** (tier gratuito limitado)
- 3 VMs pequeñas gratis
- PostgreSQL gratis (3GB)
- Más control que Vercel/Render
- Requiere más configuración

### Opción 2: Servidor VPS propio

**DigitalOcean Droplet** (~$6/mes)
- Control total del servidor
- Usa Docker para deployar
- Sin restricciones
- Requiere mantenimiento

**Linode/Vultr** (~$5/mes)
- Similar a DigitalOcean
- Buena relación precio/calidad
- Control total

---

**Proyecto:** The Garrison System | **Deployment:** 100% Gratuito
