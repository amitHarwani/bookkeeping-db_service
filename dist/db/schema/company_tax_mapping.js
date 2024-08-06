"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.companyTaxMapping = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const countries_1 = require("./countries");
const tax_details_1 = require("./tax_details");
exports.companyTaxMapping = (0, pg_core_1.pgTable)("company_tax_mapping", {
    companyId: (0, pg_core_1.integer)('company_id').references(() => countries_1.countries.countryId).notNull(),
    taxId: (0, pg_core_1.integer)('tax_id').references(() => tax_details_1.taxDetails.taxId).notNull(),
    registrationNumber: (0, pg_core_1.varchar)('registration_number').notNull()
}, (table) => {
    return {
        companyTaxMappingPK: (0, pg_core_1.primaryKey)({ columns: [table.companyId, table.taxId] })
    };
});
