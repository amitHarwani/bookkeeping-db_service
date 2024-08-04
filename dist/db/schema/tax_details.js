"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.taxDetails = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const countries_1 = require("./countries");
exports.taxDetails = (0, pg_core_1.pgTable)('tax_details', {
    taxId: (0, pg_core_1.serial)('tax_id').primaryKey(),
    countryId: (0, pg_core_1.integer)('country_id').references(() => countries_1.countries.countryId).notNull(),
    taxName: (0, pg_core_1.varchar)('tax_name').notNull(),
    taxPercentage: (0, pg_core_1.decimal)('tax_percentage').notNull(),
    taxNickname: (0, pg_core_1.varchar)('tax_nickname').notNull(),
    isTaxOnInvoice: (0, pg_core_1.boolean)('is_tax_on_invoice').default(false),
    isRegistrationOptional: (0, pg_core_1.boolean)('is_registration_optional').default(true)
});
