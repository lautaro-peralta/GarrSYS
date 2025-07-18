import { Router } from 'express';
import { sanitizarInputCliente, findAll, findOne, add, putUpdate, patchUpdate, remove } from './cliente.controler.js';
export const clienteRouter = Router();
clienteRouter.get('/', findAll);
clienteRouter.get('/:id', findOne);
clienteRouter.post('/', sanitizarInputCliente, add);
clienteRouter.put('/:id', sanitizarInputCliente, putUpdate);
clienteRouter.patch('/:id', sanitizarInputCliente, patchUpdate);
clienteRouter.delete('/:id', remove);
//# sourceMappingURL=cliente.routes.js.map