import { decimal, integer, numeric, pgTable, varchar, timestamp } from "drizzle-orm/pg-core";
import { saleReturns } from "./sale_returns";
import { items } from "./items";
import { companies } from "./companies";
import { units } from "./units";


export const saleReturnItems = pgTable("sale_return_items", {
    saleReturnId: integer("sale_return_id").references(() => saleReturns.saleReturnId).notNull(),
    itemId: integer("item_id").references(() => items.itemId).notNull(),
    itemName: varchar("item_name").notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    unitId: integer("unit_id").references(() => units.unitId).notNull(),
    unitName: varchar("unit_name").notNull(),
    unitsSold: numeric("units_sold").notNull(),
    pricePerUnit: numeric("price_per_unit").notNull(),
    subtotal: numeric("subtotal").notNull(),
    tax: numeric("tax").notNull().default("0"),
    taxPercent: decimal("tax_percent").notNull().default("0"),
    totalAfterTax: numeric("total_after_tax").notNull(),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
})