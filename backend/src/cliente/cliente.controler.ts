import { Request,Response, NextFunction } from "express"
import { ClienteRepository } from "./cliente.repository.js"
import { Cliente } from "./cliente.entity.js"


const repository = new ClienteRepository()

function sanitizarInputCliente(req:Request, res:Response,next:NextFunction){
  const body = req.body;

  const clienteSanitizado = {
    nombre: typeof body.nombre === "string" ? body.nombre.trim() : undefined,
    direccion: typeof body.direccion === "string" ? body.direccion.trim() : undefined,
    regCompras: typeof body.regCompras === "string" ? body.regCompras.trim() : undefined,
    tel: typeof body.tel === "string" ? body.tel.trim() : undefined,
    correo: typeof body.correo === "string" ? body.correo.trim() : undefined,
  };

  // Elimina campos undefined
  Object.keys(clienteSanitizado).forEach((key) => {
    if (clienteSanitizado[key as keyof typeof clienteSanitizado] === undefined) {
      delete clienteSanitizado[key as keyof typeof clienteSanitizado];
    }
  });

  req.body.clienteSanitizado = clienteSanitizado;
  
  next();
  
}

async function findAll(req: Request, res: Response) {
  try {
    const clientes = await repository.findAll();
    res.status(200).json({ data: clientes });
  } catch (err) {
    res.status(500).json({ message: "Error al obtener clientes" });
  }
}

async function findOne(req: Request, res: Response) {
  try {
    const id = req.params.id.trim(); // ✅ id como string directamente
    const cliente = await repository.findOne(id);
    if (!cliente) {
      return res.status(404).send({ message: "Cliente no encontrado" });
    }
    res.json({ data: cliente });
  } catch (err) {
    return res.status(400).send({ message: "Error al buscar cliente" });
  }
}

async function add(req: Request, res: Response) {
  const input = req.body.clienteSanitizado;

  const inputCliente = new Cliente(
  '',                // id vacío para que se genere en repo
  input.nombre,      
  input.email,
  input.direccion,
  input.telefono,
  input.regCompras
);

  try {
    const cliente = await repository.add(inputCliente);
    return res.status(201).send({ message: "Cliente creado", data: cliente });
  } catch (err: any) {
    return res.status(400).send({ message: err.message || "Error al crear cliente" });
  }
}

async function update(req: Request, res: Response) {
  try {
    const id = req.params.id.trim(); // ✅ string
    const input = req.body.clienteSanitizado;
    const cliente = await repository.update(id, input);
    if (!cliente) {
      return res.status(404).send({ message: "Cliente no encontrado" });
    }
    return res.status(200).send({ message: "Cliente actualizado correctamente", data: cliente });
  } catch (err) {
    return res.status(400).send({ message: "Error al actualizar cliente" });
  }
}

async function remove(req: Request, res: Response) {
  try {
    const id = req.params.id.trim(); // ✅ string
    const cliente = await repository.delete(id);
    if (!cliente) {
      return res.status(404).send({ message: "Cliente no encontrado" });
    }
    res.status(200).send({ message: "Cliente eliminado exitosamente" });
  } catch (err) {
    return res.status(400).send({ message: "Error al eliminar cliente" });
  }
}

export {
  sanitizarInputCliente,
  findAll,
  findOne,
  add,
  update,
  remove,
};