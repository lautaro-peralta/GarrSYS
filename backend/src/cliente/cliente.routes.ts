import {Router} from 'express';
import { sanitizarInputCliente,findAll,findOne,add,update,remove } from './cliente.controler.js';

export const clienteRouter = Router()

clienteRouter.get('/',findAll)
clienteRouter.get('/:id',findOne)
clienteRouter.post('/',sanitizarInputCliente,add)
clienteRouter.put('/:id',sanitizarInputCliente,update)
clienteRouter.patch('/:id',sanitizarInputCliente,update)
clienteRouter.delete('/:id',remove)
