var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
import { PrimaryKey } from '@mikro-orm/core';
import { v4 as uuidv4 } from 'uuid';
export class BaseEntityPersona {
    constructor() {
        if (!this.id)
            this.id = uuidv4();
    }
}
__decorate([
    PrimaryKey({ type: 'uuid' }),
    __metadata("design:type", String)
], BaseEntityPersona.prototype, "id", void 0);
/*
  @Property({ type: DateTimeType })
  createdAt = new Date();

  @Property({
    type: DateTimeType,
    onUpdate: () => new Date(),
    nullable: true
  })
  updatedAt?: Date;
  
 
  POR EJEMPLO, PARA AUTORIDAD, LA FECHA A PARTIR DE LA CUAL COMENZÓ A TRABAJAR
  CLANDESTINAMENTE, O LOS SOCIOS, PARA SABER SU ANTIGÜEDAD

  */
//# sourceMappingURL=base.persona.entity.js.map