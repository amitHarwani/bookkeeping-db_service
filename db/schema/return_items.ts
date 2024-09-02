import { decimal, integer, numeric, pgTable, primaryKey, timestamp, varchar } from "drizzle-orm/pg-core";
import { items } from "./items";
import { returns } from "./returns";
import { units } from "./units";



export const returnItems = pgTable("return_items", {
    returnId: integer("return_id").references(() => returns.returnId).notNull(),
    itemId: integer("item_id").references(() => items.itemId).notNull(),
    itemName: varchar("item_name").notNull(),
    unitId: integer("unit_id").references(() => units.unitId).notNull(),
    unitName: varchar("unit_name").notNull(),
    unitsReturned: numeric("units_returned").notNull(),
    pricePerUnit: numeric("price_per_unit").notNull(),
    subtotal: numeric("subtotal").notNull(),
    taxPercent: decimal("tax_percent").notNull(),
    totalAfterTax: numeric("total_after_tax").notNull(),
    dateTimeOfReturn: timestamp("date_time_of_return", {withTimezone: false}).defaultNow()
}, (table) => {
    return {
        pk: primaryKey({columns: [table.returnId, table.itemId]})
    }
})