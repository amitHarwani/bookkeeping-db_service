"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.userCompanyMapping = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const users_1 = require("./users");
const companies_1 = require("./companies");
const roles_1 = require("./roles");
const drizzle_orm_1 = require("drizzle-orm");
exports.userCompanyMapping = (0, pg_core_1.pgTable)('user_company_mapping', {
    id: (0, pg_core_1.serial)('id').primaryKey(),
    userId: (0, pg_core_1.uuid)('user_id').references(() => users_1.users.userId),
    companyId: (0, pg_core_1.integer)('company_id').references(() => companies_1.companies.companyId),
    roleId: (0, pg_core_1.integer)('role_id').references(() => roles_1.roles.roleId),
    acl: (0, pg_core_1.integer)('acl').array().default((0, drizzle_orm_1.sql) `ARRAY[]::integer[]`)
}, (table) => {
    return {
        userCompanyMappingUNIQUE: (0, pg_core_1.unique)().on(table.userId, table.companyId, table.roleId)
    };
});
