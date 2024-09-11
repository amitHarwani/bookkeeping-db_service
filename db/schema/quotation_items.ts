import { decimal, integer, numeric, pgTable, primaryKey, timestamp, varchar } from "drizzle-orm/pg-core";
import { quotations } from "./quotations";
import { items } from "./items";
import { companies } from "./companies";
import { units } from "./units";

export const quotationItems = pgTable("quotation_items", {
    quotationId: integer("quotation_id").references(() => quotations.quotationId).notNull(),
    itemId: integer("item_id").references(() => items.itemId).notNull(),
    companyId: integer("company_id").references(() => companies.companyId),
    unitId: integer("unit_id").references(() => units.unitId).notNull(),
    unitName: varchar("unit_name").notNull(),
    unitsSold: numeric("units_sold").notNull(),
    pricePerUnit: numeric("price_per_unit").notNull(),
    subtotal: numeric("subtotal").notNull(),
    tax: numeric("tax").notNull().default("0"),
    taxPercent: decimal("tax_percent").notNull(),
    totalAfterTax: numeric("total_after_tax").notNull(),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
    updatedAt: timestamp("updated_at", {withTimezone: false}).defaultNow(),
},(table) => {
    return {
        PK: primaryKey({columns: [table.quotationId, table.itemId]})
    }
})