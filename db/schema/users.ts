import { boolean, integer, pgTable, timestamp, uuid, varchar } from "drizzle-orm/pg-core";
import { countries } from "./countries";


export const users = pgTable('users', {
    userId: uuid('user_id').defaultRandom().primaryKey(),
    fullName: varchar('full_name').notNull(),
    email: varchar('email').unique().notNull(),
    password: varchar('password').notNull(),
    refreshToken: varchar('refresh_token'),
    countryId: integer('country_id').references(() => countries.countryId),
    mobileNumber: varchar('mobile_number').notNull().unique(),
    isLoggedIn: boolean('is_logged_in').default(false),
    isSubUser: boolean('is_sub_user').default(false),
    isActive: boolean('is_active').default(true),
    createdAt: timestamp('created_at', {withTimezone: false}).defaultNow(),
    updatedAt: timestamp('updated_at', {withTimezone: false}).defaultNow()
})