import { EntityRepository } from '@mikro-orm/mysql'
import { Producto } from './producto.entity'

export class ProductoRepository extends EntityRepository<Producto> {
}
