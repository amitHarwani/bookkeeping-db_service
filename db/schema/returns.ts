import { integer, pgEnum, pgTable, serial } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { purchases } from "./purchases";


export const returnTypes = pgEnum('return_types', ["CREDIT", "DEBIT"]);

export const returns = pgTable("returns", {
    returnId: serial("return_id").primaryKey(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    returnType: returnTypes("return_type").notNull(),
    purchaseId: integer("purchase_id").references(() => purchases.purchaseId)
})