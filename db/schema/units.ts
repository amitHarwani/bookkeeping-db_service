import { pgTable, serial, varchar } from "drizzle-orm/pg-core";


export const units = pgTable("units", {
    unitId: serial("unit_id").primaryKey(),
    unitName: varchar("unit_name").unique().notNull()
})