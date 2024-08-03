import { sql } from "drizzle-orm";
import { integer, pgTable, serial, varchar } from "drizzle-orm/pg-core";


export const countries = pgTable('countries', {
    countryId: serial('country_id').primaryKey(),
    countryName: varchar('country_name').unique().notNull(),
    phoneNumberCodes: varchar('phone_number_codes').array().default(sql`ARRAY[]::text[]`),
    currency: varchar('currency').notNull(),
    maxPhoneNumberDigits: integer('max_phone_number_digits').notNull()
})