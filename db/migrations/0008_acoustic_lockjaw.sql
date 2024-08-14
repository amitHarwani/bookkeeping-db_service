ALTER TABLE "roles" ADD COLUMN "acl" integer[] DEFAULT ARRAY[]::integer[];--> statement-breakpoint
ALTER TABLE "user_company_mapping" DROP COLUMN IF EXISTS "acl";