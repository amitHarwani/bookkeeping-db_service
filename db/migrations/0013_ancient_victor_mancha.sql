CREATE TABLE IF NOT EXISTS "items" (
	"item_id" serial PRIMARY KEY NOT NULL,
	"item_name" varchar NOT NULL,
	"company_id" integer,
	"unit_id" integer,
	"default_selling_price" numeric,
	"default_purchase_price" numeric,
	"stock" bigint,
	"min_stock_to_maintain" bigint,
	"is_active" boolean DEFAULT true,
	"price_history_of_current_stock" jsonb[],
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "units" (
	"unit_id" serial PRIMARY KEY NOT NULL,
	"unit_name" varchar NOT NULL,
	CONSTRAINT "units_unit_name_unique" UNIQUE("unit_name")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "items" ADD CONSTRAINT "items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "items" ADD CONSTRAINT "items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
