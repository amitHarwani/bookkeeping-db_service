import { boolean, decimal, integer, numeric, pgTable, serial, timestamp, varchar } from "drizzle-orm/pg-core";
import { sales } from "./sales";
import { thirdParties } from "./third_parties";
import { companies } from "./companies";


export const saleReturns = pgTable("sale_returns", {
    saleReturnId: serial("sale_return_id").primaryKey(),
    saleReturnNumber: integer("sale_return_number").notNull(),
    saleId: integer("sale_id").references(() => sales.saleId).notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    subtotal: numeric("subtotal").notNull(),
    tax: numeric("tax").notNull().default("0"),
    taxPercent: decimal("tax_percent").notNull().default("0"),
    taxName: varchar("tax_name").notNull().default(""),
    totalAfterTax: numeric("total_after_tax").notNull(),
    companyTaxNumber: varchar("company_tax_number").default(""),
    partyTaxNumber: varchar("party_tax_number").default(""),
    partyId: integer("party_id").references(() => thirdParties.partyId),
    partyName: varchar("party_name"),
    isNoPartyBill: boolean("is_no_party_bill").default(false).notNull(),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
})