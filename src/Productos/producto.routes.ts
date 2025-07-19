import { Router } from 'express'
import { DI } from '../Shared/shared/db/orm'
import { ProductoController } from './producto.controller'

export const productoRouter = Router()
const controller = new ProductoController(DI.productoRepo)

productoRouter.get('/', controller.obtenerProductos.bind(controller))
productoRouter.get('/:idProd', controller.obtenerProducto.bind(controller))
productoRouter.post('/', controller.crearProducto.bind(controller))
productoRouter.put('/:idProd', controller.actualizarProducto.bind(controller))
productoRouter.delete('/:idProd', controller.eliminarProducto.bind(controller))
