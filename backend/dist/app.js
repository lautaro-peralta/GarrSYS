import express from 'express';
import { Cliente } from './cliente/cliente.entity.js';
import { clienteRepository } from './cliente/cliente.repository.js';
const app = express();
app.use(express.json());
const repository = new clienteRepository();
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
//READ
app.get('/api/clientes', (req, res) => {
    res.json({ data: repository.findAll() });
});
app.get('/api/clientes/:id', (req, res) => {
    const cliente = repository.findOne({ id: req.params.id });
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    res.json({ data: cliente });
});
//CREATE
app.post('/api/clientes', sanitizarInputCliente, (req, res) => {
    const input = req.body.clienteSanitizado;
    const inputCliente = new Cliente(input.id, input.nombre, input.direccion, input.regCompras, input.tel, input.correo);
    const cliente = repository.add(inputCliente);
    return res.status(201).send({ message: 'Cliente created', data: cliente });
});
//UPDATE
app.put('/api/clientes/:id', sanitizarInputCliente, (req, res) => {
    req.body.clienteSanitizado.id = req.params.id;
    const cliente = repository.update(req.body.clienteSanitizado);
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    return res.status(200).send({ message: 'Cliente actualizado correctamente', data: cliente });
});
app.patch('/api/clientes/:id', sanitizarInputCliente, (req, res) => {
    req.body.clienteSanitizado.id = req.params.id;
    const cliente = repository.update(req.body.clienteSanitizado);
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    return res.status(200).send({ message: 'Cliente actualizado correctamente', data: cliente });
});
//DELETE
app.delete('/api/clientes/:id', (req, res) => {
    const id = req.params.id;
    const cliente = repository.delete({ id });
    if (!cliente) {
        return res.status(404).send({ message: 'Cliente no encontrado' });
    }
    res.status(200).send({ message: 'Cliente eliminado exitosamente' });
});
//Middleware
app.use((req, res) => {
    res.status(404).send({ message: 'No se encontró el recurso' });
});
app.listen(3000, () => {
    console.log('Servidor corriendo en hhtp://localhost:3000/');
});
//# sourceMappingURL=app.js.map