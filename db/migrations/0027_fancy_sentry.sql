CREATE TABLE IF NOT EXISTS "purchase_returns" (
	"purchase_return_id" serial PRIMARY KEY NOT NULL,
	"purchase_return_number" integer NOT NULL,
	"purchase_id" integer NOT NULL,
	"invoice_number" integer NOT NULL,
	"company_id" integer NOT NULL,
	"subtotal" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric DEFAULT '0' NOT NULL,
	"tax_name" varchar DEFAULT '' NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "purchase_returns_company_id_purchase_return_number_unique" UNIQUE("company_id","purchase_return_number")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_return_items" (
	"purchase_return_id" integer NOT NULL,
	"item_id" integer NOT NULL,
	"item_name" varchar NOT NULL,
	"company_id" integer NOT NULL,
	"unit_id" integer NOT NULL,
	"unit_name" varchar NOT NULL,
	"units_purchased" numeric NOT NULL,
	"price_per_unit" numeric NOT NULL,
	"subtotal" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric DEFAULT '0' NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "purchase_return_items_purchase_return_id_item_id_pk" PRIMARY KEY("purchase_return_id","item_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_returns" ADD CONSTRAINT "purchase_returns_purchase_id_purchases_purchase_id_fk" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchases"("purchase_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_returns" ADD CONSTRAINT "purchase_returns_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_return_items" ADD CONSTRAINT "purchase_return_items_purchase_return_id_purchase_returns_purchase_return_id_fk" FOREIGN KEY ("purchase_return_id") REFERENCES "public"."purchase_returns"("purchase_return_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_return_items" ADD CONSTRAINT "purchase_return_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_return_items" ADD CONSTRAINT "purchase_return_items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_return_items" ADD CONSTRAINT "purchase_return_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
