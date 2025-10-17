// Ejemplo: src/modules/products/products.routes.ts
import { Router } from 'express';
import { productController } from './product.controller';
import { authMiddleware } from '../../shared/middleware/auth.middleware';
import { roleMiddleware } from '../../shared/middleware/role.middleware';

const router = Router();

/**
 * @openapi
 * /api/products:
 *   get:
 *     tags:
 *       - Products
 *     summary: Listar todos los productos
 *     description: Retorna una lista de todos los productos (legales e ilegales) con paginación opcional
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: type
 *         schema:
 *           type: string
 *           enum: [legal, illegal]
 *         description: Filtrar por tipo de producto
 *         example: illegal
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
 *       - in: query
 *         name: search
 *         schema:
 *           type: string
 *         description: Buscar por nombre de producto
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
 *                         example: 1
 *                       name:
 *                         type: string
 *                         example: Whisky Irlandés
 *                       description:
 *                         type: string
 *                         example: Whisky de contrabando de Irlanda
 *                       price:
 *                         type: number
 *                         example: 150.00
 *                       type:
 *                         type: string
 *                         enum: [legal, illegal]
 *                         example: illegal
 *                       stock:
 *                         type: number
 *                         example: 50
 *                       createdAt:
 *                         type: string
 *                         format: date-time
 *                 pagination:
 *                   type: object
 *                   properties:
 *                     page:
 *                       type: number
 *                     limit:
 *                       type: number
 *                     total:
 *                       type: number
 *       401:
 *         description: No autenticado
 *       403:
 *         description: No autorizado
 */
router.get('/', authMiddleware, productController.getAll);

/**
 * @openapi
 * /api/products/{id}:
 *   get:
 *     tags:
 *       - Products
 *     summary: Obtener producto por ID
 *     description: Retorna los detalles de un producto específico
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID del producto
 *         example: 1
 *     responses:
 *       200:
 *         description: Producto encontrado
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
 *                     id:
 *                       type: number
 *                     name:
 *                       type: string
 *                     description:
 *                       type: string
 *                     price:
 *                       type: number
 *                     type:
 *                       type: string
 *                     stock:
 *                       type: number
 *       404:
 *         description: Producto no encontrado
 *       401:
 *         description: No autenticado
 */
router.get('/:id', authMiddleware, productController.getById);

/**
 * @openapi
 * /api/products:
 *   post:
 *     tags:
 *       - Products
 *     summary: Crear un nuevo producto
 *     description: Crea un nuevo producto (legal o ilegal). Requiere rol de administrador.
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
 *                 minimum: 0
 *                 example: 150.00
 *               type:
 *                 type: string
 *                 enum: [legal, illegal]
 *                 example: illegal
 *               stock:
 *                 type: number
 *                 minimum: 0
 *                 example: 50
 *     responses:
 *       201:
 *         description: Producto creado exitosamente
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
 *                     id:
 *                       type: number
 *                     name:
 *                       type: string
 *                     price:
 *                       type: number
 *       400:
 *         description: Error de validación
 *       401:
 *         description: No autenticado
 *       403:
 *         description: No autorizado (requiere rol admin)
 */
router.post('/', authMiddleware, roleMiddleware(['admin']), productController.create);

/**
 * @openapi
 * /api/products/{id}:
 *   put:
 *     tags:
 *       - Products
 *     summary: Actualizar producto
 *     description: Actualiza los datos de un producto existente. Requiere rol de administrador.
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID del producto
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 example: Whisky Escocés Premium
 *               description:
 *                 type: string
 *               price:
 *                 type: number
 *                 example: 200.00
 *               stock:
 *                 type: number
 *                 example: 75
 *     responses:
 *       200:
 *         description: Producto actualizado exitosamente
 *       404:
 *         description: Producto no encontrado
 *       400:
 *         description: Error de validación
 *       401:
 *         description: No autenticado
 *       403:
 *         description: No autorizado
 */
router.put('/:id', authMiddleware, roleMiddleware(['admin']), productController.update);

/**
 * @openapi
 * /api/products/{id}:
 *   delete:
 *     tags:
 *       - Products
 *     summary: Eliminar producto
 *     description: Elimina un producto del sistema. Requiere rol de administrador.
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID del producto a eliminar
 *     responses:
 *       200:
 *         description: Producto eliminado exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 message:
 *                   type: string
 *                   example: Producto eliminado exitosamente
 *       404:
 *         description: Producto no encontrado
 *       401:
 *         description: No autenticado
 *       403:
 *         description: No autorizado
 */
router.delete('/:id', authMiddleware, roleMiddleware(['admin']), productController.delete);

/**
 * @openapi
 * /api/products/legal:
 *   get:
 *     tags:
 *       - Products
 *     summary: Listar productos legales
 *     description: Retorna únicamente los productos legales
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de productos legales
 */
router.get('/legal', authMiddleware, productController.getLegalProducts);

/**
 * @openapi
 * /api/products/illegal:
 *   get:
 *     tags:
 *       - Products
 *     summary: Listar productos ilegales
 *     description: Retorna únicamente los productos ilegales. Requiere autorización especial.
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Lista de productos ilegales
 *       403:
 *         description: No autorizado para ver productos ilegales
 */
router.get('/illegal', authMiddleware, roleMiddleware(['admin', 'socio']), productController.getIllegalProducts);

export default router;
