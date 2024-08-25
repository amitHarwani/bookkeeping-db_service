import { integer, jsonb, pgTable, serial, timestamp, varchar,boolean } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { countries } from "./countries";


export const thirdParties = pgTable("third_parties", {
    partyId: serial("party_id").primaryKey(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    partyName: varchar("party_name").notNull(),
    defaultSaleCreditAllowanceInDays: integer("default_sale_credit_allowance_indays").notNull(),
    defaultPurchaseCreditAllowanceInDays: integer("default_purchase_credit_allowance_indays").notNull(),
    countryId: integer("country_id").references(() => countries.countryId).notNull(),
    phoneNumber: varchar("phone_number"),
    taxDetails: jsonb("tax_details").array(),
    isActive: boolean("is_active").default(true),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow(),
    updatedAt: timestamp("updated_at", {withTimezone: false}).defaultNow()
})
