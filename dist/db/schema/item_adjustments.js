"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.itemAdjustments = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const items_1 = require("./items");
const companies_1 = require("./companies");
const users_1 = require("./users");
exports.itemAdjustments = (0, pg_core_1.pgTable)("item_adjustments", {
    adjustmentId: (0, pg_core_1.serial)("adjustment_id").primaryKey(),
    itemId: (0, pg_core_1.integer)("item_id").references(() => items_1.items.itemId).notNull(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    adjustmentType: (0, pg_core_1.varchar)("adjustment_type").notNull(),
    stockAdjusted: (0, pg_core_1.numeric)("stock_adjusted").notNull(),
    pricePerUnit: (0, pg_core_1.numeric)("price_per_unit"),
    reason: (0, pg_core_1.varchar)("reason").notNull(),
    doneBy: (0, pg_core_1.uuid)("done_by").references(() => users_1.users.userId).notNull(),
    adjustedAt: (0, pg_core_1.timestamp)("adjusted_at", { withTimezone: false }).defaultNow()
});
