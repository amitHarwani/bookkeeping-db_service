CREATE TABLE IF NOT EXISTS "cash_in_out" (
	"transaction_date_time" timestamp NOT NULL,
	"company_id" integer NOT NULL,
	"cash_in" numeric DEFAULT '0' NOT NULL,
	"cash_out" numeric DEFAULT '0' NOT NULL
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "cash_in_out" ADD CONSTRAINT "cash_in_out_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
