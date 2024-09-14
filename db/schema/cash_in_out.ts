import { integer, numeric, pgTable, timestamp } from "drizzle-orm/pg-core";
import { companies } from "./companies";


export const cashInOut = pgTable("cash_in_out", {
    transactionDateTime: timestamp("transaction_date_time", {withTimezone: false}).notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    cashIn: numeric("cash_in").default("0").notNull(),
    cashOut: numeric("cash_out").default("0").notNull()
})