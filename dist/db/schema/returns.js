"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.returns = exports.returnTypes = void 0;
const pg_core_1 = require("drizzle-orm/pg-core");
const companies_1 = require("./companies");
const purchases_1 = require("./purchases");
exports.returnTypes = (0, pg_core_1.pgEnum)('return_types', ["CREDIT", "DEBIT"]);
exports.returns = (0, pg_core_1.pgTable)("returns", {
    returnId: (0, pg_core_1.bigserial)("return_id", { mode: "bigint" }).primaryKey(),
    companyId: (0, pg_core_1.integer)("company_id").references(() => companies_1.companies.companyId).notNull(),
    returnType: (0, exports.returnTypes)("return_type").notNull(),
    purchaseId: (0, pg_core_1.bigserial)("purchase_id", { mode: "bigint" }).references(() => purchases_1.purchases.purchaseId)
});
