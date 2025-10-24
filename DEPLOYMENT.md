# Guía de Deployment - TGS (100% GRATIS)

**Guía para desplegar The Garrison System completamente GRATIS** usando servicios con tier gratuito.

---

## 🎯 Arquitectura de Deployment Gratuito

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

## ⚠️ Consideraciones Importantes

### ¿Por qué PostgreSQL en lugar de MySQL?

**Tu proyecto usa MySQL**, pero los servicios gratuitos ofrecen PostgreSQL:

**Opciones:**
1. ✅ **Migrar a PostgreSQL** (Recomendado - 30 min de trabajo)
   - Neon.tech: PostgreSQL gratis con 3GB
   - Cambio mínimo en MikroORM (solo driver)
   - Compatible con todo tu código

2. ❌ **Mantener MySQL**
   - No hay opciones gratuitas confiables
   - PlanetScale eliminó tier gratuito
   - Railway/Render cobran por MySQL

### ¿Necesito .env.production?

**NO es estrictamente necesario** para deployment:
- Los servicios (Vercel, Render, etc.) tienen su propia configuración de variables de entorno
- `.env.production` es solo para Docker local en modo producción
- Para deploy real, configuras las variables en cada plataforma

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

## 🚀 Deployment Paso a Paso

### PASO 1: Migrar de MySQL a PostgreSQL

**¿Por qué?** Los servicios gratuitos no ofrecen MySQL.

**Cambios necesarios:**

#### A. Backend - Instalar driver PostgreSQL

```bash
cd apps/backend
pnpm add @mikro-orm/postgresql pg
pnpm remove @mikro-orm/mysql
```

#### B. Actualizar configuración MikroORM

**Archivo:** `apps/backend/src/config/mikro-orm.config.ts`

```typescript
// Antes (MySQL)
import { defineConfig } from '@mikro-orm/mysql';

// Después (PostgreSQL)
import { defineConfig } from '@mikro-orm/postgresql';

export default defineConfig({
  // ... resto de la config sin cambios
  type: 'postgresql', // Cambiar de 'mysql' a 'postgresql'
});
```

#### C. Variables de entorno

```env
# Antes (MySQL)
DB_HOST=localhost
DB_PORT=3307
DB_USER=dsw
DB_PASSWORD=dsw
DB_NAME=tpdesarrollo

# Después (PostgreSQL) - Neon.tech te dará esto
DATABASE_URL=postgresql://user:pass@ep-example.us-east-2.aws.neon.tech/tpdesarrollo?sslmode=require
```

**Nota:** El resto de tu código NO cambia. MikroORM es compatible con ambos.

---

### PASO 2: Database - Neon.tech (PostgreSQL Gratis)

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

### PASO 3: Redis - Upstash (Gratis)

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

### PASO 4: Backend - Render (Gratis)

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

### PASO 5: Frontend - Vercel (Gratis)

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

### PASO 6: Migración de Base de Datos

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

## 📝 Checklist de Deployment

- [ ] Migrar de MySQL a PostgreSQL en código
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

## 🎯 Tiempo Estimado

- Migración MySQL → PostgreSQL: **30 minutos**
- Setup de servicios (Neon, Upstash, Render, Vercel): **1 hora**
- Configuración y testing: **30 minutos**
- **TOTAL: 2 horas**

---

## 🔗 Links Útiles

- **Neon.tech**: https://neon.tech/docs/get-started-with-neon
- **Render**: https://render.com/docs/deploy-node-express-app
- **Upstash**: https://upstash.com/docs/redis/overall/getstarted
- **Vercel**: https://vercel.com/docs/frameworks/angular
- **Resend** (email): https://resend.com/docs/send-with-nodejs

---

## 💡 Alternativas

Si no quieres migrar a PostgreSQL:

### Opción 1: Mantener MySQL Local + Ngrok (Solo para Demo)
```bash
# Exponer tu MySQL local temporalmente
ngrok tcp 3307

# Usar la URL en Render (solo para demo, NO para producción)
```

### Opción 2: Railway (MySQL pero con crédito limitado)
- $5 de crédito gratis
- MySQL disponible
- Suficiente para ~2-3 semanas
- Bueno si necesitas MySQL urgente para presentar

---

**Proyecto:** The Garrison System | **Deployment:** 100% Gratuito
