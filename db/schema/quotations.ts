import { decimal, integer, numeric, pgTable, serial, timestamp, unique, uuid, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { users } from "./users";
import { thirdParties } from "./third_parties";


export const quotations = pgTable("quotations", {
    quotationId: serial("quotation_id").primaryKey(),
    quotationNumber: integer("quotation_number").notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    createdBy: uuid("created_by").references(() => users.userId),
    partyId: integer("party_id").references(() => thirdParties.partyId).notNull(),
    partyName: varchar("party_name").notNull(),
    subtotal: numeric("subtotal").notNull(),
    discount: numeric("discount").notNull().default("0"),
    totalAfterDiscount: numeric("total_after_discount").notNull(),
    tax: numeric("tax").notNull().default("0"),
    taxPercent: decimal("tax_percent").notNull().default("0"),
    taxName: varchar("tax_name").notNull().default(""),
    totalAfterTax: numeric("total_after_tax").notNull(),
    saleId: integer("sale_id"),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
    updatedAt: timestamp("updated_at", {withTimezone: false}).defaultNow(),
}, (table) => {
    return {
        unique: unique().on(table.companyId, table.quotationNumber)
    }
})