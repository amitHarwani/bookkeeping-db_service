import { boolean, pgEnum, pgTable, serial, varchar } from "drizzle-orm/pg-core";

export const platformFeaturesEnum = pgEnum("platformFeaturesEnum", [
    "ADD_FEATURE",
    "GET_ALL_FEATURES",
    "UPDATE_FEATURE",

    "ADD_COUNTRY", 
    "GET_ALL_COUNTRIES",
    "UPDATE_COUNTRY",
    "DELETE_COUNTRY",

    "ADD_TAX_DETAILS",
    "GET_ALL_TAX_DETAILS",
    "UPDATE_TAX_DETAILS",
    "DELETE_TAX_DETAILS",
]);

export const platformFeatures = pgTable("platform_features", {
    featureId: serial("feature_id").primaryKey(),
    featureName: platformFeaturesEnum("feature_name").unique().notNull(),
    isEnabled: boolean("is_enabled").default(true),
});
