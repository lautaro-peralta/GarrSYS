import { MySqlDriver } from '@mikro-orm/mysql';
import { SqlHighlighter } from '@mikro-orm/sql-highlighter';
export default {
    driver: MySqlDriver,
    entities: ['dist/**/*.entity.js'],
    entitiesTs: ['src/**/*.entity.ts'],
    dbName: 'tpdesarrollo',
    user: 'dsw',
    password: 'dsw',
    host: 'localhost',
    port: 3307,
    highlighter: new SqlHighlighter(),
    debug: true,
    migrations: {
        path: './src/migrations',
        snapshot: false,
        disableForeignKeys: false
    },
    schemaGenerator: {
        disableForeignKeys: false,
        createForeignKeyConstraints: true,
        ignoreSchema: []
    },
};
//# sourceMappingURL=orm.config.js.map