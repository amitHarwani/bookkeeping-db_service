"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.purchaseReturns = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const purchases_1 = require("./purchases");
exports.purchaseReturns = (0, pg_core_1.pgTable)("purchase_returns", {
    purchaseReturnId: (0, pg_core_1.serial)("purchase_return_id").primaryKey(),
    purchaseReturnNumber: (0, pg_core_1.integer)("purchase_return_number").notNull(),
    purchaseId: (0, pg_core_1.integer)("purchase_id").references(() => purchases_1.purchases.purchaseId).notNull(),
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
        unique: (0, pg_core_1.unique)().on(table.companyId, table.purchaseReturnNumber)
    };
});
