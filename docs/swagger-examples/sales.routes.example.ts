// Ejemplo: src/modules/sales/sales.routes.ts
import { Router } from 'express';
import { saleController } from './sale.controller';
import { authMiddleware } from '../../shared/middleware/auth.middleware';
import { roleMiddleware } from '../../shared/middleware/role.middleware';

const router = Router();

/**
 * @openapi
 * /api/sales:
 *   get:
 *     tags:
 *       - Sales
 *     summary: Listar ventas
 *     description: Retorna una lista de ventas con filtros opcionales
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: zone
 *         schema:
 *           type: integer
 *         description: Filtrar por ID de zona
 *       - in: query
 *         name: from
 *         schema:
 *           type: string
 *           format: date
 *         description: Fecha desde (YYYY-MM-DD)
 *         example: 2025-01-01
 *       - in: query
 *         name: to
 *         schema:
 *           type: string
 *           format: date
 *         description: Fecha hasta (YYYY-MM-DD)
 *         example: 2025-12-31
 *       - in: query
 *         name: clientId
 *         schema:
 *           type: integer
 *         description: Filtrar por ID de cliente
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *           default: 1
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           default: 10
 *     responses:
 *       200:
 *         description: Lista de ventas
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: number
 *                       totalAmount:
 *                         type: number
 *                         example: 1500.00
 *                       saleDate:
 *                         type: string
 *                         format: date-time
 *                       client:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: number
 *                           name:
 *                             type: string
 *                       zone:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: number
 *                           name:
 *                             type: string
 *                       distributor:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: number
 *                           name:
 *                             type: string
 *       401:
 *         description: No autenticado
 */
router.get('/', authMiddleware, saleController.getAll);

/**
 * @openapi
 * /api/sales/{id}:
 *   get:
 *     tags:
 *       - Sales
 *     summary: Obtener detalle de venta
 *     description: Retorna el detalle completo de una venta, incluyendo productos, sobornos asociados, etc.
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID de la venta
 *     responses:
 *       200:
 *         description: Detalle de la venta
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: number
 *                     totalAmount:
 *                       type: number
 *                     saleDate:
 *                       type: string
 *                       format: date-time
 *                     client:
 *                       type: object
 *                     products:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: number
 *                           name:
 *                             type: string
 *                           type:
 *                             type: string
 *                           quantity:
 *                             type: number
 *                           price:
 *                             type: number
 *                     bribes:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: number
 *                           amount:
 *                             type: number
 *                           status:
 *                             type: string
 *                             enum: [pending, paid]
 *                           authority:
 *                             type: object
 *       404:
 *         description: Venta no encontrada
 */
router.get('/:id', authMiddleware, saleController.getById);

/**
 * @openapi
 * /api/sales:
 *   post:
 *     tags:
 *       - Sales
 *     summary: Crear nueva venta
 *     description: Registra una nueva venta en el sistema
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - clientId
 *               - zoneId
 *               - distributorId
 *               - products
 *             properties:
 *               clientId:
 *                 type: number
 *                 example: 1
 *               zoneId:
 *                 type: number
 *                 example: 2
 *               distributorId:
 *                 type: number
 *                 example: 3
 *               products:
 *                 type: array
 *                 items:
 *                   type: object
 *                   required:
 *                     - productId
 *                     - quantity
 *                   properties:
 *                     productId:
 *                       type: number
 *                       example: 5
 *                     quantity:
 *                       type: number
 *                       example: 10
 *               notes:
 *                 type: string
 *                 example: Venta de whisky irlandés en Small Heath
 *     responses:
 *       201:
 *         description: Venta creada exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: number
 *                     totalAmount:
 *                       type: number
 *       400:
 *         description: Error de validación
 */
router.post('/', authMiddleware, roleMiddleware(['admin', 'socio']), saleController.create);

/**
 * @openapi
 * /api/sales/{id}/report:
 *   get:
 *     tags:
 *       - Sales
 *     summary: Generar informe de venta
 *     description: Genera un informe detallado de la venta con productos legales/ilegales asociados (CUU/Epic)
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
 *         description: Informe generado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: object
 *                   properties:
 *                     saleId:
 *                       type: number
 *                     totalAmount:
 *                       type: number
 *                     legalProducts:
 *                       type: array
 *                     illegalProducts:
 *                       type: array
 *                     associatedBribes:
 *                       type: array
 */
router.get('/:id/report', authMiddleware, roleMiddleware(['admin', 'socio']), saleController.generateReport);

export default router;
