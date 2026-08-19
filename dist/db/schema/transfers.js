"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.transfers = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const users_1 = require("./users");
exports.transfers = (0, pg_core_1.pgTable)("transfers", {
    transferId: (0, pg_core_1.serial)("transfer_id").primaryKey(),
    fromCompanyId: (0, pg_core_1.integer)("from_company_id").references(() => companies_1.companies.companyId).notNull(),
    toCompanyId: (0, pg_core_1.integer)("to_company_id").references(() => companies_1.companies.companyId).notNull(),
    fromCompanyName: (0, pg_core_1.varchar)("from_company_name").notNull(),
    toCompanyName: (0, pg_core_1.varchar)("to_company_name").notNull(),
    doneBy: (0, pg_core_1.uuid)("done_by").references(() => users_1.users.userId).notNull(),
    createdAt: (0, pg_core_1.timestamp)("created_at", { withTimezone: false }).defaultNow().notNull()
});
