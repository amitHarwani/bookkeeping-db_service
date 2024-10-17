import { index, integer, numeric, pgTable, timestamp } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { purchases } from "./purchases";
import { sales } from "./sales";
import { saleReturns } from "./sale_returns";


export const cashInOut = pgTable("cash_in_out", {
    transactionDateTime: timestamp("transaction_date_time", {withTimezone: false}).notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    cashIn: numeric("cash_in").default("0").notNull(),
    cashOut: numeric("cash_out").default("0").notNull(),
    purchaseId: integer("purchase_id").references(() => purchases.purchaseId),
    saleId: integer("sale_id").references(() => sales.saleId),
    saleReturnId: integer("sale_return_id").references(() => saleReturns.saleReturnId)
}, (table) => {
    return {
        transactionDateTimeIndex: index("transaction_date_time_index").on(table.transactionDateTime),
        companyIdIndex: index("company_id_index").on(table.companyId)
    }
})