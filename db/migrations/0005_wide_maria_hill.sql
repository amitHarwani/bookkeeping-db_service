DROP TABLE "role_feature_mapping";--> statement-breakpoint
ALTER TABLE "user_company_mapping" ADD COLUMN "acl" integer[] DEFAULT ARRAY[]::integer[];