"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.roles = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
exports.roles = (0, pg_core_1.pgTable)('roles', {
    roleId: (0, pg_core_1.serial)('role_id').primaryKey(),
    companyId: (0, pg_core_1.integer)('company_id').references(() => companies_1.companies.companyId),
    roleName: (0, pg_core_1.varchar)('role_name').notNull(),
});
