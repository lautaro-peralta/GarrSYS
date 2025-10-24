# Extensiones Recomendadas para VSCode - TGS

Esta guía lista todas las extensiones recomendadas para trabajar en The Garrison System.

---

## 📦 Instalación Automática

El proyecto incluye un archivo `.vscode/extensions.json` con todas las extensiones recomendadas.

**Cuando abras el proyecto en VSCode:**
1. Verás una notificación: "Do you want to install the recommended extensions?"
2. Click en **"Install All"**
3. ¡Listo! Todas las extensiones se instalan automáticamente

**O manualmente:**
- `Ctrl+Shift+P` → "Extensions: Show Recommended Extensions"
- Click en el ícono de nube para instalar todas

---

## 🔧 Extensiones Esenciales

### Backend (Node.js + TypeScript + Express)

| Extensión | ID | Propósito |
|-----------|----|-----------|
| **ESLint** | `dbaeumer.vscode-eslint` | Linting para TypeScript/JavaScript - detecta errores |
| **Prettier** | `esbenp.prettier-vscode` | Formateo automático de código |
| **Error Lens** | `usernamehm.errorlens` | Muestra errores inline en el código |
| **Path Intellisense** | `christian-kohler.path-intellisense` | Autocompletado de rutas de archivos |
| **npm Intellisense** | `christian-kohler.npm-intellisense` | Autocompletado de imports de npm |

### Frontend (Angular + TypeScript + SCSS)

| Extensión | ID | Propósito |
|-----------|----|-----------|
| **Angular Language Service** | `Angular.ng-template` | ⚠️ **ESENCIAL** - Autocompletado y errores en templates |
| **Angular Snippets** | `johnpapa.Angular2` | Snippets para componentes, servicios, etc. |
| **Auto Rename Tag** | `formulahendry.auto-rename-tag` | Renombra tags HTML automáticamente |
| **SCSS IntelliSense** | `mrmlnc.vscode-scss` | Autocompletado para SCSS variables/mixins |

### Base de Datos

| Extensión | ID | Propósito |
|-----------|----|-----------|
| **Database Client** | `cweijan.vscode-database-client2` | Cliente para MySQL, PostgreSQL, Redis - todo en uno |

**Alternativas:**
- **MySQL** (`cweijan.vscode-mysql-client2`) - Solo MySQL
- **PostgreSQL** (`ckolkman.vscode-postgres`) - Solo PostgreSQL

### Docker

| Extensión | ID | Propósito |
|-----------|----|-----------|
| **Docker** | `ms-azuretools.vscode-docker` | Gestionar contenedores, ver logs, Dockerfile syntax |
| **Dev Containers** | `ms-vscode-remote.remote-containers` | Desarrollar dentro de contenedores |

---

## 🎨 Productividad

| Extensión | ID | Propósito |
|-----------|----|-----------|
| **GitLens** | `eamodio.gitlens` | Git superpoderoso - ver quién cambió qué, cuándo |
| **Git Graph** | `mhutchie.git-graph` | Visualización de ramas y commits |
| **Better Comments** | `aaron-bond.better-comments` | Colorea comentarios (TODO, FIXME, etc.) |
| **indent-rainbow** | `oderwat.indent-rainbow` | Colorea niveles de indentación |
| **Todo Tree** | `Gruntfuggly.todo-tree` | Vista de todos los TODOs del proyecto |
| **Material Icon Theme** | `PKief.material-icon-theme` | Iconos bonitos para archivos y carpetas |

---

## ✅ Calidad de Código

| Extensión | ID | Propósito |
|-----------|----|-----------|
| **SonarLint** | `SonarSource.sonarlint-vscode` | Detecta bugs, code smells, vulnerabilidades |
| **EditorConfig** | `EditorConfig.EditorConfig` | Estilo de código consistente en todo el equipo |
| **Code Spell Checker** | `streetsidesoftware.code-spell-checker` | Corrector ortográfico para código |

---

## 🛠️ Desarrollo y Testing

| Extensión | ID | Propósito |
|-----------|----|-----------|
| **Thunder Client** | `rangav.vscode-thunder-client` | Cliente REST para testear API (alternativa a Postman) |
| **REST Client** | `humao.rest-client` | Testear endpoints desde archivos `.http` |
| **Live Share** | `ms-vsliveshare.vsliveshare` | Colaboración en tiempo real con el equipo |

---

## 📝 Markdown (Documentación)

| Extensión | ID | Propósito |
|-----------|----|-----------|
| **Markdown All in One** | `yzhang.markdown-all-in-one` | Atajos, preview, table of contents |
| **Markdown Preview Enhanced** | `shd101wyy.markdown-preview-enhanced` | Preview mejorado, export a PDF/HTML |

---

## 🚀 Instalación Manual

Si prefieres instalar manualmente:

### Opción 1: Desde VSCode
1. `Ctrl+Shift+X` (abrir extensiones)
2. Buscar por ID (ejemplo: `dbaeumer.vscode-eslint`)
3. Click "Install"

### Opción 2: Desde terminal
```bash
# Backend
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension usernamehm.errorlens
code --install-extension christian-kohler.path-intellisense
code --install-extension christian-kohler.npm-intellisense

# Frontend
code --install-extension Angular.ng-template
code --install-extension johnpapa.Angular2
code --install-extension formulahendry.auto-rename-tag
code --install-extension mrmlnc.vscode-scss

# Database
code --install-extension cweijan.vscode-database-client2

# Docker
code --install-extension ms-azuretools.vscode-docker

# Git
code --install-extension eamodio.gitlens
code --install-extension mhutchie.git-graph

# Productividad
code --install-extension aaron-bond.better-comments
code --install-extension oderwat.indent-rainbow
code --install-extension Gruntfuggly.todo-tree
code --install-extension PKief.material-icon-theme

# Calidad
code --install-extension SonarSource.sonarlint-vscode
code --install-extension EditorConfig.EditorConfig
code --install-extension streetsidesoftware.code-spell-checker

# Markdown
code --install-extension yzhang.markdown-all-in-one
```

---

## ⚙️ Configuración Recomendada

El proyecto incluye `.vscode/settings.json` con configuración óptima:

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "typescript.updateImportsOnFileMove.enabled": "always",
  "files.autoSave": "onFocusChange",
  "editor.bracketPairColorization.enabled": true,
  "files.trimTrailingWhitespace": true
}
```

Estas configuraciones:
- ✅ Formatean código automáticamente al guardar
- ✅ Actualizan imports al mover archivos
- ✅ Auto-guardan archivos
- ✅ Colorizan brackets
- ✅ Eliminan espacios en blanco

---

## 📋 Checklist de Instalación

Después de instalar extensiones, verifica:

- [ ] ESLint muestra errores en archivos `.ts`
- [ ] Prettier formatea al guardar (`Ctrl+S`)
- [ ] Angular Language Service autocompleta en templates HTML
- [ ] GitLens muestra información de Git inline
- [ ] Database Client puede conectarse a MySQL/PostgreSQL
- [ ] Docker extension muestra tus contenedores
- [ ] Material Icons se ven en el explorador de archivos

---

## 🆘 Troubleshooting

### ESLint no funciona
```bash
# Recargar VSCode
Ctrl+Shift+P → "Developer: Reload Window"

# O reinstalar
npm install -g eslint
```

### Prettier no formatea
1. `Ctrl+Shift+P` → "Format Document With..."
2. Seleccionar "Prettier"
3. Marcar "Configure Default Formatter"

### Angular Language Service no autocompleta
1. `Ctrl+Shift+P` → "TypeScript: Restart TS Server"
2. Verificar que estés en un archivo `.html` de un componente Angular

### Database Client no conecta
1. Verificar que Docker esté corriendo: `docker compose ps`
2. Credenciales correctas:
   - Host: `localhost`
   - Port: `3307` (MySQL) o `5432` (PostgreSQL)
   - User/Pass según `.env.development`

---

## 🎯 Extensiones por Rol

### Si trabajas principalmente en Backend:
**Esenciales:**
- ESLint
- Prettier
- Error Lens
- Database Client
- Docker
- Thunder Client

### Si trabajas principalmente en Frontend:
**Esenciales:**
- Angular Language Service ⚠️
- Angular Snippets
- ESLint
- Prettier
- Auto Rename Tag
- SCSS IntelliSense

### Si trabajas en ambos:
**Instalar todas las esenciales** de Backend + Frontend

---

## 📚 Recursos

- [VSCode Extension Marketplace](https://marketplace.visualstudio.com/vscode)
- [VSCode Docs - Extensions](https://code.visualstudio.com/docs/editor/extension-marketplace)
- [Prettier Config](https://prettier.io/docs/en/configuration.html)
- [ESLint Config](https://eslint.org/docs/latest/use/configure/)

---

## 💡 Tips

**Sincronizar extensiones entre equipos:**
- El archivo `.vscode/extensions.json` está en Git
- Todos los miembros del equipo recibirán las mismas recomendaciones

**Actualizar extensiones:**
- `Ctrl+Shift+X` → Click en ⚙️ → "Check for Updates"
- O desde terminal: `code --update-extensions`

**Desactivar extensiones temporalmente:**
- Útil si alguna extensión causa problemas
- Click derecho en la extensión → "Disable"

---

**Proyecto:** The Garrison System | **UTN FRRo**
