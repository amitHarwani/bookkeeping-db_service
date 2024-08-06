import { defineConfig } from 'drizzle-kit';
import dotenv from "dotenv";
dotenv.config();
dotenv.config({path: `.env.${process.env.NODE_ENV}`})

export default defineConfig({
  schema: './db/schema',
  out: './db/migrations',
  dialect: 'postgresql',
  dbCredentials: {
    host: process.env.DB_HOST as string,
    user: process.env.DB_USER as string,
    password: process.env.DB_PASSWORD as string,
    database: process.env.DB_NAME as string,
  },
});