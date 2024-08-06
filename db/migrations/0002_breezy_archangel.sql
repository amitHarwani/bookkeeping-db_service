ALTER TABLE "user_company_mapping" DROP CONSTRAINT "user_company_mapping_user_id_company_id_pk";--> statement-breakpoint
ALTER TABLE "user_company_mapping" ADD COLUMN "id" serial PRIMARY KEY NOT NULL;