import { Producto } from "../models/Producto";

let productos: Producto[] = [];

// Crear producto
export const crearProducto = (producto: Producto): Producto => {
    productos.push(producto);
    return producto;
};

// Obtener todos los productos
export const obtenerProductos = (): Producto[] => {
    return productos;
};

// Obtener un producto por ID
export const obtenerProductoPorId = (idProd: number): Producto | undefined => {
    return productos.find(prod => prod.idProd === idProd);
};

// Actualizar producto
export const actualizarProducto = (idProd: number, datosActualizados: Partial<Producto>): Producto | undefined => {
    const producto = productos.find(prod => prod.idProd === idProd);
    if (producto) {
        Object.assign(producto, datosActualizados);
    }
    return producto;
};

// Eliminar producto
export const eliminarProducto = (idProd: number): boolean => {
    const index = productos.findIndex(prod => prod.idProd === idProd);
    if (index !== -1) {
        productos.splice(index, 1);
        return true;
    }
    return false;
};
