"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.platformFeatures = exports.platformFeaturesEnum = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
exports.platformFeaturesEnum = (0, pg_core_1.pgEnum)('platformFeaturesEnum', [
    "ADD COUNTRY",
    "GET COUNTRY",
    "UPDATE COUNTRY",
    "DELETE COUNTRY",
    "ADD TAXDETAILS",
    "GET TAXDETAILS",
    "UPDATE TAXDETAILS",
    "DELETE TAXDETAILS",
]);
exports.platformFeatures = (0, pg_core_1.pgTable)('platform_features', {
    featureId: (0, pg_core_1.serial)('feature_id').primaryKey(),
    featureName: (0, exports.platformFeaturesEnum)('feature_name').unique().notNull(),
    isEnabled: (0, pg_core_1.boolean)('is_enabled').default(true)
});
