"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.defaultFeatures = exports.userTypes = void 0;
const drizzle_orm_1 = require("drizzle-orm");
const pg_core_1 = require("drizzle-orm/pg-core");
exports.userTypes = (0, pg_core_1.pgEnum)('user_types', ["DEFAULT_ADMIN_USER"]);
exports.defaultFeatures = (0, pg_core_1.pgTable)("default_features", {
    id: (0, pg_core_1.serial)("id").primaryKey(),
    userType: (0, exports.userTypes)('user_type').unique(),
    acl: (0, pg_core_1.integer)("acl").array().default((0, drizzle_orm_1.sql) `ARRAY[]::integer[]`)
});
