"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.units = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
exports.units = (0, pg_core_1.pgTable)("units", {
    unitId: (0, pg_core_1.serial)("unit_id").primaryKey(),
    unitName: (0, pg_core_1.varchar)("unit_name").notNull(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull()
});
