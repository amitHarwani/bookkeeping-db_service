"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.quotations = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const users_1 = require("./users");
const third_parties_1 = require("./third_parties");
exports.quotations = (0, pg_core_1.pgTable)("quotations", {
    quotationId: (0, pg_core_1.serial)("quotation_id").primaryKey(),
    quotationNumber: (0, pg_core_1.integer)("quotation_number").notNull(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    createdBy: (0, pg_core_1.uuid)("created_by").references(() => users_1.users.userId),
    partyId: (0, pg_core_1.integer)("party_id").references(() => third_parties_1.thirdParties.partyId).notNull(),
    partyName: (0, pg_core_1.varchar)("party_name").notNull(),
    subtotal: (0, pg_core_1.numeric)("subtotal").notNull(),
    discount: (0, pg_core_1.numeric)("discount").notNull().default("0"),
    totalAfterDiscount: (0, pg_core_1.numeric)("total_after_discount").notNull(),
    tax: (0, pg_core_1.numeric)("tax").notNull().default("0"),
    taxPercent: (0, pg_core_1.decimal)("tax_percent").notNull().default("0"),
    taxName: (0, pg_core_1.varchar)("tax_name").notNull().default(""),
    companyTaxNumber: (0, pg_core_1.varchar)("company_tax_number").default(""),
    partyTaxNumber: (0, pg_core_1.varchar)("party_tax_number").default(""),
    totalAfterTax: (0, pg_core_1.numeric)("total_after_tax").notNull(),
    saleId: (0, pg_core_1.integer)("sale_id"),
    createdAt: (0, pg_core_1.timestamp)("created_at", { withTimezone: false }).defaultNow(),
    updatedAt: (0, pg_core_1.timestamp)("updated_at", { withTimezone: false }).defaultNow(),
}, (table) => {
    return {
        unique: (0, pg_core_1.unique)().on(table.companyId, table.quotationNumber)
    };
});
