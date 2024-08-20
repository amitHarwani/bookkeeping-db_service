ALTER TABLE "units" DROP CONSTRAINT "units_unit_name_unique";--> statement-breakpoint
ALTER TABLE "units" ADD COLUMN "company_id" integer NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "units" ADD CONSTRAINT "units_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
