import { Repository } from "../shared/repository.js";
import { Cliente } from "./cliente.entity.js";

const clientes =[
  new Cliente(
    '10',
    'Pedro',
    'San Luis 1530',
    'Ninguna compra aún',
    '03412223334',
    'pedro@gmail.com'
  ),
]

export class clienteRepository implements Repository<Cliente>{
  public findAll(): Cliente[] | undefined {
    return clientes
  }

  public findOne(item: { id: string; }): Cliente | undefined {
    return clientes.find((cliente) => cliente.id === item.id)
  }

  public add(item: Cliente): Cliente | undefined {
    clientes.push(item)
    return item
  }


  //puede recibir el id por separado tambien, cambiar en Repository
  public update(item: Cliente): Cliente | undefined {
    const clienteIdx = clientes.findIndex(cliente=> cliente.id===item.id)
    
    if(clienteIdx!==-1){
    Object.assign(clientes[clienteIdx], item)
    }
    return clientes[clienteIdx]
  }

  public delete(item: { id: string; }): Cliente | undefined {
    const clienteIdx = clientes.findIndex(cliente=> cliente.id===item.id)
  if(clienteIdx!==-1){
    const deletedClientes = clientes[clienteIdx]
    clientes.splice(clienteIdx,1)
    return deletedClientes
  }
  
  
  
  }



}