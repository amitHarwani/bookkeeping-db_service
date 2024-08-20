import { integer, pgTable, serial, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";


export const units = pgTable("units", {
    unitId: serial("unit_id").primaryKey(),
    unitName: varchar("unit_name").notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull()
})