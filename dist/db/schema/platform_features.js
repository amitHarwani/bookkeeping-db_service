"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.platformFeatures = exports.platformFeaturesEnum = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
exports.platformFeaturesEnum = (0, pg_core_1.pgEnum)("platformFeaturesEnum", [
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
exports.platformFeatures = (0, pg_core_1.pgTable)("platform_features", {
    featureId: (0, pg_core_1.serial)("feature_id").primaryKey(),
    featureName: (0, exports.platformFeaturesEnum)("feature_name").unique().notNull(),
    isEnabled: (0, pg_core_1.boolean)("is_enabled").default(true),
});
