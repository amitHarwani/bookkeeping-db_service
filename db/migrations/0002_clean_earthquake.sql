ALTER TABLE "sale_item_profits" ADD COLUMN "company_id" integer;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_item_profits" ADD CONSTRAINT "sale_item_profits_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
