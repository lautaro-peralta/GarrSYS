import { ClienteRepository } from "./cliente.repository.js";
import { Cliente } from "./cliente.entity.js";
const repository = new ClienteRepository();
function sanitizarInputCliente(req, res, next) {
    req.body.clienteSanitizado = {
        id: req.body.id,
        nombre: req.body.nombre,
        direccion: req.body.direccion,
        regCompras: req.body.regCompras,
        tel: req.body.tel,
        correo: req.body.correo
    };
    //más validaciones acá
    Object.keys(req.body.clienteSanitizado).forEach(key => {
        if (req.body.clienteSanitizado[key] === undefined) {
            delete req.body.clienteSanitizado[key];
        }
    });
    next();
}
function findAll(req, res) {
    res.json({ data: repository.findAll() });
}
function findOne(req, res) {
    const cliente = repository.findOne({ id: req.params.id });
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    res.json({ data: cliente });
}
function add(req, res) {
    const input = req.body.clienteSanitizado;
    const inputCliente = new Cliente(input.id, input.nombre, input.direccion, input.regCompras, input.tel, input.correo);
    const cliente = repository.add(inputCliente);
    return res.status(201).send({ message: 'Cliente created', data: cliente });
}
function update(req, res) {
    req.body.clienteSanitizado.id = req.params.id;
    const cliente = repository.update(req.body.clienteSanitizado);
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    return res.status(200).send({ message: 'Cliente actualizado correctamente', data: cliente });
}
function remove(req, res) {
    const cliente = repository.delete({ id: req.params.id });
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    res.status(200).send({ message: 'Cliente eliminado exitosamente' });
}
export { sanitizarInputCliente, findAll, findOne, add, update, remove };
//# sourceMappingURL=cliente.controler.js.map