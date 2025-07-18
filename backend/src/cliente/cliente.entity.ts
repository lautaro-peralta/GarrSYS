import { Entity, Property, OneToMany, Collection, Cascade } from '@mikro-orm/core';
import { Venta } from '../venta/venta.entity.js';
import { BaseEntityPersona } from '../shared/db/base.persona.entity.js';

@Entity({tableName:'clientes'})
export class Cliente extends BaseEntityPersona{

  @Property({nullable: false})
  nombre!: string;

  @Property({ nullable: true, unique:true })
  email?: string;

  @Property({ nullable: true })
  direccion?: string;

  @Property({ nullable: true })
  telefono?: string;

  @OneToMany(() => 'Venta', 'cliente')
  regCompras = new Collection<Venta>(this);

  toDTO() {
    return {
      id: this.id,
      nombre: this.nombre,
      email: this.email,
      direccion: this.direccion,
      telefono: this.telefono,
      regCompras: this.regCompras.isEmpty()
        ? 'No hay nada aquí por ahora...' : this.regCompras.getItems(),  // Devuelve el array de ventas
    };
  }
}