"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.roleFeatureMapping = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const roles_1 = require("./roles");
const platform_features_1 = require("./platform_features");
exports.roleFeatureMapping = (0, pg_core_1.pgTable)("role_feature_mapping", {
    roleId: (0, pg_core_1.integer)("role_id").references(() => roles_1.roles.roleId),
    featureId: (0, pg_core_1.integer)("feature_id").references(() => platform_features_1.platformFeatures.featureId),
    featureName: (0, pg_core_1.varchar)("feature_name").notNull()
}, (table) => {
    return {
        roleFeatureMappingPK: (0, pg_core_1.primaryKey)({ columns: [table.roleId, table.featureId] })
    };
});
