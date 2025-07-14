import { Request,Response, NextFunction } from "express"
import { ClienteRepository } from "./cliente.repository.js"
import { Cliente } from "./cliente.entity.js"

const repository = new ClienteRepository()

function sanitizarInputCliente(req:Request, res:Response,next:NextFunction){
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
    if (clienteSanitizado[key as keyof typeof clienteSanitizado] === undefined) {
      delete clienteSanitizado[key as keyof typeof clienteSanitizado];
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

async function findAll(req:Request,res:Response){
  res.json({ data: await repository.findAll() })
}

async function findOne(req:Request, res:Response){
  const id = req.params.id.trim();
  const cliente = await repository.findOne({ id }); 
  if (!cliente) {
    return res.status(404).send({ message: 'Cliente no encontrado' })
  }
  res.json({ data: cliente })
}

async function add(req:Request,res:Response){
  const input = req.body.clienteSanitizado;

  const inputCliente = new Cliente(
    input.id,
    input.nombre,
    input.direccion,
    input.regCompras,
    input.tel,
    input.correo
  )
  try {
    const cliente = await repository.add(inputCliente);
    return res.status(201).send({ message: "Cliente creado", data: cliente });
  } catch (err: any) {
    return res.status(400).send({ message: err.message || "Error al crear cliente" });
  }
}

async function update(req:Request,res:Response){
  const input = req.body.clienteSanitizado;
  input.id = req.params.id.trim();

  const cliente = await repository.update(input);

  if(!cliente){
    return res.status(404).send({ message: 'Cliente no encontrado' })
  }  
  return res.status(200).send({ message: 'Cliente actualizado correctamente', data: cliente })
}

async function remove(req:Request,res:Response){
  const id = req.params.id.trim();
  const cliente = await repository.delete({ id });

  if(!cliente){
    return res.status(404).send({ message: 'Cliente no encontrado' })
  }
  res.status(200).send({ message: 'Cliente eliminado exitosamente' }) 
}

export{
  sanitizarInputCliente,
  findAll,
  findOne,
  add,
  update,
  remove 
}