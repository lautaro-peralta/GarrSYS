const db = require('../../DB/mysql');

const TABLA='clientes';

function todos(){
  return db.todos(TABLA);
}

function uno(id){
  return db.uno(TABLA,id);
}


function agregar(body){
  return db.agregar(TABLA,body);
}

function eliminar(body){
  return db.eliminar(TABLA,body);
}


module.exports={
  todos,
  uno,
  agregar,
  eliminar,
}

