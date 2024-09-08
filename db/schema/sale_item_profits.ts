import { integer, pgTable, numeric, jsonb, primaryKey } from "drizzle-orm/pg-core";
import { items } from "./items";
import { sql } from "drizzle-orm";
import { companies } from "./companies";

export const saleItemProfits = pgTable("sale_item_profits", {
    saleId: integer("sale_id"),
    itemId: integer("item_id").references(() => items.itemId),
    companyId: integer("company_id").references(() => companies.companyId),
    totalProfit: numeric("total_profit"),
    costOfItems: jsonb("cost_of_items").array(),
    purchaseIds: integer("purchase_ids").array().default(sql`ARRAY[]::integer[]`),
    remainingUnitsForProfitCalc: numeric("remaining_units_for_profit_calc"),
}, (table) => {
    return {
        pk: primaryKey({columns: [table.saleId, table.itemId]})
    }
})