import { integer, jsonb, numeric, pgTable, primaryKey, varchar } from "drizzle-orm/pg-core";
import { itemTransfers } from "./item_transfers";
import { items } from "./items";
import { units } from "./units";


export const transferItems = pgTable("transfer_items", {
    transferId: integer("transfer_id").references(() => itemTransfers.transferId).notNull(),
    itemId: integer("item_id").references(() => items.itemId).notNull(),
    itemName: varchar("item_name").notNull(),
    unitId: integer("unit_id").references(() => units.unitId).notNull(),
    unitName: varchar("unit_name").notNull(),
    unitsTransferred: numeric("units_transferred").notNull(),
    priceHistoryOfStockTransferred: jsonb("price_history_of_stock_transferred").array()
}, (table) => {
    return {
        pk: primaryKey({columns: [table.transferId, table.itemId]})
    }
}
)