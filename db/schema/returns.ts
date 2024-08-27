import { bigserial, integer, pgEnum, pgTable } from "drizzle-orm/pg-core";
import { companies } from "./companies";
import { purchases } from "./purchases";


export const returnTypes = pgEnum('return_types', ["CREDIT", "DEBIT"]);

export const returns = pgTable("returns", {
    returnId: bigserial("return_id", {mode: "bigint"}).primaryKey(),
    companyId: integer("company_id").references(() => companies.companyId).notNull(),
    returnType: returnTypes("return_type").notNull(),
    purchaseId: bigserial("purchase_id", {mode: "bigint"}).references(() => purchases.purchaseId)
})