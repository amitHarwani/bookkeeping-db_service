import { drizzle } from "drizzle-orm/postgres-js";
import { migrate } from "drizzle-orm/postgres-js/migrator";
import postgres from "postgres";
import dotenv from "dotenv";
import fs from "fs";
dotenv.config();
dotenv.config({ path: `.env.${process.env.NODE_ENV}` });
// for migrations

async function main() {
    /* DB url from file or enviornment variable */
    const DB_URL = (process.env.DB_URL ||
        fs.readFileSync(process.env.DB_URL_FILE as string, "utf-8")) as string;

    const migrationClient = postgres(DB_URL, { max: 1 });
    await migrate(drizzle(migrationClient), {
        migrationsFolder: "./db/migrations",
    });
    await migrationClient.end();
}

main();
