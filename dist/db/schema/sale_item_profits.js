"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.saleItemProfits = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const sales_1 = require("./sales");
const items_1 = require("./items");
const drizzle_orm_1 = require("drizzle-orm");
const companies_1 = require("./companies");
exports.saleItemProfits = (0, pg_core_1.pgTable)("sale_item_profits", {
    saleId: (0, pg_core_1.integer)("sale_id").references(() => sales_1.sales.saleId),
    itemId: (0, pg_core_1.integer)("item_id").references(() => items_1.items.itemId),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId),
    totalProfit: (0, pg_core_1.numeric)("total_profit"),
    costOfItems: (0, pg_core_1.jsonb)("cost_of_items").array(),
    purchaseIds: (0, pg_core_1.integer)("purchase_ids").array().default((0, drizzle_orm_1.sql) `ARRAY[]::integer[]`),
    remainingUnitsForProfitCalc: (0, pg_core_1.numeric)("remaining_units_for_profit_calc"),
}, (table) => {
    return {
        pk: (0, pg_core_1.primaryKey)({ columns: [table.saleId, table.itemId] })
    };
});
