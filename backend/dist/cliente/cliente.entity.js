var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
import { Entity, Property, OneToMany, Collection } from '@mikro-orm/core';
import { BaseEntityPersona } from '../shared/db/base.persona.entity.js';
export let Cliente = class Cliente extends BaseEntityPersona {
    constructor() {
        super(...arguments);
        this.regCompras = new Collection(this);
    }
    toDTO() {
        return {
            id: this.id,
            nombre: this.nombre,
            email: this.email,
            direccion: this.direccion,
            telefono: this.telefono,
            regCompras: this.regCompras.isEmpty()
                ? 'No hay nada aquí por ahora...' : this.regCompras.getItems(), // Devuelve el array de ventas
        };
    }
};
__decorate([
    Property({ nullable: false }),
    __metadata("design:type", String)
], Cliente.prototype, "nombre", void 0);
__decorate([
    Property({ nullable: true, unique: true }),
    __metadata("design:type", String)
], Cliente.prototype, "email", void 0);
__decorate([
    Property({ nullable: true }),
    __metadata("design:type", String)
], Cliente.prototype, "direccion", void 0);
__decorate([
    Property({ nullable: true }),
    __metadata("design:type", String)
], Cliente.prototype, "telefono", void 0);
__decorate([
    OneToMany(() => 'Venta', 'cliente'),
    __metadata("design:type", Object)
], Cliente.prototype, "regCompras", void 0);
Cliente = __decorate([
    Entity({ tableName: 'clientes' })
], Cliente);
//# sourceMappingURL=cliente.entity.js.map