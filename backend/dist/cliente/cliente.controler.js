import { orm } from "../shared/db/orm.js";
import { Cliente } from "./cliente.entity.js";
const em = orm.em;
function sanitizarInputCliente(req, res, next) {
    const body = req.body;
    const clienteSanitizado = {
        nombre: typeof body.nombre === "string" ? body.nombre.trim() : undefined,
        email: typeof body.email === "string" ? body.email.trim() : undefined,
        direccion: typeof body.direccion === "string" ? body.direccion.trim() : undefined,
        telefono: typeof body.telefono === "string" ? body.telefono.trim() : undefined,
    };
    Object.keys(clienteSanitizado).forEach((key) => {
        if (clienteSanitizado[key] === undefined) {
            delete clienteSanitizado[key];
        }
    });
    req.body.clienteSanitizado = clienteSanitizado;
    next();
}
async function findAll(req, res) {
    try {
        const clientes = await em.find(Cliente, {}, { populate: ['regCompras'] });
        const clientesDTO = clientes.map(cliente => cliente.toDTO());
        res.status(200).json({ data: clientesDTO });
    }
    catch (err) {
        console.error("Error OBTENIENDO clientes:", err); // 👈 Agregado
        res.status(500).json({ message: "Error al obtener clientes" });
    }
}
async function findOne(req, res) {
    try {
        const id = req.params.id.trim();
        const cliente = await em.findOne(Cliente, id, { populate: ['regCompras'] });
        if (!cliente) {
            return res.status(404).send({ message: "Cliente no encontrado" });
        }
        res.json({ data: cliente.toDTO() });
    }
    catch (err) {
        return res.status(400).send({ message: "Error al buscar cliente" });
    }
}
async function add(req, res) {
    const input = req.body.clienteSanitizado;
    try {
        const cliente = em.create(Cliente, req.body.clienteSanitizado);
        await orm.em.persistAndFlush(cliente);
        return res.status(201).send({ message: "Cliente creado", data: cliente.toDTO() });
    }
    catch (err) {
        return res.status(400).send({ message: err.message || "Error al crear cliente" });
    }
}
async function putUpdate(req, res) {
    try {
        const id = req.params.id.trim();
        const input = req.body.clienteSanitizado;
        // Validar que todos los campos obligatorios estén presentes para un reemplazo completo
        const camposObligatorios = ['nombre', 'email']; // define según tu modelo cuáles son obligatorios
        for (const campo of camposObligatorios) {
            if (!input[campo]) {
                return res.status(400).send({ message: `Campo obligatorio faltante: ${campo}` });
            }
        }
        const clienteToUpdate = await em.findOne(Cliente, { id }, { populate: ['regCompras'] });
        if (!clienteToUpdate) {
            return res.status(404).send({ message: "Cliente no encontrado" });
        }
        // Aquí podemos asignar los campos que vienen y para los que no vienen, asignar undefined explícito
        // para borrar valores no enviados (simula reemplazo total)
        const camposCliente = ['nombre', 'email', 'direccion', 'telefono'];
        const reemplazoCompleto = {};
        for (const campo of camposCliente) {
            reemplazoCompleto[campo] = input[campo] !== undefined ? input[campo] : undefined;
        }
        em.assign(clienteToUpdate, reemplazoCompleto);
        await em.flush();
        return res.status(200).send({ message: "Cliente actualizado correctamente (PUT)", data: clienteToUpdate.toDTO() });
    }
    catch (err) {
        console.error("Error en PUT actualizar cliente:", err);
        return res.status(400).send({ message: err.message || "Error al actualizar cliente (PUT)" });
    }
}
async function patchUpdate(req, res) {
    try {
        const id = req.params.id.trim();
        const input = req.body.clienteSanitizado;
        if (!input || Object.keys(input).length === 0) {
            return res.status(400).send({ message: "No hay datos para actualizar" });
        }
        const clienteToUpdate = await em.findOne(Cliente, { id }, { populate: ['regCompras'] });
        if (!clienteToUpdate) {
            return res.status(404).send({ message: "Cliente no encontrado" });
        }
        em.assign(clienteToUpdate, input);
        await em.flush();
        return res.status(200).send({ message: "Cliente actualizado correctamente (PATCH)", data: clienteToUpdate.toDTO() });
    }
    catch (err) {
        console.error("Error en PATCH actualizar cliente:", err);
        return res.status(400).send({ message: err.message || "Error al actualizar cliente (PATCH)" });
    }
}
async function remove(req, res) {
    try {
        const id = req.params.id.trim();
        const cliente = await em.findOne(Cliente, id);
        if (!cliente) {
            return res.status(404).send({ message: "Cliente no encontrado" });
        }
        await em.removeAndFlush(cliente);
        res.status(200).send({ message: "Cliente eliminado exitosamente" });
    }
    catch (err) {
        return res.status(400).send({ message: "Error al eliminar cliente" });
    }
}
export { sanitizarInputCliente, findAll, findOne, add, putUpdate, patchUpdate, remove, };
//# sourceMappingURL=cliente.controler.js.map