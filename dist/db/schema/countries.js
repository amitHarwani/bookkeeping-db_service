"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.countries = void 0;
const drizzle_orm_1 = require("drizzle-orm");
const pg_core_1 = require("drizzle-orm/pg-core");
exports.countries = (0, pg_core_1.pgTable)('countries', {
    countryId: (0, pg_core_1.serial)('country_id').primaryKey(),
    countryName: (0, pg_core_1.varchar)('country_name').unique().notNull(),
    phoneNumberCodes: (0, pg_core_1.varchar)('phone_number_codes').array().default((0, drizzle_orm_1.sql) `ARRAY[]::text[]`),
    currency: (0, pg_core_1.varchar)('currency').notNull(),
    maxPhoneNumberDigits: (0, pg_core_1.integer)('max_phone_number_digits').notNull(),
    timezone: (0, pg_core_1.varchar)("timezone").notNull()
});
