"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.transferItems = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const transfers_1 = require("./transfers");
const items_1 = require("./items");
const units_1 = require("./units");
exports.transferItems = (0, pg_core_1.pgTable)("transfer_items", {
    transferId: (0, pg_core_1.integer)("transfer_id").references(() => transfers_1.transfers.transferId).notNull(),
    itemId: (0, pg_core_1.integer)("item_id").references(() => items_1.items.itemId).notNull(),
    itemName: (0, pg_core_1.varchar)("item_name").notNull(),
    unitId: (0, pg_core_1.integer)("unit_id").references(() => units_1.units.unitId).notNull(),
    unitName: (0, pg_core_1.varchar)("unit_name").notNull(),
    unitsTransferred: (0, pg_core_1.numeric)("units_transferred").notNull(),
    priceHistoryOfStockTransferred: (0, pg_core_1.jsonb)("price_history_of_stock_transferred").array()
}, (table) => {
    return {
        pk: (0, pg_core_1.primaryKey)({ columns: [table.transferId, table.itemId] })
    };
});
