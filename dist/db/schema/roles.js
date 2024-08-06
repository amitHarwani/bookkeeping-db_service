"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.roles = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const drizzle_orm_1 = require("drizzle-orm");
exports.roles = (0, pg_core_1.pgTable)('roles', {
    roleId: (0, pg_core_1.serial)('role_id').primaryKey(),
    companyId: (0, pg_core_1.integer)('company_id').references(() => companies_1.companies.companyId),
    roleName: (0, pg_core_1.varchar)('role_name').notNull(),
    acl: (0, pg_core_1.integer)('acl').array().default((0, drizzle_orm_1.sql) `ARRAY[]::integer[]`)
});
