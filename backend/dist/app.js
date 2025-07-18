import 'reflect-metadata';
import express from 'express';
import { clienteRouter } from './cliente/cliente.routes.js';
import { orm, syncSchema } from './shared/db/orm.js';
import { RequestContext } from '@mikro-orm/core';
const app = express();
app.use(express.json());
//luego de los middlewares base
app.use((req, res, next) => {
    RequestContext.create(orm.em, next);
});
//antes de las rutas y middlewares de negocio
app.use('/api/clientes', clienteRouter);
//Middleware
app.use((_, res) => {
    res.status(404).send({ message: 'No se encontró el recurso' });
});
await syncSchema(); //never in production
app.listen(3000, () => {
    console.log('Servidor corriendo en http://localhost:3000/');
});
//# sourceMappingURL=app.js.map