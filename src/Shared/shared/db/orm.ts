import { MikroORM, EntityManager, EntityRepository } from '@mikro-orm/mysql';
import { Producto } from '../../models/Producto'; 

export const DI = {} as {
    orm: MikroORM,
    em: EntityManager,
    productoRepo: EntityRepository<Producto>
};

export async function initORM() {
    DI.orm = await MikroORM.init({
        entities: [Producto],
        dbName: 'tu_base_de_datos',
        user: 'tu_usuario',
        password: 'tu_contraseña',
        host: 'localhost',
        port: 3306,
        type: 'mysql',
    });

    DI.em = DI.orm.em;
    DI.productoRepo = DI.orm.em.getRepository(Producto);
}
