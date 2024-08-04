"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.companies = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const countries_1 = require("./countries");
const users_1 = require("./users");
exports.companies = (0, pg_core_1.pgTable)('companies', {
    companyId: (0, pg_core_1.serial)('company_id').primaryKey(),
    companyName: (0, pg_core_1.varchar)('company_name').unique().notNull(),
    countryId: (0, pg_core_1.integer)('country_id').references(() => countries_1.countries.countryId).notNull(),
    address: (0, pg_core_1.varchar)('address').notNull(),
    phoneNumber: (0, pg_core_1.varchar)('phone_number').notNull(),
    dayStartTime: (0, pg_core_1.time)('day_start_time', { withTimezone: false }).notNull(),
    taxDetails: (0, pg_core_1.jsonb)('tax_details').array().$type().notNull(),
    isMainBranch: (0, pg_core_1.boolean)('is_main_branch').default(true),
    mainBranchId: (0, pg_core_1.integer)('main_branch_id'),
    decimalRoundTo: (0, pg_core_1.integer)('decimal_round_to').notNull(),
    createdBy: (0, pg_core_1.uuid)('created_by').references(() => users_1.users.userId).notNull(),
    createdAt: (0, pg_core_1.timestamp)('created_at', { withTimezone: false }).defaultNow(),
    updatedAt: (0, pg_core_1.timestamp)('updated_at', { withTimezone: false }).defaultNow()
});
