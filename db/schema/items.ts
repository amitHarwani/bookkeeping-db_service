import { bigint, boolean, integer, jsonb, numeric, pgTable, serial, timestamp, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { units } from "./units";


export const items = pgTable("items", {
    itemId: serial("item_id").primaryKey(),
    itemName: varchar("item_name").notNull(),
    companyId: integer("company_id").references(() => companies.companyId),
    unitId: integer("unit_id").references(() => units.unitId),
    defaultSellingPrice: numeric("default_selling_price"),
    defaultPurchasePrice: numeric("default_purchase_price"),
    stock: bigint("stock", {mode: "number"}),
    minStockToMaintain: bigint("min_stock_to_maintain", {mode: "number"}),
    isActive: boolean("is_active").default(true),
    priceHistoryOfCurrentStock: jsonb("price_history_of_current_stock").array(),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
    updatedAt: timestamp("updated_at", {withTimezone: false}).defaultNow()
})