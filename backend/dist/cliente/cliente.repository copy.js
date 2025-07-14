import { Cliente } from "./cliente.entity.js";
const clientes = [
    new Cliente('10', 'Pedro', 'San Luis 1530', 'Ninguna compra aún', '03412223334', 'pedro@gmail.com'),
];
export class ClienteRepository {
    async findAll() {
        return await clientes;
    }
    async findOne(item) {
        return await clientes.find((cliente) => cliente.id === item.id);
    }
    async add(item) {
        await clientes.push(item);
        return item;
    }
    //puede recibir el id por separado tambien, cambiar en Repository
    async update(item) {
        const clienteIdx = await clientes.findIndex(cliente => cliente.id === item.id);
        if (clienteIdx !== -1) {
            Object.assign(clientes[clienteIdx], item);
        }
        return clientes[clienteIdx];
    }
    async delete(item) {
        const clienteIdx = await clientes.findIndex(cliente => cliente.id === item.id);
        if (clienteIdx !== -1) {
            const deletedClientes = clientes[clienteIdx];
            clientes.splice(clienteIdx, 1);
            return deletedClientes;
        }
    }
}
/*export class ClienteRepository implements Repository<Cliente> {
  public async findAll(): Promise<Cliente[]> {
    return clientes;
  }

  public async findOne(item: { id: string }): Promise<Cliente | undefined> {
    return clientes.find((cliente) => cliente.id.trim() === item.id.trim());
  }

  public async add(item: Cliente): Promise<Cliente> {
    const existente = clientes.find((c) => c.id.trim() === item.id.trim());
    if (existente) {
      throw new Error("Ya existe un cliente con ese ID");
    }

    clientes.push(item);
    return item;
  }

  public async update(item: Cliente): Promise<Cliente | undefined> {
    const idx = clientes.findIndex((c) => c.id.trim() === item.id.trim());

    if (idx !== -1) {
      Object.assign(clientes[idx], item);
      return clientes[idx];
    }

    return undefined;
  }

  public async delete(item: { id: string }): Promise<Cliente | undefined> {
    const idx = clientes.findIndex((c) => c.id.trim() === item.id.trim());

    if (idx !== -1) {
      const eliminado = clientes[idx];
      clientes.splice(idx, 1);
      return eliminado;
    }

    return undefined;
  }
}
*/ 
//# sourceMappingURL=cliente.repository%20copy.js.map