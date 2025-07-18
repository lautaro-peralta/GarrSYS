# The Garrison System

The Garrison System es un sistema para gestionar recursos y decisiones estratégicas, inspirado en la serie _Peaky Blinders_, aunque realmente podria funcionar para cualquier organización similar.

# Sobre este repo

Este repositorio general contiene la estructura principal del Trabajo Práctico de la materia **Desarrollo de Software**, organizado con submódulos de Git para separar las aplicaciones de frontend y backend, así como una carpeta de documentación.

## 📦 Estructura del Proyecto

```
TP-Desarrollo-de-Software/
│
├── apps/
│   ├── backend/          → Submódulo que contiene la API (Node.js + MikroORM + MySQL)
│   └── frontend/         → Submódulo que contiene la interfaz de usuario (Angular)
├── docs/                 → Documentación técnica, minutas, propuestas, etc.
├── .gitignore
├── .gitmodules           → Configuración de submódulos
├── infra/
|   └──docker-compose.yml    → Definición de servicios para entorno local
├── proposal.md           → Propuesta inicial del proyecto
└── README.md             → Este archivo
```

## 🚀 Cómo empezar

1. Clonar el repositorio con submódulos:

```bash
git clone --recurse-submodules https://github.com/Lau-prog/TP-Desarrollo-de-Software.git
```

2. En caso de ya haber clonado sin los submódulos:

```bash
git submodule update --init --recursive
```

3. Acceder a las carpetas `apps/frontend` y `apps/backend` para trabajar en cada módulo.

## 🐳 Docker

Podés levantar los servicios con:

```bash
docker-compose up -d
```

Este archivo define contenedores para la base de datos MySQL y puede ser extendido para contener los servidores del frontend y backend en el futuro.

## 🧪 Tecnologías utilizadas

- **Frontend:** Angular – ver submódulo `frontend`
- **Backend:** Node.js + TypeScript + MikroORM + MySQL – ver submódulo `backend`
- **Base de Datos:** MySQL (vía Docker)
- **Control de versiones:** Git + Submódulos

## 📄 Documentación

Todos los documentos relevantes al desarrollo se encuentran en la carpeta `docs/`, incluyendo:

- Minutas de reuniones
- Propuesta inicial del proyecto
- Documentos técnicos

## 👥 Autores

- Lautaro (@Lau-prog)
- Tomas (@Tsplivalo)
- Luca (@LucaDelpra)

---

**Nota:** Este repositorio usa submódulos para mantener una separación clara entre frontend, backend y documentación. Asegurate de clonar y actualizar correctamente los submódulos para evitar errores.
