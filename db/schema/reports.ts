import { pgTable, serial, timestamp, varchar } from "drizzle-orm/pg-core";


export const reports = pgTable("reports", {
    reportId: serial("report_id").primaryKey(),
    reportName: varchar("report_name").notNull(),
    fromDateTime: timestamp("from_date_time", {withTimezone: false}),
    toDateTime: timestamp("to_date_time", {withTimezone: false}),
    status: varchar("status").notNull(),
    reportLink: varchar("report_link"),
    createdAt: timestamp("created_at", {withTimezone: false}).defaultNow().notNull(),
})