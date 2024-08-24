"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.items = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const units_1 = require("./units");
exports.items = (0, pg_core_1.pgTable)("items", {
    itemId: (0, pg_core_1.serial)("item_id").primaryKey(),
    itemName: (0, pg_core_1.varchar)("item_name").notNull(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    unitId: (0, pg_core_1.integer)("unit_id").references(() => units_1.units.unitId).notNull(),
    unitName: (0, pg_core_1.varchar)("unit_name").notNull(),
    defaultSellingPrice: (0, pg_core_1.numeric)("default_selling_price"),
    defaultPurchasePrice: (0, pg_core_1.numeric)("default_purchase_price"),
    stock: (0, pg_core_1.numeric)("stock").notNull(),
    minStockToMaintain: (0, pg_core_1.bigint)("min_stock_to_maintain", { mode: "number" }),
    isActive: (0, pg_core_1.boolean)("is_active").default(true),
    priceHistoryOfCurrentStock: (0, pg_core_1.jsonb)("price_history_of_current_stock").array(),
    createdAt: (0, pg_core_1.timestamp)("created_at", { withTimezone: false }).defaultNow(),
    updatedAt: (0, pg_core_1.timestamp)("updated_at", { withTimezone: false }).defaultNow()
});
