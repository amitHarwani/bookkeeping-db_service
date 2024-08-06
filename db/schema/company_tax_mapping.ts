import { integer, pgTable, primaryKey, varchar } from "drizzle-orm/pg-core";
import { countries } from "./countries";
import { taxDetails } from "./tax_details";


export const companyTaxMapping = pgTable("company_tax_mapping", {
    companyId: integer('company_id').references(() => countries.countryId).notNull(),
    taxId: integer('tax_id').references(() => taxDetails.taxId).notNull(),
    registrationNumber: varchar('registration_number').notNull()
}, (table) => {
    return {
        companyTaxMappingPK: primaryKey({columns: [table.companyId, table.taxId]})
    }
})