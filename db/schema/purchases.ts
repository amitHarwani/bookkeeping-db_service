import { bigserial, boolean, date, decimal, integer, numeric, pgTable, serial, timestamp, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { thirdParties } from "./third_parties";


export const purchases = pgTable("purchases", {
    purchaseId: bigserial("purchase_id", {mode: "bigint"}).primaryKey(),
    invoiceNumber: integer("invoice_number").notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    partyId: integer("party_id").references(() => thirdParties.partyId).notNull(),
    partyName: varchar("party_name").notNull(),
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
    receiptNumber: varchar("receipt_number"),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
    updatedAt: timestamp("updated_at", {withTimezone: false}).defaultNow(),
})