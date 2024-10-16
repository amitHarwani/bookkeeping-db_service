CREATE TABLE IF NOT EXISTS "sale_returns" (
	"sale_return_id" serial PRIMARY KEY NOT NULL,
	"sale_return_number" integer NOT NULL,
	"sale_id" integer NOT NULL,
	"company_id" integer NOT NULL,
	"subtotal" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric DEFAULT '0' NOT NULL,
	"tax_name" varchar DEFAULT '' NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"company_tax_number" varchar DEFAULT '',
	"party_tax_number" varchar DEFAULT '',
	"party_id" integer,
	"party_name" varchar,
	"is_no_party_bill" boolean DEFAULT false NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sale_return_items" (
	"sale_return_id" integer NOT NULL,
	"item_id" integer NOT NULL,
	"item_name" varchar NOT NULL,
	"company_id" integer NOT NULL,
	"unit_id" integer NOT NULL,
	"unit_name" varchar NOT NULL,
	"units_sold" numeric NOT NULL,
	"price_per_unit" numeric NOT NULL,
	"subtotal" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric DEFAULT '0' NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_returns" ADD CONSTRAINT "sale_returns_sale_id_sales_sale_id_fk" FOREIGN KEY ("sale_id") REFERENCES "public"."sales"("sale_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_returns" ADD CONSTRAINT "sale_returns_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_returns" ADD CONSTRAINT "sale_returns_party_id_third_parties_party_id_fk" FOREIGN KEY ("party_id") REFERENCES "public"."third_parties"("party_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_return_items" ADD CONSTRAINT "sale_return_items_sale_return_id_sale_returns_sale_return_id_fk" FOREIGN KEY ("sale_return_id") REFERENCES "public"."sale_returns"("sale_return_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_return_items" ADD CONSTRAINT "sale_return_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_return_items" ADD CONSTRAINT "sale_return_items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_return_items" ADD CONSTRAINT "sale_return_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
