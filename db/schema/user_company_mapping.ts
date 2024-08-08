import { integer, pgTable, primaryKey, uuid, varchar, serial, unique } from "drizzle-orm/pg-core";
import { users } from "./users";
import { companies } from "./companies";
import { roles } from "./roles";
import { sql } from "drizzle-orm";


export const userCompanyMapping = pgTable('user_company_mapping', {
    id: serial('id').primaryKey(),
    userId: uuid('user_id').references(() => users.userId),
    companyId: integer('company_id').references(() => companies.companyId),
    roleId: integer('role_id').references(() => roles.roleId),
    acl: integer('acl').array().default(sql`ARRAY[]::integer[]`)
}, (table) => {
    return {
        userCompanyMappingUNIQUE: unique().on(table.userId, table.companyId, table.roleId)
    }
})