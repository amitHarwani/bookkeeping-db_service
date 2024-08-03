import { boolean, pgEnum, pgTable, serial, varchar } from "drizzle-orm/pg-core";


export const platformFeaturesEnum = pgEnum('platformFeaturesEnum', [
    "ADD COUNTRY",
    "GET COUNTRY",
    "UPDATE COUNTRY",
    "DELETE COUNTRY",
    "ADD TAXDETAILS",
    "GET TAXDETAILS",
    "UPDATE TAXDETAILS",
    "DELETE TAXDETAILS",
])



export const platformFeatures = pgTable('platform_features', {
    featureId: serial('feature_id').primaryKey(),
    featureName: platformFeaturesEnum('feature_name').unique().notNull(),
    isEnabled: boolean('is_enabled').default(true)
})