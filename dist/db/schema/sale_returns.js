"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.saleReturns = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const sales_1 = require("./sales");
const companies_1 = require("./companies");
exports.saleReturns = (0, pg_core_1.pgTable)("sale_returns", {
    saleReturnId: (0, pg_core_1.serial)("sale_return_id").primaryKey(),
    saleReturnNumber: (0, pg_core_1.integer)("sale_return_number").notNull(),
    saleId: (0, pg_core_1.integer)("sale_id").references(() => sales_1.sales.saleId).notNull(),
    invoiceNumber: (0, pg_core_1.integer)("invoice_number").notNull(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    subtotal: (0, pg_core_1.numeric)("subtotal").notNull(),
    tax: (0, pg_core_1.numeric)("tax").notNull().default("0"),
    taxPercent: (0, pg_core_1.decimal)("tax_percent").notNull().default("0"),
    taxName: (0, pg_core_1.varchar)("tax_name").notNull().default(""),
    totalAfterTax: (0, pg_core_1.numeric)("total_after_tax").notNull(),
    createdAt: (0, pg_core_1.timestamp)("created_at", { withTimezone: false }).defaultNow(),
}, (table) => {
    return {
        unique: (0, pg_core_1.unique)().on(table.companyId, table.saleReturnNumber)
    };
});
