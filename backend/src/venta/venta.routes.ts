import {Router} from 'express';
import { sanitizarInputVenta,findAll,findOne,add,putUpdate, patchUpdate, remove } from './venta.controler.js';

export const ventaRouter = Router()

ventaRouter.get('/',findAll)
ventaRouter.get('/:id',findOne)
ventaRouter.post('/',sanitizarInputVenta,add)
ventaRouter.put('/:id',sanitizarInputVenta,putUpdate)
ventaRouter.patch('/:id',sanitizarInputVenta,patchUpdate)
ventaRouter.delete('/:id',remove)