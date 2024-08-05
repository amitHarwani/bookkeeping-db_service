import { boolean, integer, jsonb, pgTable, serial, time, timestamp, uuid, varchar } from "drizzle-orm/pg-core";
import { countries } from "./countries";
import { CompanyTaxDetails } from "../custom_schema/company_tax_details";
import { users } from "./users";

export const companies = pgTable('companies', {
    companyId: serial('company_id').primaryKey(),
    companyName: varchar('company_name').unique().notNull(),
    countryId: integer('country_id').references(() => countries.countryId).notNull(),
    address: varchar('address').notNull(),
    phoneNumber: varchar('phone_number').notNull(),
    dayStartTime: time('day_start_time', {withTimezone: false}).notNull(),
    taxDetails: jsonb('tax_details').array().$type<CompanyTaxDetails[]>().notNull(),
    isMainBranch: boolean('is_main_branch').default(true),
    mainBranchId: integer('main_branch_id'),
    decimalRoundTo: integer('decimal_round_to').notNull(),
    createdBy: uuid('created_by').references(() => users.userId).notNull(),
    isActive: boolean('is_active').default(true),
    createdAt: timestamp('created_at', {withTimezone: false}).defaultNow(),
    updatedAt: timestamp('updated_at', {withTimezone: false}).defaultNow()
})