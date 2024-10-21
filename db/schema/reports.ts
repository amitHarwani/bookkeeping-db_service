import { integer, pgTable, serial, timestamp, uuid, varchar } from "drizzle-orm/pg-core";
import { users } from "./users";
import { companies } from "./companies";


export const reports = pgTable("reports", {
    reportId: serial("report_id").primaryKey(),
    reportName: varchar("report_name").notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    fromDateTime: timestamp("from_date_time", {withTimezone: false}),
    toDateTime: timestamp("to_date_time", {withTimezone: false}),
    status: varchar("status").notNull(),
    reportLink: varchar("report_link"),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow().notNull(),
    requestedBy: uuid("requested_by").references(() => users.userId)
})