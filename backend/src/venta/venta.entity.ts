import { Entity, DateTimeType, Property, OneToMany, ManyToOne, Collection, Cascade } from "@mikro-orm/core"
import { BaseEntityObjeto } from "../shared/db/base.objeto.entity.js"
import { Cliente } from "../cliente/cliente.entity.js"
import { Detalle } from "./detalle.entity.js"

@Entity({ tableName: 'ventas' })
export class Venta extends BaseEntityObjeto{ 
  @Property({nullable:true})
  descripcion?:string
  
  @Property({type: Date})
  fechaVenta!: Date

  @Property()
  montoVenta!: number
  
  @ManyToOne(() => Cliente, {nullable: true})
  cliente?: Cliente;

  @OneToMany(() => 'Detalle', 'venta', { cascade: [Cascade.ALL] })
  detalles = new Collection<Detalle>(this);

  toDTO() {
      return {
      id: this.id,
      descripcion: this.descripcion || null,
      fecha: this.fechaVenta instanceof Date ? this.fechaVenta.toISOString() : this.fechaVenta,
      monto: this.montoVenta,
      cliente: this.cliente
        ? {
            id: this.cliente.id,
            nombre: this.cliente.nombre,
          }
        : null,
      detalles: this.detalles.getItems().map(d => d.toDTO()),
    };
  }
}