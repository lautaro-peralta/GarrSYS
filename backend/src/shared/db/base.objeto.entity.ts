import { PrimaryKey } from '@mikro-orm/core';

export abstract class BaseEntityObjeto {
  @PrimaryKey()
  id!: number;
}