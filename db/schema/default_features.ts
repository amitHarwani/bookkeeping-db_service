import { sql } from "drizzle-orm";
import { integer, pgEnum, pgTable, serial } from "drizzle-orm/pg-core";

export const userTypes = pgEnum('user_types', ["DEFAULT_ADMIN_USER"]);

export const defaultFeatures = pgTable("default_features", {
    id: serial("id").primaryKey(),
    userType: userTypes('user_type').unique(),
    acl: integer("acl").array().default(sql`ARRAY[]::integer[]`)
})