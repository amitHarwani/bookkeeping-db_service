import { integer, pgTable, serial, timestamp, uuid, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { users } from "./users";


export const itemTransfers = pgTable("item_transfers", {
    transferId: serial("transfer_id").primaryKey(),
    fromCompanyId: integer("from_company_id").references(() => companies.companyId).notNull(),
    toCompanyId: integer("to_company_id").references(() => companies.companyId).notNull(),
    fromCompanyName: varchar("from_company_name").notNull(),
    toCompanyName: varchar("to_company_name").notNull(),
    doneBy: uuid("done_by").references(() => users.userId).notNull(),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow().notNull()
})