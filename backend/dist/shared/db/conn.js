import { MongoClient } from "mongodb";
const connectionStr = process.env.MONGO_URI || 'mongodb://admin:secretpassword@localhost:27017/';
const cli = new MongoClient(connectionStr);
await cli.connect();
export let db = cli.db('mi_base');
/*// src/shared/db/conn.ts
import { MongoClient, Db } from "mongodb";
import dotenv from "dotenv";

dotenv.config();

const connectionStr = process.env.MONGO_URI || "mongodb://127.0.0.1:27017";
const dbName = process.env.MONGO_DB || "mi_base";

const client = new MongoClient(connectionStr);

export let db: Db;

export async function connectDB(): Promise<Db> {
 try {
   await client.connect();
   db = client.db(dbName);
   console.log("🟢 Conectado a MongoDB:", db.databaseName);
   return db;
 } catch (error) {
   console.error("🔴 Error conectando a MongoDB:", error);
   process.exit(1); // Detiene la app si no puede conectarse
 }
}
*/
//# sourceMappingURL=conn.js.map