# The Garrison System (TGS)

**Trabajo Práctico - Desarrollo de Software**

**UTN FRRo - Grupo Shelby**

---

The Garrison System es un sistema de ventas y gestión de recursos ambientado en el Birmingham de los años 1920. Simula una red comercial con elementos de riesgo, corrupción y toma de decisiones estratégicas, inspirado en la serie _Peaky Blinders_.

---

## 📋 Contenidos

- [Sobre este Proyecto](#sobre-este-proyecto)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Tecnologías](#tecnologías)
- [Instalación](#instalación)
- [Ejecución](#ejecución)
- [Cargar Datos de Prueba](#cargar-datos-de-prueba)
- [Documentación](#documentación)
- [Equipo](#equipo)

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
│   ├── docker-compose.yml    → MySQL y Redis
│   └── init-test-data.sql    → Datos de prueba
├── scripts/
│   └── load-test-data.sh/.bat → Script para cargar datos
└── Makefile                  → Comandos simplificados
```

---

## Tecnologías

**Backend:** Node.js 18+ | TypeScript | Express.js | MikroORM | MySQL 8.0 | Redis | JWT

**Frontend:** Angular 18+ | TypeScript | SCSS

**Infraestructura:** Docker | Docker Compose | Git (submódulos)

---

## Instalación

**Requisitos:** Node.js 18+, pnpm, Docker, Git

```bash
# 1. Clonar con submódulos
git clone --recurse-submodules https://github.com/Lau-prog/TP-Desarrollo-de-Software.git
cd TP-Desarrollo-de-Software

# 2. Levantar Docker
cd infra
docker-compose up -d

# 3. Backend
cd ../apps/backend
pnpm install
cp .env.example .env.development
# Editar .env.development con tus configuraciones

# 4. Frontend
cd ../apps/frontend
pnpm install
```

---

## Ejecución

**Backend:**
```bash
cd apps/backend
pnpm dev    # Modo desarrollo (requiere Mailtrap)
pnpm demo   # Modo demo (acepta cualquier código de verificación)
```

**Frontend:**
```bash
cd apps/frontend
pnpm start
```

- Backend: http://localhost:3000
- Frontend: http://localhost:4200

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

## Equipo

**Grupo Shelby - UTN FRRo**

| Nombre | Legajo | GitHub |
|--------|--------|--------|
| Peralta, Lautaro Martín | 53483 | [@lautaro-peralta](https://github.com/lautaro-peralta) |
| Delprato, Luca | 50215 | [@LucaDelpra](https://github.com/LucaDelpra) |
| Splivalo, Tomas | 51665 | [@Tsplivalo](https://github.com/Tsplivalo) |

---

## 🔗 Repositorios

- **Principal:** [lautaro-peralta/TP-Desarrollo-de-Software](https://github.com/Lau-prog/TP-Desarrollo-de-Software)
- **Backend:** [lautaro-peralta/TGS-Backend](https://github.com/lautaro-peralta/TGS-Backend)
- **Frontend:** [Tsplivalo/TGS-Frontend](https://github.com/Tsplivalo/TGS-Frontend)

---

**Materia:** Desarrollo de Software | **Universidad:** UTN FRRo | **Año:** 2025
