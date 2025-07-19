import { Entity, PrimaryKey, Property } from '@mikro-orm/core'

@Entity()
export class Producto {
  @PrimaryKey()
  idProd!: number

  @Property()
  nombre!: string

  @Property()
  tipoProd!: boolean

  @Property()
  descProd!: string

  @Property()
  precioProd!: number
}
