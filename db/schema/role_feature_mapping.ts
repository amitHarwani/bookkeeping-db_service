import { pgTable, integer, varchar, primaryKey } from "drizzle-orm/pg-core";
import { roles } from "./roles";
import { platformFeatures } from "./platform_features";


export const roleFeatureMapping = pgTable("role_feature_mapping", {
    roleId: integer("role_id").references(() => roles.roleId),
    featureId: integer("feature_id").references(() => platformFeatures.featureId),
}, (table) => {
    return {
        roleFeatureMappingPK: primaryKey({columns: [table.roleId, table.featureId]})
    }
})