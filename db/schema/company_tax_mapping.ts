import { integer, pgTable, primaryKey, varchar } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { taxDetails } from "./tax_details";


export const companyTaxMapping = pgTable("company_tax_mapping", {
    companyId: integer('company_id').references(() => companies.companyId).notNull(),
    taxId: integer('tax_id').references(() => taxDetails.taxId).notNull(),
    registrationNumber: varchar('registration_number').notNull()
}, (table) => {
    return {
        companyTaxMappingPK: primaryKey({columns: [table.companyId, table.taxId]})
    }
})