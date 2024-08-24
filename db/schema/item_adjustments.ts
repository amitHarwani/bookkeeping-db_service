import { integer, numeric, pgEnum, pgTable, serial, timestamp, uuid, varchar } from "drizzle-orm/pg-core";
import { items } from "./items";
import { companies } from "./companies";
import { users } from "./users";

export const adjustmentTypes = pgEnum('adjustment_types', ["ADD", "SUBTRACT"]);


export const itemAdjustments = pgTable("item_adjustments", {
    adjustmentId: serial("adjustment_id").primaryKey(),
    itemId: integer("item_id").references(() => items.itemId).notNull(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    adjustmentType: varchar("adjustment_type").notNull(),
    stockAdjusted: numeric("stock_adjusted").notNull(),
    pricePerUnit: numeric("price_per_unit"),
    reason: varchar("reason").notNull(),
    doneBy: uuid("done_by").references(() => users.userId).notNull(),
    adjustedAt: timestamp("adjusted_at", {withTimezone: false}).defaultNow()
})