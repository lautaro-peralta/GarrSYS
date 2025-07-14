import { ClienteRepository } from "./cliente.repository.js";
import { Cliente } from "./cliente.entity.js";
const repository = new ClienteRepository();
function sanitizarInputCliente(req, res, next) {
    const body = req.body;
    const clienteSanitizado = {
        id: req.params.id?.toString().trim() || body.id?.toString().trim(),
        nombre: typeof body.nombre === "string" ? body.nombre.trim() : undefined,
        direccion: typeof body.direccion === "string" ? body.direccion.trim() : undefined,
        regCompras: typeof body.regCompras === "string" ? body.regCompras.trim() : undefined,
        tel: typeof body.tel === "string" ? body.tel.trim() : undefined,
        correo: typeof body.correo === "string" ? body.correo.trim() : undefined,
    };
    // Elimina campos undefined
    Object.keys(clienteSanitizado).forEach((key) => {
        if (clienteSanitizado[key] === undefined) {
            delete clienteSanitizado[key];
        }
    });
    req.body.clienteSanitizado = clienteSanitizado;
    /*req.body.clienteSanitizado = {
        id: req.body.id,
        nombre:req.body.nombre,
        direccion: req.body.direccion,
        regCompras: req.body.regCompras,
        tel:req.body.tel,
        correo:req.body.correo
      }
      //más validaciones acá
      
      Object.keys(req.body.clienteSanitizado).forEach(key => {
        if(req.body.clienteSanitizado[key]===undefined){
          delete req.body.clienteSanitizado[key]
        }
      })
      */
    next();
}
async function findAll(req, res) {
    res.json({ data: await repository.findAll() });
}
async function findOne(req, res) {
    const id = req.params.id.trim();
    const cliente = await repository.findOne({ id });
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    res.json({ data: cliente });
}
async function add(req, res) {
    const input = req.body.clienteSanitizado;
    const inputCliente = new Cliente(input.id, input.nombre, input.direccion, input.regCompras, input.tel, input.correo);
    try {
        const cliente = await repository.add(inputCliente);
        return res.status(201).send({ message: "Cliente creado", data: cliente });
    }
    catch (err) {
        return res.status(400).send({ message: err.message || "Error al crear cliente" });
    }
}
async function update(req, res) {
    const input = req.body.clienteSanitizado;
    input.id = req.params.id.trim();
    const cliente = await repository.update(input);
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    return res.status(200).send({ message: 'Cliente actualizado correctamente', data: cliente });
}
async function remove(req, res) {
    const id = req.params.id.trim();
    const cliente = await repository.delete({ id });
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    res.status(200).send({ message: 'Cliente eliminado exitosamente' });
}
export { sanitizarInputCliente, findAll, findOne, add, update, remove };
//# sourceMappingURL=cliente.controler.js.map