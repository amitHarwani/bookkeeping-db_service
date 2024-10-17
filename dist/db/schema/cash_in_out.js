"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.cashInOut = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const purchases_1 = require("./purchases");
const sales_1 = require("./sales");
exports.cashInOut = (0, pg_core_1.pgTable)("cash_in_out", {
    transactionDateTime: (0, pg_core_1.timestamp)("transaction_date_time", { withTimezone: false }).notNull(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    cashIn: (0, pg_core_1.numeric)("cash_in").default("0").notNull(),
    cashOut: (0, pg_core_1.numeric)("cash_out").default("0").notNull(),
    purchaseId: (0, pg_core_1.integer)("purchase_id").references(() => purchases_1.purchases.purchaseId),
    saleId: (0, pg_core_1.integer)("sale_id").references(() => sales_1.sales.saleId),
}, (table) => {
    return {
        transactionDateTimeIndex: (0, pg_core_1.index)("transaction_date_time_index").on(table.transactionDateTime),
        companyIdIndex: (0, pg_core_1.index)("company_id_index").on(table.companyId)
    };
});
