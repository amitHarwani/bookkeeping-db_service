import { bigint, boolean, integer, jsonb, numeric, pgTable, serial, timestamp, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { units } from "./units";


export const items = pgTable("items", {
    itemId: serial("item_id").primaryKey(),
    itemName: varchar("item_name").notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    unitId: integer("unit_id").references(() => units.unitId).notNull(),
    unitName: varchar("unit_name").notNull(),
    defaultSellingPrice: numeric("default_selling_price"),
    defaultPurchasePrice: numeric("default_purchase_price"),
    stock: numeric("stock").notNull(),
    minStockToMaintain: bigint("min_stock_to_maintain", {mode: "number"}),
    isActive: boolean("is_active").default(true),
    priceHistoryOfCurrentStock: jsonb("price_history_of_current_stock").array(),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
    updatedAt: timestamp("updated_at", {withTimezone: false}).defaultNow()
})