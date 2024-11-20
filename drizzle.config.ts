import { defineConfig } from 'drizzle-kit';
import dotenv from "dotenv";
import fs from "fs"
dotenv.config();
dotenv.config({path: `.env.${process.env.NODE_ENV}`})

let DB_PASSWORD = "";

try{
  /* Password from file or enviornment variable */
  DB_PASSWORD = process.env.DB_PASSWORD || fs.readFileSync(process.env.DB_PASSWORD_FILE || "", 'utf-8');
}
catch(err){
  console.log("DB_PASSWORD NOT FOUND, IGNORE IF BUILDING DOCKER IMAGE");
}
export default defineConfig({
  schema: './db/schema',
  out: './db/migrations',
  dialect: 'postgresql',
  dbCredentials: {
    host: process.env.DB_HOST as string,
    user: process.env.DB_USER as string,
    password: DB_PASSWORD,
    database: process.env.DB_NAME as string,
  },
});