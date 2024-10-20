"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.reports = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const users_1 = require("./users");
exports.reports = (0, pg_core_1.pgTable)("reports", {
    reportId: (0, pg_core_1.serial)("report_id").primaryKey(),
    reportName: (0, pg_core_1.varchar)("report_name").notNull(),
    fromDateTime: (0, pg_core_1.timestamp)("from_date_time", { withTimezone: false }),
    toDateTime: (0, pg_core_1.timestamp)("to_date_time", { withTimezone: false }),
    status: (0, pg_core_1.varchar)("status").notNull(),
    reportLink: (0, pg_core_1.varchar)("report_link"),
    createdAt: (0, pg_core_1.timestamp)("created_at", { withTimezone: false }).defaultNow().notNull(),
    requestedBy: (0, pg_core_1.uuid)("requested_by").references(() => users_1.users.userId)
});
