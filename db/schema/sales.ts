import { boolean, date, decimal, integer, numeric, pgTable, serial, timestamp, unique, uuid, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { thirdParties } from "./third_parties";
import { users } from "./users";


export const sales = pgTable("sales", {
    saleId: serial("sale_id").primaryKey(),
    invoiceNumber: integer("invoice_number").notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    partyId: integer("party_id").references(() => thirdParties.partyId),
    partyName: varchar("party_name"),
    isNoPartyBill: boolean("is_no_party_bill").default(false).notNull(),
    doneBy: uuid("done_by").references(() => users.userId),
    subtotal: numeric("subtotal").notNull(),
    discount: numeric("discount").notNull().default("0"),
    totalAfterDiscount: numeric("total_after_discount").notNull(),
    tax: numeric("tax").notNull().default("0"),
    taxPercent: decimal("tax_percent").notNull().default("0"),
    taxName: varchar("tax_name").notNull().default(""),
    totalAfterTax: numeric("total_after_tax").notNull(),
    isCredit: boolean("is_credit").notNull().default(false),
    paymentDueDate: date("payment_due_date"), /* For non credit transactions this will be null */
    amountPaid: numeric("amount_paid").notNull(),
    amountDue: numeric("amount_due").notNull(),
    isFullyPaid: boolean("is_fully_paid").notNull().default(false),
    paymentCompletionDate: date("payment_completion_date"),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
    updatedAt: timestamp("updated_at", {withTimezone: false}).defaultNow(),

}, (table) => {
    return {
        unique: unique().on(table.companyId, table.invoiceNumber)
    }
})