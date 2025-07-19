import { EntityRepository } from '@mikro-orm/mysql'
import { Producto } from './producto.entity'
import { Request, Response } from 'express'

export class ProductoController {
  constructor(private repo: EntityRepository<Producto>) {}

  async obtenerProductos(req: Request, res: Response) {
    const productos = await this.repo.findAll()
    res.json(productos)
  }

  async obtenerProducto(req: Request, res: Response) {
    const producto = await this.repo.findOne({ idProd: parseInt(req.params.idProd) })
    if (producto) res.json(producto)
    else res.status(404).json({ mensaje: 'Producto no encontrado' })
  }

  async crearProducto(req: Request, res: Response) {
    const nuevo = this.repo.create(req.body)
    await this.repo.persistAndFlush(nuevo)
    res.status(201).json(nuevo)
  }

  async actualizarProducto(req: Request, res: Response) {
    const producto = await this.repo.findOne({ idProd: parseInt(req.params.idProd) })
    if (producto) {
      this.repo.assign(producto, req.body)
      await this.repo.persistAndFlush(producto)
      res.json(producto)
    } else {
      res.status(404).json({ mensaje: 'Producto no encontrado' })
    }
  }

  async eliminarProducto(req: Request, res: Response) {
    const producto = await this.repo.findOne({ idProd: parseInt(req.params.idProd) })
    if (producto) {
      await this.repo.removeAndFlush(producto)
      res.json({ mensaje: 'Producto eliminado correctamente' })
    } else {
      res.status(404).json({ mensaje: 'Producto no encontrado' })
    }
  }
}
