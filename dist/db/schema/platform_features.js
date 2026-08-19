"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.platformFeatures = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
exports.platformFeatures = (0, pg_core_1.pgTable)("platform_features", {
    featureId: (0, pg_core_1.serial)("feature_id").primaryKey(),
    featureName: (0, pg_core_1.varchar)("feature_name").unique().notNull(),
    isEnabled: (0, pg_core_1.boolean)("is_enabled").default(true),
    isSystemAdminFeature: (0, pg_core_1.boolean)("is_system_admin_feature").default(false),
    dependentFeatureId: (0, pg_core_1.integer)("dependent_feature_id")
});
