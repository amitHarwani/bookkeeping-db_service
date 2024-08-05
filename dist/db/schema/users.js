"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.users = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const countries_1 = require("./countries");
exports.users = (0, pg_core_1.pgTable)('users', {
    userId: (0, pg_core_1.uuid)('user_id').primaryKey(),
    fullName: (0, pg_core_1.varchar)('full_name').notNull(),
    email: (0, pg_core_1.varchar)('email').unique().notNull(),
    password: (0, pg_core_1.varchar)('password').notNull(),
    refreshToken: (0, pg_core_1.varchar)('refresh_token'),
    countryId: (0, pg_core_1.integer)('country_id').references(() => countries_1.countries.countryId),
    mobileNumber: (0, pg_core_1.varchar)('mobile_number').notNull().unique(),
    isLoggedIn: (0, pg_core_1.boolean)('is_logged_in').default(false),
    isSubUser: (0, pg_core_1.boolean)('is_sub_user').default(false),
    isActive: (0, pg_core_1.boolean)('is_active').default(true),
    createdAt: (0, pg_core_1.timestamp)('created_at', { withTimezone: false }).defaultNow(),
    updatedAt: (0, pg_core_1.timestamp)('updated_at', { withTimezone: false }).defaultNow()
});
