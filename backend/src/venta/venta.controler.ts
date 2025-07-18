import { Request,Response, NextFunction } from "express"
import { orm } from "../shared/db/orm.js"; 
import { Venta } from "./venta.entity.js"
import { Detalle } from "./detalle.entity.js";
import { Cliente } from "../cliente/cliente.entity.js";

// TODO: Descomentar esta línea cuando se cree la entidad Producto
// import { Producto } from "../producto/producto.entity.js";

const em =orm.em

function sanitizarInputVenta(req: Request, res: Response, next: NextFunction) {
  const body = req.body;

  const ventaSanitizada = {
    clienteNombre: typeof body.clienteNombre === "string" ? body.clienteNombre.trim() : undefined,
    detalles: Array.isArray(body.detalles)
      ? body.detalles.map((detalle: any) => ({
          productoId: typeof detalle.productoId === "number" ? detalle.productoId : undefined,
          cantidad: typeof detalle.cantidad === "number" ? detalle.cantidad : undefined,
          precioUnitario: typeof detalle.precioUnitario === "number" ? detalle.precioUnitario : undefined,
          subtotal: typeof detalle.subtotal === "number" ? detalle.subtotal : undefined,
        }))
      : [],
  };

  req.body.ventaSanitizada = ventaSanitizada;
  next();
}

async function findAll(req: Request, res: Response) {
  try {
    const ventas = await em.find(Venta, {}, { populate: ['detalles'] });
    const ventasDTO = ventas.map(ventas => ventas.toDTO());
    res.status(200).json({ data: ventasDTO });
  } catch (err) {
    console.error("Error obteniendo ventas:", err);
    res.status(500).json({ message: "Error al obtener ventas" });
  }
}

async function findOne(req: Request, res: Response) {
  try {
    const id = Number(req.params.id.trim());
    if (isNaN(id)) {
      return res.status(400).send({ message: "ID inválido" });
    }

    const venta = await em.findOne(Venta, { id }, { populate: ['cliente', 'detalles.producto'] });
    if (!venta) {
      return res.status(404).send({ message: "Venta no encontrada" });
    }

    res.status(200).json({ data: venta.toDTO() });
  } catch (err) {
    console.error("Error buscando venta:", err);
    res.status(500).send({ message: "Error al buscar la venta" });
  }
}


async function add(req: Request, res: Response) {
  const { clienteNombre, detalles } = req.body.ventaSanitizada;

  try {
    const cliente = await em.findOne(Cliente, { nombre: clienteNombre });

    if (!cliente) {
      return res.status(404).send({ message: "Cliente no encontrado" });
    }

    const nuevaVenta = em.create(Venta, {
      cliente,
      fechaVenta: new Date(),
      montoVenta: 0,
      detalles: [],
    });

    for (const detalle of detalles) {
      // TODO: Reemplazar esto por la consulta real a Producto cuando esté creada
      // const producto = await em.findOne(Producto, { id: detalle.productoId });
      // if (!producto) {
      //   return res.status(400).send({ message: `Producto con ID ${detalle.productoId} no encontrado` });
      // }

      const productoSimulado = `Producto ${detalle.productoId}`; // <--- Simulación temporal

      const nuevoDetalle = em.create(Detalle, {
        producto: productoSimulado,
        cantidad: detalle.cantidad,
        precioUnitario: detalle.precioUnitario,
        subtotal: detalle.subtotal,
        venta: nuevaVenta,
      });

      nuevaVenta.detalles.add(nuevoDetalle);
    }

    // Calcular el monto total de la venta sumando subtotales
    nuevaVenta.montoVenta = nuevaVenta.detalles.getItems().reduce((acc, d) => acc + d.subtotal, 0);

    await em.persistAndFlush(nuevaVenta);

    return res.status(201).send({ message: "Venta registrada exitosamente", data: nuevaVenta.toDTO() });
  } catch (err: any) {
    console.error("Error al registrar venta:", err);
    return res.status(500).send({ message: err.message || "Error al registrar la venta" });
  }
}

async function putUpdate(req: Request, res: Response) {
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
    const reemplazoCompleto: Partial<typeof input> = {};
    for (const campo of camposCliente) {
      reemplazoCompleto[campo] = input[campo] !== undefined ? input[campo] : undefined;
    }

    em.assign(clienteToUpdate, reemplazoCompleto);
    await em.flush();

    return res.status(200).send({ message: "Cliente actualizado correctamente (PUT)", data: clienteToUpdate.toDTO() });
  } catch (err: any) {
    console.error("Error en PUT actualizar cliente:", err);
    return res.status(400).send({ message: err.message || "Error al actualizar cliente (PUT)" });
  }
}

async function patchUpdate(req: Request, res: Response) {
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
  } catch (err: any) {
    console.error("Error en PATCH actualizar cliente:", err);
    return res.status(400).send({ message: err.message || "Error al actualizar cliente (PATCH)" });
  }
}

async function remove(req: Request, res: Response) {
  try {
    const id = req.params.id.trim();
    const cliente = await em.findOne(Cliente, id);
    if (!cliente) {
      return res.status(404).send({ message: "Cliente no encontrado" });
    }

    await em.removeAndFlush(cliente);

    res.status(200).send({ message: "Cliente eliminado exitosamente" });
  } catch (err) {
    return res.status(400).send({ message: "Error al eliminar cliente" });
  }
}

export {
  sanitizarInputVenta,
  findAll,
  findOne,
  add,
  putUpdate,
  patchUpdate,
  remove,
};
