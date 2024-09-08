import { decimal, integer, jsonb, numeric, pgTable, primaryKey, timestamp, varchar } from "drizzle-orm/pg-core";
import { sales } from "./sales";
import { items } from "./items";
import { companies } from "./companies";
import { units } from "./units";
import { sql } from "drizzle-orm";


export const saleItems = pgTable("sale_items", {
    saleId: integer("sale_id").references(() => sales.saleId).notNull(),
    itemId: integer("item_id").references(() => items.itemId).notNull(),
    itemName: varchar("item_name").notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    unitId: integer("unit_id").references(() => units.unitId).notNull(),
    unitName: varchar("unit_name").notNull(),
    unitsSold: numeric("units_sold").notNull(),
    pricePerUnit: numeric("price_per_unit").notNull(),
    subtotal: numeric("subtotal").notNull(),
    tax: numeric("tax").notNull().default("0"),
    taxPercent: decimal("tax_percent").notNull(),
    totalAfterTax: numeric("total_after_tax").notNull(),
    totalProfit: numeric("total_profit"),
    costOfItems: jsonb("cost_of_items").array(),
    purchaseIds: integer("purchase_ids").array().default(sql`ARRAY[]::integer[]`),
    remainingUnitsForProfitCalc: numeric("remaining_units_for_profit_calc"),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
    updatedAt: timestamp("updated_at", {withTimezone: false}).defaultNow(),
}, (table) => {
    return {
        PK: primaryKey({columns: [table.saleId, table.itemId]})
    }
})