import { decimal, integer, numeric, pgTable, serial, timestamp, unique, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { purchases } from "./purchases";


export const purchaseReturns = pgTable("purchase_returns", {
    purchaseReturnId: serial("purchase_return_id").primaryKey(),
    purchaseReturnNumber: integer("purchase_return_number").notNull(),
    purchaseId: integer("purchase_id").references(() => purchases.purchaseId).notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    subtotal: numeric("subtotal").notNull(),
    tax: numeric("tax").notNull().default("0"),
    taxPercent: decimal("tax_percent").notNull().default("0"),
    taxName: varchar("tax_name").notNull().default(""),
    totalAfterTax: numeric("total_after_tax").notNull(),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
}, (table) => {
    return {
        unique: unique().on(table.companyId, table.purchaseReturnNumber)
    }
})