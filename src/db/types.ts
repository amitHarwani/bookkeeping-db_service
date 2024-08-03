import { InferSelectModel, InferInsertModel } from "drizzle-orm";
import * as schema from "./combined_schema";

export type Company = typeof schema.companies.$inferSelect;
export type NewCompany = typeof schema.companies.$inferInsert;

export type Country = typeof schema.countries.$inferSelect;
export type NewCountry = typeof schema.countries.$inferInsert;

export type PlatformFeature = typeof schema.platformFeatures.$inferSelect;
export type NewPlatformFeature = typeof schema.platformFeatures.$inferInsert;

export type Role = typeof schema.roles.$inferSelect;
export type NewRole = typeof schema.roles.$inferInsert;

export type TaxDetail = typeof schema.taxDetails.$inferSelect;
export type NewTaxDetail = typeof schema.taxDetails.$inferInsert;

export type UserCompanyMapping = typeof schema.userCompanyMapping.$inferSelect;
export type NewUserCompanyMapping = typeof schema.userCompanyMapping.$inferInsert;

export type User = typeof schema.users.$inferSelect;
export type NewUser = typeof schema.users.$inferInsert;
