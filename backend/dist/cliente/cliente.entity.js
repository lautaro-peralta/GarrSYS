export class Cliente {
    constructor(id, //UUID
    nombre, email, direccion, telefono, regCompras) {
        this.id = id;
        this.nombre = nombre;
        this.email = email;
        this.direccion = direccion;
        this.telefono = telefono;
        this.regCompras = regCompras;
    }
    static fromDbRow(row) {
        return new Cliente(row.id, //UUID
        row.nombre, row.email || undefined, // Mapeo de DB email
        row.direccion || undefined, row.telefono || undefined, // Mapeo de DB telefono
        row.regCompras || undefined);
    }
}
//# sourceMappingURL=cliente.entity.js.map