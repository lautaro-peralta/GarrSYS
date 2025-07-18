var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
import { Entity, Property, OneToMany, ManyToOne, Collection, Cascade } from "@mikro-orm/core";
import { BaseEntityObjeto } from "../shared/db/base.objeto.entity.js";
import { Cliente } from "../cliente/cliente.entity.js";
export let Venta = class Venta extends BaseEntityObjeto {
    constructor() {
        super(...arguments);
        this.detalles = new Collection(this);
    }
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
};
__decorate([
    Property({ nullable: true }),
    __metadata("design:type", String)
], Venta.prototype, "descripcion", void 0);
__decorate([
    Property({ type: Date }),
    __metadata("design:type", Date)
], Venta.prototype, "fechaVenta", void 0);
__decorate([
    Property(),
    __metadata("design:type", Number)
], Venta.prototype, "montoVenta", void 0);
__decorate([
    ManyToOne(() => Cliente, { nullable: true }),
    __metadata("design:type", Cliente)
], Venta.prototype, "cliente", void 0);
__decorate([
    OneToMany(() => 'Detalle', 'venta', { cascade: [Cascade.ALL] }),
    __metadata("design:type", Object)
], Venta.prototype, "detalles", void 0);
Venta = __decorate([
    Entity({ tableName: 'ventas' })
], Venta);
//# sourceMappingURL=venta.entity.js.map