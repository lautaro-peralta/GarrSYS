import express from 'express';
import productoRoutes from './routes/ProductoRoutes';
import { productoRouter } from './producto/producto.routes';
const app = express();
const PORT = 3000;

// Middleware para parsear JSON
app.use(express.json());

// Usar las rutas de productos
app.use("/productos", productoRoutes);
app.use('/api/productos', productoRouter);


// Iniciar servidor
app.listen(PORT, () => {
    console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
