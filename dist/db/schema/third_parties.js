"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.thirdParties = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const countries_1 = require("./countries");
exports.thirdParties = (0, pg_core_1.pgTable)("third_parties", {
    partyId: (0, pg_core_1.serial)("party_id").primaryKey(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    partyName: (0, pg_core_1.varchar)("party_name").notNull(),
    defaultSaleCreditAllowanceInDays: (0, pg_core_1.integer)("default_sale_credit_allowance_indays").notNull(),
    defaultPurchaseCreditAllowanceInDays: (0, pg_core_1.integer)("default_purchase_credit_allowance_indays").notNull(),
    countryId: (0, pg_core_1.integer)("country_id").references(() => countries_1.countries.countryId).notNull(),
    phoneNumber: (0, pg_core_1.varchar)("phone_number"),
    taxDetails: (0, pg_core_1.jsonb)("tax_details").array(),
    isActive: (0, pg_core_1.boolean)("is_active").default(true),
    createdAt: (0, pg_core_1.timestamp)("created_at", { withTimezone: false }).defaultNow(),
    updatedAt: (0, pg_core_1.timestamp)("updated_at", { withTimezone: false }).defaultNow()
});
