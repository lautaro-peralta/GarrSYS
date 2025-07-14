import { ObjectId } from "mongodb";

export class Cliente{
  constructor(
    public id:string,
    public nombre:string,
    public direccion:string,
    public regCompras:string,
    public tel: string,
    public correo:string,
    public _id?:ObjectId,
  ){}
}