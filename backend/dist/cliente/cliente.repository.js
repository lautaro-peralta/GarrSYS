import { Cliente } from "./cliente.entity.js";
import { pool } from "../shared/db/conn.mysql.js";
import { v4 as uuidv4 } from 'uuid';
export class ClienteRepository {
    mapDbToEntity(row) {
        return Cliente.fromDbRow(row);
    }
    async findAll() {
        try {
            const [rows] = await pool.query('SELECT * FROM clientes');
            return rows.map(row => this.mapDbToEntity(row));
        }
        catch (error) {
            console.error('Error en findAll:', error);
            throw new Error('No se pudieron obtener los clientes');
        }
    }
    async findOne(id) {
        try {
            const [rows] = await pool.query('SELECT * FROM clientes WHERE id = ?', [id]);
            if (!rows[0]) {
                throw new Error(`Cliente con ID ${id} no encontrado`);
            }
            return this.mapDbToEntity(rows[0]);
        }
        catch (error) {
            if (error instanceof Error && error.message.includes('no encontrado')) {
                console.log(error.message);
                throw error;
            }
            console.error(`Error al buscar cliente con ID ${id}:`, error);
            throw new Error('Error al buscar el cliente');
        }
    }
    async add(clienteInput) {
        try {
            const id = uuidv4(); // Genero el UUID en Node.js
            console.log('clienteInput recibido en add:', clienteInput);
            await pool.query(`INSERT INTO clientes (id, nombre, email, direccion, telefono, regCompras)
             VALUES (?, ?, ?, ?, ?, ?)`, [
                id,
                clienteInput.nombre,
                clienteInput.email || null,
                clienteInput.direccion || null,
                clienteInput.telefono || null,
                clienteInput.regCompras || null
            ]);
            const [rows] = await pool.query('SELECT * FROM clientes WHERE id = ?', [id]);
            if (!rows[0]) {
                throw new Error('No se pudo recuperar el cliente después de crearlo');
            }
            return this.mapDbToEntity(rows[0]);
        }
        catch (error) {
            console.error('Error en add:', error);
            throw new Error('No se pudo agregar el cliente');
        }
    }
    async update(id, clienteData) {
        try {
            const current = await this.findOne(id);
            const updated = {
                ...current,
                ...clienteData
            };
            await pool.query(`UPDATE clientes SET 
          nombre = ?, 
          email = ?, 
          direccion = ?, 
          telefono = ?,
          regCompras = ?
         WHERE id = ?`, [
                updated.nombre,
                updated.email || null,
                updated.direccion || null,
                updated.telefono || null,
                updated.regCompras || null,
                id
            ]);
            const [rows] = await pool.query('SELECT * FROM clientes WHERE id = ?', [id]);
            if (!rows[0]) {
                throw new Error('No se pudo recuperar el cliente después de actualizar');
            }
            return this.mapDbToEntity(rows[0]);
        }
        catch (error) {
            console.error(`Error al actualizar cliente con ID ${id}:`, error);
            throw new Error('No se pudo actualizar el cliente');
        }
    }
    async delete(id) {
        try {
            const cliente = await this.findOne(id);
            await pool.query('DELETE FROM clientes WHERE id = ?', [id]);
            return cliente;
        }
        catch (error) {
            console.error(`Error al eliminar cliente con ID ${id}:`, error);
            throw new Error('No se pudo eliminar el cliente');
        }
    }
}
//# sourceMappingURL=cliente.repository.js.map