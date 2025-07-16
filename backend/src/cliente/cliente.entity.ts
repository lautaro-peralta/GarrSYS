export class Cliente {
  constructor(
    public id: string, //UUID
    public nombre: string,
    public email?: string,
    public direccion?: string,
    public telefono?: string,
    public regCompras?: string,
  ){}

  public static fromDbRow(row: any): Cliente {
    return new Cliente(
      row.id, //UUID
      row.nombre,
      row.email || undefined,     // Mapeo de DB email
      row.direccion || undefined,
      row.telefono || undefined, // Mapeo de DB telefono
      row.regCompras || undefined
    );
  }
}