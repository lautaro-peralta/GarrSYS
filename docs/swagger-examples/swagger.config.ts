// src/config/swagger.config.ts
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

      ## Roles de Usuario
      - **Admin**: Acceso completo al sistema
      - **Socio**: Puede gestionar ventas y decisiones estratégicas
      - **Usuario**: Acceso limitado de consulta
    `,
    contact: {
      name: 'Grupo Shelby - UTN FRRo',
      url: 'https://github.com/Lau-prog/TP-Desarrollo-de-Software',
      email: 'lautaro@example.com',
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
        description: 'Ingresa tu JWT token (sin el prefijo "Bearer")',
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
      Success: {
        type: 'object',
        properties: {
          success: {
            type: 'boolean',
            example: true,
          },
          data: {
            type: 'object',
          },
          message: {
            type: 'string',
          },
        },
      },
    },
  },
  tags: [
    {
      name: 'Auth',
      description: 'Autenticación y autorización de usuarios',
    },
    {
      name: 'Products',
      description: 'Gestión de productos legales e ilegales',
    },
    {
      name: 'Clients',
      description: 'Gestión de clientes',
    },
    {
      name: 'Sales',
      description: 'Registro y consulta de ventas',
    },
    {
      name: 'Partners',
      description: 'Gestión de socios del Consejo Shelby',
    },
    {
      name: 'Zones',
      description: 'Gestión de zonas de operación',
    },
    {
      name: 'Distributors',
      description: 'Gestión de distribuidores por zona',
    },
    {
      name: 'Authorities',
      description: 'Gestión de autoridades y funcionarios',
    },
    {
      name: 'Bribes',
      description: 'Gestión de sobornos y pagos a autoridades',
    },
    {
      name: 'Strategic Decisions',
      description: 'Decisiones estratégicas del Consejo Shelby',
    },
  ],
};

const options: swaggerJsdoc.Options = {
  definition: swaggerDefinition,
  // Rutas donde están tus archivos con anotaciones OpenAPI
  apis: [
    './src/modules/**/*.routes.ts',
    './src/modules/**/*.controller.ts',
    './src/shared/**/*.ts',
  ],
};

export const swaggerSpec = swaggerJsdoc(options);
