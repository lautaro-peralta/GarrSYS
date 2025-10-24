# Git Submodules - Guía Completa

Esta guía explica cómo trabajar con los submódulos del proyecto TGS (Backend y Frontend).

---

## 📚 ¿Qué son los Submódulos?

Los submódulos de Git permiten incluir un repositorio dentro de otro. En TGS:
- `apps/backend` → Submódulo del repositorio TGS-Backend
- `apps/frontend` → Submódulo del repositorio TGS-Frontend

Cada submódulo apunta a un commit específico del repositorio externo.

---

## 🔍 Ver Estado de los Submódulos

### Ver en qué commit están los submódulos

```bash
# Desde la raíz del proyecto
git submodule status

# Output ejemplo:
# 5391272abc... apps/backend (detached)
# 4b86bd1xyz... apps/frontend (detached)
```

### Ver cambios en los submódulos

```bash
# Ver si hay cambios sin commitear en los submódulos
git status

# Ver detalles de cada submódulo
cd apps/backend
git status
git log --oneline -5  # Ver últimos 5 commits
```

---

## 🔄 Actualizar Submódulos a la Última Versión

### Método 1: Actualizar todos los submódulos (Recomendado)

```bash
# Desde la raíz del proyecto
git submodule update --remote --merge

# Esto:
# 1. Busca la última versión de la rama main/master de cada submódulo
# 2. Actualiza el submódulo a ese commit
# 3. Hace merge si hay cambios locales
```

### Método 2: Actualizar un submódulo específico

```bash
# Actualizar solo el backend
git submodule update --remote --merge apps/backend

# Actualizar solo el frontend
git submodule update --remote --merge apps/frontend
```

### Método 3: Manual (más control)

```bash
# 1. Ir al submódulo
cd apps/backend

# 2. Ver la rama actual
git branch

# 3. Hacer checkout a la rama principal
git checkout main  # o master, dependiendo del repo

# 4. Hacer pull de los últimos cambios
git pull origin main

# 5. Volver a la raíz
cd ../..

# 6. El proyecto principal ahora detecta que el submódulo cambió
git status
# Output: modified: apps/backend (new commits)
```

---

## 💾 Guardar Cambios en el Proyecto Principal

Cuando actualizas los submódulos, debes commitear esos cambios en el proyecto principal.

```bash
# 1. Ver qué submódulos cambiaron
git status

# Output ejemplo:
# modified: apps/backend (new commits)
# modified: apps/frontend (new commits)

# 2. Agregar los cambios de los submódulos
git add apps/backend apps/frontend

# O agregar todo
git add .

# 3. Commitear
git commit -m "Actualizo submódulos a última versión"

# 4. Push al proyecto principal
git push origin main
```

---

## 🔧 Hacer Cambios en un Submódulo

### Escenario: Necesitas modificar código en el backend

```bash
# 1. Ir al submódulo
cd apps/backend

# 2. Crear una rama (¡IMPORTANTE! No trabajes en detached HEAD)
git checkout main
git pull origin main
git checkout -b feature/nueva-funcionalidad

# 3. Hacer cambios en el código
# ... editar archivos ...

# 4. Commitear en el submódulo
git add .
git commit -m "Agrego nueva funcionalidad"

# 5. Push del submódulo a SU repositorio
git push origin feature/nueva-funcionalidad

# 6. (Opcional) Hacer merge/PR en GitHub del submódulo
# ... crear PR en GitHub de TGS-Backend ...

# 7. Volver a la raíz del proyecto principal
cd ../..

# 8. Actualizar el proyecto principal para que apunte al nuevo commit
git add apps/backend
git commit -m "Actualizo backend con nueva funcionalidad"
git push origin main
```

---

## ⚠️ Solución al Problema "Detached HEAD"

Tus submódulos están en "detached HEAD" (5391272, 4b86bd1). Esto significa que no están en ninguna rama.

### ¿Por qué pasa esto?

Los submódulos por defecto apuntan a un commit específico, no a una rama.

### Cómo solucionarlo:

```bash
# 1. Backend
cd apps/backend
git checkout main  # o master
git pull origin main
cd ../..

# 2. Frontend
cd apps/frontend
git checkout main  # o master
git pull origin main
cd ../..

# 3. Guardar los cambios en el proyecto principal
git add .
git commit -m "Actualizo submódulos a última versión"
git push origin main
```

---

## 📋 Workflow Completo Recomendado

### Para actualizar submódulos y hacer cambios:

```bash
# ============================================================================
# PASO 1: Actualizar submódulos a última versión
# ============================================================================
cd apps/backend
git checkout main
git pull origin main
cd ../..

cd apps/frontend
git checkout main
git pull origin main
cd ../..

# ============================================================================
# PASO 2: Hacer cambios en el proyecto principal (docker-compose, README, etc.)
# ============================================================================
# ... editar archivos del proyecto principal ...

git add .
git commit -m "Actualizo configuración de PostgreSQL"

# ============================================================================
# PASO 3: Commitear que los submódulos están actualizados
# ============================================================================
git add apps/backend apps/frontend
git commit -m "Actualizo submódulos a última versión"

# ============================================================================
# PASO 4: Push de todo
# ============================================================================
git push origin main
```

---

## 🚨 Errores Comunes

### Error: "Please commit your changes or stash them"

```bash
# Hay cambios sin commitear en el submódulo
cd apps/backend
git status

# Opción 1: Commitear los cambios
git add .
git commit -m "Descripción de cambios"

# Opción 2: Guardar temporalmente (stash)
git stash

# Opción 3: Descartar cambios (¡CUIDADO!)
git reset --hard HEAD
```

### Error: "fatal: not a git repository"

```bash
# El submódulo no está inicializado
git submodule update --init --recursive
```

### Submódulos vacíos después de clonar

```bash
# Inicializar y actualizar submódulos
git submodule update --init --recursive
```

---

## 🎯 Comandos Útiles de Referencia Rápida

```bash
# Ver estado de submódulos
git submodule status

# Actualizar todos los submódulos a última versión
git submodule update --remote --merge

# Ejecutar comando en todos los submódulos
git submodule foreach 'git checkout main && git pull'

# Ver diferencias de commits en submódulos
git diff --submodule

# Clonar proyecto con submódulos
git clone --recurse-submodules <repo-url>

# Si ya clonaste sin --recurse-submodules
git submodule update --init --recursive
```

---

## 📊 Flujo Visual

```
Proyecto Principal (TP-Desarrollo-de-Software)
├── apps/backend (Submódulo → TGS-Backend repo)
│   ├── Apunta a commit: 5391272
│   └── Rama actual: detached HEAD ❌
│
└── apps/frontend (Submódulo → TGS-Frontend repo)
    ├── Apunta a commit: 4b86bd1
    └── Rama actual: detached HEAD ❌

Después de actualizar:

Proyecto Principal (TP-Desarrollo-de-Software)
├── apps/backend (Submódulo → TGS-Backend repo)
│   ├── Apunta a commit: abc1234 (último commit de main)
│   └── Rama actual: main ✅
│
└── apps/frontend (Submódulo → TGS-Frontend repo)
    ├── Apunta a commit: def5678 (último commit de main)
    └── Rama actual: main ✅
```

---

## ✅ Checklist para tu Situación Actual

Basado en el estado de tu proyecto:

- [ ] **Paso 1:** Actualizar backend a main
  ```bash
  cd apps/backend
  git checkout main
  git pull origin main
  cd ../..
  ```

- [ ] **Paso 2:** Actualizar frontend a main
  ```bash
  cd apps/frontend
  git checkout main
  git pull origin main
  cd ../..
  ```

- [ ] **Paso 3:** Commitear cambios del proyecto principal (ya hicimos los fixes de migración)
  ```bash
  git add .
  git commit -m "Fix: Migración completa de MySQL a PostgreSQL

  - Actualiza docker-compose.yml para usar PostgreSQL
  - Remueve servicio MySQL
  - Actualiza Makefile y README.md
  - Actualiza submódulos a última versión"
  ```

- [ ] **Paso 4:** Push de todo
  ```bash
  git push origin main
  ```

---

**Proyecto:** The Garrison System | **Guía de Submódulos**
