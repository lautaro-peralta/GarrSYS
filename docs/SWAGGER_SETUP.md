# Guía de Implementación de Swagger/OpenAPI

Esta guía te ayudará a implementar documentación interactiva de la API usando Swagger/OpenAPI en el backend.

---

## 📋 ¿Qué es Swagger/OpenAPI?

**OpenAPI** (antes Swagger) es un estándar para documentar APIs REST que genera:
- 📚 Documentación interactiva y visual
- 🧪 Interfaz para probar endpoints directamente
- 📝 Especificación formal de la API
- 🔄 Sincronización automática con el código

## 🎯 Resultado Final

Una vez implementado, tendrás acceso a:

```
http://localhost:3000/api-docs
```

Donde verás una interfaz web profesional con:
- Listado de todos los endpoints
- Parámetros requeridos/opcionales
- Schemas de request/response
- Botón "Try it out" para probar cada endpoint
- Autenticación JWT integrada

---

## 🚀 Implementación Paso a Paso

### Paso 1: Instalar Dependencias

```bash
cd apps/backend
pnpm add swagger-jsdoc swagger-ui-express
pnpm add -D @types/swagger-jsdoc @types/swagger-ui-express
```

### Paso 2: Crear Configuración de Swagger

Crear archivo `src/config/swagger.config.ts`:

```typescript
import swaggerJsdoc from 'swagger-jsdoc';
import { SwaggerDefinition } from 'swagger-jsdoc';

const swaggerDefinition: SwaggerDefinition = {
  openapi: '3.0.0',
  info: {
    title: 'The Garrison System API',
    version: '1.0.0',
    description: `
      API REST para The Garrison System - Sistema de ventas y gestión de recursos
      ambientado en el Birmingham de los años 1920.

      ## Autenticación
      La mayoría de los endpoints requieren autenticación JWT. Usa el endpoint
      \`/api/auth/login\` para obtener un token y luego inclúyelo en el header:
      \`Authorization: Bearer <token>\`
    `,
    contact: {
      name: 'Grupo Shelby',
      url: 'https://github.com/Lau-prog/TP-Desarrollo-de-Software',
    },
    license: {
      name: 'MIT',
      url: 'https://opensource.org/licenses/MIT',
    },
  },
  servers: [
    {
      url: 'http://localhost:3000',
      description: 'Servidor de Desarrollo',
    },
    {
      url: 'https://api.tgs.com',
      description: 'Servidor de Producción',
    },
  ],
  components: {
    securitySchemes: {
      bearerAuth: {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        description: 'Ingresa tu JWT token',
      },
    },
    schemas: {
      Error: {
        type: 'object',
        properties: {
          success: {
            type: 'boolean',
            example: false,
          },
          error: {
            type: 'object',
            properties: {
              code: {
                type: 'string',
                example: 'VALIDATION_ERROR',
              },
              message: {
                type: 'string',
                example: 'Error de validación',
              },
              details: {
                type: 'array',
                items: {
                  type: 'object',
                },
              },
            },
          },
        },
      },
    },
  },
  tags: [
    {
      name: 'Auth',
      description: 'Autenticación y autorización',
    },
    {
      name: 'Products',
      description: 'Gestión de productos (legales e ilegales)',
    },
    {
      name: 'Clients',
      description: 'Gestión de clientes',
    },
    {
      name: 'Sales',
      description: 'Gestión de ventas',
    },
    {
      name: 'Partners',
      description: 'Gestión de socios',
    },
    {
      name: 'Zones',
      description: 'Gestión de zonas',
    },
    {
      name: 'Bribes',
      description: 'Gestión de sobornos',
    },
    {
      name: 'Strategic Decisions',
      description: 'Decisiones estratégicas del Consejo Shelby',
    },
  ],
};

const options: swaggerJsdoc.Options = {
  definition: swaggerDefinition,
  // Rutas donde están tus archivos con anotaciones
  apis: [
    './src/modules/**/*.routes.ts',
    './src/modules/**/*.controller.ts',
    './src/shared/**/*.ts',
  ],
};

export const swaggerSpec = swaggerJsdoc(options);
```

### Paso 3: Integrar en la Aplicación

En tu archivo principal `src/index.ts` o `src/app.ts`:

```typescript
import express from 'express';
import swaggerUi from 'swagger-ui-express';
import { swaggerSpec } from './config/swagger.config';

const app = express();

// ... otros middlewares ...

// Swagger UI
app.use('/api-docs', swaggerUi.serve);
app.get('/api-docs', swaggerUi.setup(swaggerSpec, {
  customSiteTitle: 'TGS API Docs',
  customfavIcon: '/favicon.ico',
  customCss: '.swagger-ui .topbar { display: none }',
}));

// Endpoint para obtener la especificación JSON
app.get('/api-docs.json', (req, res) => {
  res.setHeader('Content-Type', 'application/json');
  res.send(swaggerSpec);
});

// ... resto de tu aplicación ...
```

### Paso 4: Documentar Endpoints

Ahora documenta tus endpoints usando comentarios JSDoc. Aquí están los ejemplos:

#### Ejemplo 1: Login (POST)

```typescript
/**
 * @openapi
 * /api/auth/login:
 *   post:
 *     tags:
 *       - Auth
 *     summary: Iniciar sesión
 *     description: Autentica un usuario y retorna un JWT token
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 format: email
 *                 example: admin@tgs.com
 *               password:
 *                 type: string
 *                 format: password
 *                 example: Admin123!
 *     responses:
 *       200:
 *         description: Login exitoso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 data:
 *                   type: object
 *                   properties:
 *                     token:
 *                       type: string
 *                       example: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
 *                     user:
 *                       type: object
 *                       properties:
 *                         id:
 *                           type: number
 *                           example: 1
 *                         email:
 *                           type: string
 *                           example: admin@tgs.com
 *                         role:
 *                           type: string
 *                           example: admin
 *       401:
 *         description: Credenciales inválidas
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.post('/login', authController.login);
```

#### Ejemplo 2: Listar Productos (GET con autenticación)

```typescript
/**
 * @openapi
 * /api/products:
 *   get:
 *     tags:
 *       - Products
 *     summary: Listar todos los productos
 *     description: Retorna una lista de todos los productos (legales e ilegales)
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: type
 *         schema:
 *           type: string
 *           enum: [legal, illegal]
 *         description: Filtrar por tipo de producto
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           minimum: 1
 *           default: 1
 *         description: Número de página
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           minimum: 1
 *           maximum: 100
 *           default: 10
 *         description: Elementos por página
 *     responses:
 *       200:
 *         description: Lista de productos
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: number
 *                       name:
 *                         type: string
 *                       price:
 *                         type: number
 *                       type:
 *                         type: string
 *                         enum: [legal, illegal]
 *       401:
 *         description: No autenticado
 *       403:
 *         description: No autorizado
 */
router.get('/', authMiddleware, productController.getAll);
```

#### Ejemplo 3: Crear Producto (POST con autenticación)

```typescript
/**
 * @openapi
 * /api/products:
 *   post:
 *     tags:
 *       - Products
 *     summary: Crear un nuevo producto
 *     description: Crea un nuevo producto (legal o ilegal). Solo admins.
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - price
 *               - type
 *             properties:
 *               name:
 *                 type: string
 *                 example: Whisky Irlandés
 *               description:
 *                 type: string
 *                 example: Whisky de contrabando de Irlanda
 *               price:
 *                 type: number
 *                 example: 150.00
 *               type:
 *                 type: string
 *                 enum: [legal, illegal]
 *                 example: illegal
 *               stock:
 *                 type: number
 *                 example: 50
 *     responses:
 *       201:
 *         description: Producto creado exitosamente
 *       400:
 *         description: Error de validación
 *       401:
 *         description: No autenticado
 *       403:
 *         description: No autorizado (requiere rol admin)
 */
router.post('/', authMiddleware, roleMiddleware(['admin']), productController.create);
```

#### Ejemplo 4: Obtener por ID (GET con parámetro)

```typescript
/**
 * @openapi
 * /api/products/{id}:
 *   get:
 *     tags:
 *       - Products
 *     summary: Obtener producto por ID
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID del producto
 *     responses:
 *       200:
 *         description: Producto encontrado
 *       404:
 *         description: Producto no encontrado
 */
router.get('/:id', authMiddleware, productController.getById);
```

#### Ejemplo 5: Actualizar (PUT)

```typescript
/**
 * @openapi
 * /api/products/{id}:
 *   put:
 *     tags:
 *       - Products
 *     summary: Actualizar producto
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *               price:
 *                 type: number
 *               stock:
 *                 type: number
 *     responses:
 *       200:
 *         description: Producto actualizado
 *       404:
 *         description: Producto no encontrado
 */
router.put('/:id', authMiddleware, roleMiddleware(['admin']), productController.update);
```

#### Ejemplo 6: Eliminar (DELETE)

```typescript
/**
 * @openapi
 * /api/products/{id}:
 *   delete:
 *     tags:
 *       - Products
 *     summary: Eliminar producto
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Producto eliminado
 *       404:
 *         description: Producto no encontrado
 */
router.delete('/:id', authMiddleware, roleMiddleware(['admin']), productController.delete);
```

---

## 🧪 Probando la Documentación

### 1. Iniciar el servidor

```bash
pnpm dev
```

### 2. Acceder a la documentación

Abre en tu navegador:
```
http://localhost:3000/api-docs
```

### 3. Autenticarse para probar endpoints protegidos

1. Busca el endpoint `POST /api/auth/login`
2. Haz click en "Try it out"
3. Ingresa credenciales:
   ```json
   {
     "email": "admin@tgs.com",
     "password": "Admin123!"
   }
   ```
4. Copia el token de la respuesta
5. Haz click en el botón "Authorize" 🔒 arriba a la derecha
6. Pega el token (sin "Bearer ", solo el token)
7. Ahora podrás probar endpoints protegidos

---

## 📝 Schemas Reutilizables

Para evitar duplicación, define schemas comunes en `src/config/swagger.schemas.ts`:

```typescript
/**
 * @openapi
 * components:
 *   schemas:
 *     Product:
 *       type: object
 *       properties:
 *         id:
 *           type: number
 *         name:
 *           type: string
 *         price:
 *           type: number
 *         type:
 *           type: string
 *           enum: [legal, illegal]
 *         createdAt:
 *           type: string
 *           format: date-time
 */

/**
 * @openapi
 * components:
 *   schemas:
 *     Client:
 *       type: object
 *       properties:
 *         id:
 *           type: number
 *         name:
 *           type: string
 *         email:
 *           type: string
 */
```

Luego referéncialos:

```typescript
/**
 * @openapi
 * /api/products:
 *   get:
 *     responses:
 *       200:
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Product'
 */
```

---

## 🎨 Personalización

### CSS Personalizado

```typescript
const customCss = `
  .swagger-ui .topbar { display: none }
  .swagger-ui .info { margin: 50px 0 }
  .swagger-ui .info .title { color: #1a1a1a }
`;

app.use('/api-docs', swaggerUi.serve);
app.get('/api-docs', swaggerUi.setup(swaggerSpec, {
  customCss,
  customSiteTitle: 'TGS API Documentation',
}));
```

---

## ✅ Checklist de Implementación

- [ ] Instalar dependencias (`swagger-jsdoc`, `swagger-ui-express`)
- [ ] Crear `src/config/swagger.config.ts`
- [ ] Integrar en `src/index.ts`
- [ ] Documentar endpoints de Auth
- [ ] Documentar endpoints de Products
- [ ] Documentar endpoints de Clients
- [ ] Documentar endpoints de Sales
- [ ] Documentar endpoints de Partners
- [ ] Documentar endpoints adicionales
- [ ] Probar todos los endpoints desde Swagger UI
- [ ] Agregar a README.md la URL de documentación
- [ ] (Opcional) Exportar especificación JSON para compartir

---

## 📤 Para la Entrega

Una vez implementado:

1. **Incluye la URL en el README:**
   ```markdown
   ## 📚 Documentación de API

   - **Swagger UI:** http://localhost:3000/api-docs
   - **OpenAPI Spec:** http://localhost:3000/api-docs.json
   ```

2. **Screenshots para la defensa:**
   - Captura de pantalla de Swagger UI
   - Captura probando un endpoint con "Try it out"

3. **En la defensa:**
   - Muestra la documentación interactiva
   - Demuestra cómo probar endpoints
   - Explica la autenticación JWT integrada

---

## 🔗 Recursos

- [OpenAPI Specification](https://swagger.io/specification/)
- [swagger-jsdoc](https://github.com/Surnet/swagger-jsdoc)
- [swagger-ui-express](https://github.com/scottie1984/swagger-ui-express)
- [Swagger Editor Online](https://editor.swagger.io/)

---

**¡Con esto tendrás una documentación de API profesional e interactiva!** 🚀
