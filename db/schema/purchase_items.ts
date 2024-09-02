import { bigserial, decimal, integer, numeric, pgTable, primaryKey, timestamp, varchar } from "drizzle-orm/pg-core";
import { purchases } from "./purchases";
import { items } from "./items";
import { companies } from "./companies";
import { units } from "./units";


export const purchaseItems = pgTable("purchase_items", {
    purchaseId: bigserial("purchase_id", {mode: "bigint"}).references(() => purchases.purchaseId).notNull(),
    itemId: integer("item_id").references(() => items.itemId).notNull(),
    itemName: varchar("item_name").notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    unitId: integer("unit_id").references(() => units.unitId).notNull(),
    unitName: varchar("unit_name").notNull(),
    unitsPurchased: numeric("units_purchased").notNull(),
    pricePerUnit: numeric("price_per_unit").notNull(),
    subtotal: numeric("subtotal").notNull(),
    tax: numeric("tax").notNull().default("0"),
    taxPercent: decimal("tax_percent").notNull(),
    totalAfterTax: numeric("total_after_tax").notNull(),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
    updatedAt: timestamp("updated_at", {withTimezone: false}).defaultNow(),
}, (table) => {
    return {
        PK: primaryKey({columns: [table.purchaseId, table.itemId]})
    }
})