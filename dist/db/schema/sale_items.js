"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.saleItems = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const sales_1 = require("./sales");
const items_1 = require("./items");
const companies_1 = require("./companies");
const units_1 = require("./units");
exports.saleItems = (0, pg_core_1.pgTable)("sale_items", {
    saleId: (0, pg_core_1.integer)("sale_id").references(() => sales_1.sales.saleId).notNull(),
    itemId: (0, pg_core_1.integer)("item_id").references(() => items_1.items.itemId).notNull(),
    itemName: (0, pg_core_1.varchar)("item_name").notNull(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    unitId: (0, pg_core_1.integer)("unit_id").references(() => units_1.units.unitId).notNull(),
    unitName: (0, pg_core_1.varchar)("unit_name").notNull(),
    unitsSold: (0, pg_core_1.numeric)("units_sold").notNull(),
    pricePerUnit: (0, pg_core_1.numeric)("price_per_unit").notNull(),
    subtotal: (0, pg_core_1.numeric)("subtotal").notNull(),
    tax: (0, pg_core_1.numeric)("tax").notNull().default("0"),
    taxPercent: (0, pg_core_1.decimal)("tax_percent").notNull(),
    totalAfterTax: (0, pg_core_1.numeric)("total_after_tax").notNull(),
    createdAt: (0, pg_core_1.timestamp)("created_at", { withTimezone: false }).defaultNow(),
    updatedAt: (0, pg_core_1.timestamp)("updated_at", { withTimezone: false }).defaultNow(),
}, (table) => {
    return {
        PK: (0, pg_core_1.primaryKey)({ columns: [table.saleId, table.itemId] })
    };
});
