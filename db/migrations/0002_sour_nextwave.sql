ALTER TABLE "user_company_mapping" ADD CONSTRAINT "user_company_mapping_user_id_company_id_pk" PRIMARY KEY("user_id","company_id");--> statement-breakpoint
ALTER TABLE "companies" ADD COLUMN "is_active" boolean DEFAULT true;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "is_sub_user" boolean DEFAULT false;--> statement-breakpoint
ALTER TABLE "users" ADD COLUMN "is_active" boolean DEFAULT true;