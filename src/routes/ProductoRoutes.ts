import { Router } from 'express';
import { DI } from '../Shared/shared/db/orm';
import { Producto } from '../models/Producto';

export const productoRouter = Router();

productoRouter.get('/', async (req, res) => {
    const productos = await DI.productoRepo.findAll();
    res.json(productos);
});

productoRouter.get('/:id', async (req, res) => {
    const producto = await DI.productoRepo.findOne(req.params.id);
    if (!producto) {
        return res.status(404).json({ mensaje: 'Producto no encontrado' });
    }
    res.json(producto);
});

productoRouter.post('/', async (req, res) => {
    const nuevoProducto = DI.productoRepo.create(req.body);
    await DI.productoRepo.persistAndFlush(nuevoProducto);
    res.status(201).json(nuevoProducto);
});

productoRouter.put('/:id', async (req, res) => {
    const producto = await DI.productoRepo.findOne(req.params.id);
    if (!producto) {
        return res.status(404).json({ mensaje: 'Producto no encontrado' });
    }
    DI.productoRepo.assign(producto, req.body);
    await DI.productoRepo.persistAndFlush(producto);
    res.json(producto);
});

productoRouter.delete('/:id', async (req, res) => {
    const producto = await DI.productoRepo.findOne(req.params.id);
    if (!producto) {
        return res.status(404).json({ mensaje: 'Producto no encontrado' });
    }
    await DI.productoRepo.removeAndFlush(producto);
    res.json({ mensaje: 'Producto eliminado correctamente' });
});
