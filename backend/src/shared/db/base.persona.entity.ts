import { PrimaryKey, Property, DateTimeType } from '@mikro-orm/core'
import { v4 as uuidv4} from 'uuid';


export abstract class BaseEntityPersona {
  @PrimaryKey({type:'uuid'})
  id!: string;

  constructor() {
    if (!this.id) this.id = uuidv4();
  }
}

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
