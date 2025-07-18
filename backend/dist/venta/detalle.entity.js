var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
import { Entity, Property, ManyToOne } from "@mikro-orm/core";
import { BaseEntityObjeto } from "../shared/db/base.objeto.entity.js";
import { Venta } from "./venta.entity.js";
export let Detalle = class Detalle extends BaseEntityObjeto {
    toDTO() {
        return {
            //producto: {id: this.producto.id,nombre: this.producto.nombre,}
            producto: this.producto,
            cantidad: this.cantidad,
            precioUnitario: this.precioUnitario,
            subtotal: this.subtotal,
        };
    }
};
__decorate([
    Property()
    // TODO: Reemplazar `string` por la entidad `Producto` cuando esté disponible
    // @ManyToOne(() => Producto)
    ,
    __metadata("design:type", String)
], Detalle.prototype, "producto", void 0);
__decorate([
    Property(),
    __metadata("design:type", Number)
], Detalle.prototype, "cantidad", void 0);
__decorate([
    Property({ type: 'decimal', precision: 10, scale: 2 }),
    __metadata("design:type", Number)
], Detalle.prototype, "precioUnitario", void 0);
__decorate([
    Property({ type: 'decimal', precision: 10, scale: 2 }),
    __metadata("design:type", Number)
], Detalle.prototype, "subtotal", void 0);
__decorate([
    ManyToOne(() => Venta, { nullable: false }),
    __metadata("design:type", Venta)
], Detalle.prototype, "venta", void 0);
Detalle = __decorate([
    Entity({ tableName: 'detalles_venta' })
], Detalle);
//# sourceMappingURL=detalle.entity.js.map