import { drizzle } from 'drizzle-orm/postgres-js';
import { migrate } from 'drizzle-orm/postgres-js/migrator';
import postgres from 'postgres';

// for migrations

async function main(){
    const migrationClient = postgres(process.env.DB_URL as string, { max: 1 });
    await migrate(drizzle(migrationClient), {migrationsFolder: "./src/db/migrations"});
    await migrationClient.end();
}

main();