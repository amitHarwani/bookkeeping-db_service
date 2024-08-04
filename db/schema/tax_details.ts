import { decimal, integer, pgTable, serial, varchar, boolean } from "drizzle-orm/pg-core";
import { countries } from "./countries";


export const taxDetails = pgTable('tax_details', {
    taxId: serial('tax_id').primaryKey(),
    countryId: integer('country_id').references(() => countries.countryId).notNull(),
    taxName: varchar('tax_name').notNull(),
    taxPercentage: decimal('tax_percentage').notNull(),
    taxNickname: varchar('tax_nickname').notNull(),
    isTaxOnInvoice: boolean('is_tax_on_invoice').default(false),
    isRegistrationOptional: boolean('is_registration_optional').default(true)
})