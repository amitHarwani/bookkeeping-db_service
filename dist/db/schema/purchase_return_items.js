"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.purchaseReturnItems = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const items_1 = require("./items");
const purchase_returns_1 = require("./purchase_returns");
const units_1 = require("./units");
exports.purchaseReturnItems = (0, pg_core_1.pgTable)("purchase_return_items", {
    purchaseReturnId: (0, pg_core_1.integer)("purchase_return_id").references(() => purchase_returns_1.purchaseReturns.purchaseReturnId).notNull(),
    itemId: (0, pg_core_1.integer)("item_id").references(() => items_1.items.itemId).notNull(),
    itemName: (0, pg_core_1.varchar)("item_name").notNull(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    unitId: (0, pg_core_1.integer)("unit_id").references(() => units_1.units.unitId).notNull(),
    unitName: (0, pg_core_1.varchar)("unit_name").notNull(),
    unitsPurchased: (0, pg_core_1.numeric)("units_purchased").notNull(),
    pricePerUnit: (0, pg_core_1.numeric)("price_per_unit").notNull(),
    subtotal: (0, pg_core_1.numeric)("subtotal").notNull(),
    tax: (0, pg_core_1.numeric)("tax").notNull().default("0"),
    taxPercent: (0, pg_core_1.decimal)("tax_percent").notNull().default("0"),
    totalAfterTax: (0, pg_core_1.numeric)("total_after_tax").notNull(),
    createdAt: (0, pg_core_1.timestamp)("created_at", { withTimezone: false }).defaultNow(),
}, (table) => {
    return {
        PK: (0, pg_core_1.primaryKey)({ columns: [table.purchaseReturnId, table.itemId] })
    };
});
