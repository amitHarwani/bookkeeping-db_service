"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.purchases = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const third_parties_1 = require("./third_parties");
exports.purchases = (0, pg_core_1.pgTable)("purchases", {
    purchaseId: (0, pg_core_1.bigserial)("purchase_id", { mode: "bigint" }).primaryKey(),
    invoiceNumber: (0, pg_core_1.integer)("invoice_number").notNull(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    partyId: (0, pg_core_1.integer)("party_id").references(() => third_parties_1.thirdParties.partyId).notNull(),
    partyName: (0, pg_core_1.varchar)("party_name").notNull(),
    subtotal: (0, pg_core_1.numeric)("subtotal").notNull(),
    discount: (0, pg_core_1.numeric)("discount").notNull().default("0"),
    totalAfterDiscount: (0, pg_core_1.numeric)("total_after_discount").notNull(),
    tax: (0, pg_core_1.numeric)("tax").notNull().default("0"),
    taxPercent: (0, pg_core_1.decimal)("tax_percent").notNull().default("0"),
    taxName: (0, pg_core_1.varchar)("tax_name").notNull().default(""),
    totalAfterTax: (0, pg_core_1.numeric)("total_after_tax").notNull(),
    isCredit: (0, pg_core_1.boolean)("is_credit").notNull().default(false),
    paymentDueDate: (0, pg_core_1.date)("payment_due_date"), /* For non credit transactions this will be null */
    amountPaid: (0, pg_core_1.numeric)("amount_paid").notNull(),
    amountDue: (0, pg_core_1.numeric)("amount_due").notNull(),
    isFullyPaid: (0, pg_core_1.boolean)("is_fully_paid").notNull().default(false),
    paymentCompletionDate: (0, pg_core_1.date)("payment_completion_date"),
    receiptNumber: (0, pg_core_1.varchar)("receipt_number"),
    createdAt: (0, pg_core_1.timestamp)("created_at", { withTimezone: false }).defaultNow(),
    updatedAt: (0, pg_core_1.timestamp)("updated_at", { withTimezone: false }).defaultNow(),
});
