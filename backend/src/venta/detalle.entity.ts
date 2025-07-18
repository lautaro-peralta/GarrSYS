import { Entity, DateTimeType, Property, OneToMany, ManyToOne, Collection, Cascade } from "@mikro-orm/core"
import { BaseEntityObjeto } from "../shared/db/base.objeto.entity.js"
import { Venta } from "./venta.entity.js"

@Entity({ tableName: 'detalles_venta' })
export class Detalle extends BaseEntityObjeto{ 
  @Property()
// TODO: Reemplazar `string` por la entidad `Producto` cuando esté disponible
// @ManyToOne(() => Producto)
producto!: string; // temporalmente usamos el nombre del producto como string

  @Property()
  cantidad!:number
  
  @Property({ type: 'decimal', precision: 10, scale: 2 })
  precioUnitario!: number;

  @Property({ type: 'decimal', precision: 10, scale: 2 })
  subtotal!: number
  
  @ManyToOne(()=>Venta,{nullable:false})
  venta!:Venta

  toDTO() {
    return {
      //producto: {id: this.producto.id,nombre: this.producto.nombre,}
      producto: this.producto,
      cantidad: this.cantidad,
      precioUnitario: this.precioUnitario,
      subtotal: this.subtotal,
    };
  }
}
