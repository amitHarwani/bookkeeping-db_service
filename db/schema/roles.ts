import { integer, jsonb, pgTable, serial, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { sql } from "drizzle-orm";


export const roles = pgTable('roles', {
    roleId: serial('role_id').primaryKey(),
    companyId: integer('company_id').references(() => companies.companyId),
    roleName: varchar('role_name').notNull(),
})