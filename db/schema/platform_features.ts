import { boolean, integer, pgEnum, pgTable, serial, varchar } from "drizzle-orm/pg-core";


export const platformFeatures = pgTable("platform_features", {
    featureId: serial("feature_id").primaryKey(),
    featureName: varchar("feature_name").unique().notNull(),
    isEnabled: boolean("is_enabled").default(true),
    isSystemAdminFeature: boolean("is_system_admin_feature").default(false),
    dependentFeatureId: integer("dependent_feature_id")
});
