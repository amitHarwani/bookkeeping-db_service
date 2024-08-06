"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.userCompanyMapping = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const users_1 = require("./users");
const companies_1 = require("./companies");
const roles_1 = require("./roles");
exports.userCompanyMapping = (0, pg_core_1.pgTable)('user_company_mapping', {
    id: (0, pg_core_1.serial)('id').primaryKey(),
    userId: (0, pg_core_1.uuid)('user_id').references(() => users_1.users.userId),
    companyId: (0, pg_core_1.integer)('company_id').references(() => companies_1.companies.companyId),
    roleId: (0, pg_core_1.integer)('role_id').references(() => roles_1.roles.roleId)
});
