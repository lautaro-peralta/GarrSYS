import express, { NextFunction, Request, Response } from 'express'
import { clienteRouter } from './cliente/cliente.routes.js'

const app=express()
app.use(express.json())

app.use('/api/clientes',clienteRouter)


//Middleware

app.use((_,res)=>{
  res.status(404).send({message: 'No se encontró el recurso'})
})

app.listen(3000,()=>{
  console.log('Servidor corriendo en hhtp://localhost:3000/')
})
