CREATE TABLE IF NOT EXISTS "company_tax_mapping" (
	"company_id" integer NOT NULL,
	"tax_id" integer NOT NULL,
	"registration_number" varchar NOT NULL,
	CONSTRAINT "company_tax_mapping_company_id_tax_id_pk" PRIMARY KEY("company_id","tax_id")
);
--> statement-breakpoint
ALTER TABLE "roles" ALTER COLUMN "acl" SET DATA TYPE integer[] USING acl::integer[];--> statement-breakpoint
ALTER TABLE "roles" ALTER COLUMN "acl" SET DEFAULT ARRAY[]::integer[];--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "company_tax_mapping" ADD CONSTRAINT "company_tax_mapping_company_id_countries_country_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."countries"("country_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "company_tax_mapping" ADD CONSTRAINT "company_tax_mapping_tax_id_tax_details_tax_id_fk" FOREIGN KEY ("tax_id") REFERENCES "public"."tax_details"("tax_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "companies" DROP COLUMN IF EXISTS "tax_details";