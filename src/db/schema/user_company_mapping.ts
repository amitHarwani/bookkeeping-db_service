import { integer, pgTable, uuid, varchar } from "drizzle-orm/pg-core";
import { users } from "./users";
import { companies } from "./companies";
import { roles } from "./roles";


export const userCompanyMapping = pgTable('user_company_mapping', {
    userId: uuid('user_id').references(() => users.userId),
    companyId: integer('company_id').references(() => companies.companyId),
    roleId: integer('role_id').references(() => roles.roleId)
})