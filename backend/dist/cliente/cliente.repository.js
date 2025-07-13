import { Cliente } from "./cliente.entity.js";
const clientes = [
    new Cliente('10', 'Pedro', 'San Luis 1530', 'Ninguna compra aún', '03412223334', 'pedro@gmail.com'),
];
export class ClienteRepository {
    findAll() {
        return clientes;
    }
    findOne(item) {
        return clientes.find((cliente) => cliente.id === item.id);
    }
    add(item) {
        clientes.push(item);
        return item;
    }
    //puede recibir el id por separado tambien, cambiar en Repository
    update(item) {
        const clienteIdx = clientes.findIndex(cliente => cliente.id === item.id);
        if (clienteIdx !== -1) {
            Object.assign(clientes[clienteIdx], item);
        }
        return clientes[clienteIdx];
    }
    delete(item) {
        const clienteIdx = clientes.findIndex(cliente => cliente.id === item.id);
        if (clienteIdx !== -1) {
            const deletedClientes = clientes[clienteIdx];
            clientes.splice(clienteIdx, 1);
            return deletedClientes;
        }
    }
}
//# sourceMappingURL=cliente.repository.js.map