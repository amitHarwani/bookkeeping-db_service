"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.returnItems = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const items_1 = require("./items");
const returns_1 = require("./returns");
const units_1 = require("./units");
exports.returnItems = (0, pg_core_1.pgTable)("return_items", {
    returnId: (0, pg_core_1.integer)("return_id").references(() => returns_1.returns.returnId).notNull(),
    itemId: (0, pg_core_1.integer)("item_id").references(() => items_1.items.itemId).notNull(),
    itemName: (0, pg_core_1.varchar)("item_name").notNull(),
    unitId: (0, pg_core_1.integer)("unit_id").references(() => units_1.units.unitId).notNull(),
    unitName: (0, pg_core_1.varchar)("unit_name").notNull(),
    unitsReturned: (0, pg_core_1.numeric)("units_returned").notNull(),
    pricePerUnit: (0, pg_core_1.numeric)("price_per_unit").notNull(),
    subtotal: (0, pg_core_1.numeric)("subtotal").notNull(),
    taxPercent: (0, pg_core_1.decimal)("tax_percent").notNull(),
    totalAfterTax: (0, pg_core_1.numeric)("total_after_tax").notNull(),
    dateTimeOfReturn: (0, pg_core_1.timestamp)("date_time_of_return", { withTimezone: false }).defaultNow()
}, (table) => {
    return {
        pk: (0, pg_core_1.primaryKey)({ columns: [table.returnId, table.itemId] })
    };
});
