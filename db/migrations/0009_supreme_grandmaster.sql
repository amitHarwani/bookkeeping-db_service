ALTER TABLE "company_tax_mapping" DROP CONSTRAINT "company_tax_mapping_company_id_countries_country_id_fk";
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "company_tax_mapping" ADD CONSTRAINT "company_tax_mapping_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
