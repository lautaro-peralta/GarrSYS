# The Garrison System (TGS)

**Trabajo Práctico - Desarrollo de Software**

**UTN FRRo - Grupo Shelby**

---

The Garrison System es un sistema de ventas y gestión de recursos ambientado en el Birmingham de los años 1920. Simula una red comercial con elementos de riesgo, corrupción y toma de decisiones estratégicas, inspirado en la serie _Peaky Blinders_.

---

## 📋 Contenidos

- [The Garrison System (TGS)](#the-garrison-system-tgs)
  - [📋 Contenidos](#-contenidos)
  - [Sobre este Proyecto](#sobre-este-proyecto)
  - [📦 Estructura del Proyecto](#-estructura-del-proyecto)
  - [🧪 Tecnologías](#-tecnologías)
  - [🚀 Instalación](#-instalación)
    - [1. Clonar con submódulos](#1-clonar-con-submódulos)
    - [2. Levantar infraestructura](#2-levantar-infraestructura)
    - [3. Configurar Backend](#3-configurar-backend)
    - [4. Configurar Frontend](#4-configurar-frontend)
  - [▶️ Ejecución](#️-ejecución)
  - [📄 Documentación](#-documentación)
    - [Documentación del Proyecto](#documentación-del-proyecto)
    - [Documentación de API](#documentación-de-api)
    - [Más información](#más-información)
  - [👥 Equipo](#-equipo)
  - [🔗 Repositorios](#-repositorios)

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

## 📦 Estructura del Proyecto

```
TP-Desarrollo-de-Software/
│
├── apps/
│   ├── backend/              → Submódulo: API REST (Node.js + TypeScript + MikroORM)
│   └── frontend/             → Submódulo: SPA (Angular + TypeScript)
│
├── docs/                     → Documentación del proyecto
│   ├── minutas_individuales/ → Minutas de trabajo individual
│   ├── minutas_reuniones/    → Minutas de reuniones grupales
│   └── proposal.md           → Propuesta del proyecto (alcance funcional)
│
├── infra/
│   ├── docker-compose.yml    → Servicios: MySQL y Redis
│   └── mysql-data/           → Volumen persistente de base de datos
│
├── .gitignore
├── .gitmodules               → Configuración de submódulos
└── README.md                 → Este archivo
```

---

## 🧪 Tecnologías

**Backend:** Node.js 18+ | TypeScript | Express.js | MikroORM | MySQL 8.0 | Redis | JWT

**Frontend:** Angular 18+ | TypeScript | SCSS

**Infraestructura:** Docker | Docker Compose | Git (submódulos)

---

## 🚀 Instalación

**Requisitos:** Node.js 18+, pnpm, Docker, Git

### 1. Clonar con submódulos

```bash
git clone --recurse-submodules https://github.com/Lau-prog/TP-Desarrollo-de-Software.git
cd TP-Desarrollo-de-Software
```

Si ya clonaste sin submódulos: `git submodule update --init --recursive`

### 2. Levantar infraestructura

```bash
cd infra
docker-compose up -d
```

Esto levanta MySQL (puerto 3307) y Redis (puerto 6379).

### 3. Configurar Backend

```bash
cd ../apps/backend
pnpm install
cp .env.example .env.development
```

Editá `.env.development` con tus configuraciones.

### 4. Configurar Frontend

```bash
cd ../frontend
pnpm install
```

---

## ▶️ Ejecución

**Backend** (Terminal 1):
```bash
cd apps/backend
pnpm dev        # Modo desarrollo (requiere Mailtrap configurado en .env)
# o
pnpm demo       # Modo demo (acepta cualquier código de verificación)
```

> **Modo desarrollo:** Los emails se envían a [Mailtrap](https://mailtrap.io/). Para verificar funciones de email, el evaluador debe acceder a la bandeja de Mailtrap con las credenciales proporcionadas.
>
> **Modo demo:** Ideal para evaluación académica. Acepta cualquier código de verificación sin necesidad de acceder a Mailtrap.

Backend disponible en `http://localhost:3000`

**Frontend** (Terminal 2):
```bash
cd apps/frontend
pnpm start
```

Frontend disponible en `http://localhost:4200`

---

## 📄 Documentación

### Documentación del Proyecto
- **[Propuesta del Proyecto](docs/proposal.md)** - Alcance funcional, CRUDs y CUUs
- **[Minutas de Reuniones](docs/minutas_reuniones/)** - Registro de avances grupales
- **[Minutas Individuales](docs/minutas_individuales/)** - Registro de trabajo individual

### Documentación de API
- **[Swagger/OpenAPI](docs/SWAGGER_SETUP.md)** - Documentación interactiva de la API
- **Swagger UI:** http://localhost:3000/api-docs (con el backend corriendo)
- **[Ejemplos de código](docs/swagger-examples/)** - Ejemplos de uso de la API

### Más información
- [README del Backend](apps/backend/README.md) - Arquitectura, endpoints, base de datos
- [README del Frontend](apps/frontend/README.md) - Componentes, servicios, routing

---

## 👥 Equipo

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
