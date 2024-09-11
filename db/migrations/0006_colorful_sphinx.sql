CREATE TABLE IF NOT EXISTS "quotations" (
	"quotation_id" serial PRIMARY KEY NOT NULL,
	"quotation_number" integer NOT NULL,
	"company_id" integer NOT NULL,
	"created_by" uuid,
	"subtotal" numeric NOT NULL,
	"discount" numeric DEFAULT '0' NOT NULL,
	"total_after_discount" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric DEFAULT '0' NOT NULL,
	"tax_name" varchar DEFAULT '' NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"sale_invoice_number" integer,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "quotations_company_id_quotation_number_unique" UNIQUE("company_id","quotation_number")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "quotation_items" (
	"quotation_id" integer NOT NULL,
	"item_id" integer NOT NULL,
	"company_id" integer,
	"unit_id" integer NOT NULL,
	"unit_name" varchar NOT NULL,
	"units_sold" numeric NOT NULL,
	"price_per_unit" numeric NOT NULL,
	"subtotal" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "quotation_items_quotation_id_item_id_pk" PRIMARY KEY("quotation_id","item_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "quotations" ADD CONSTRAINT "quotations_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "quotations" ADD CONSTRAINT "quotations_created_by_users_user_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "quotation_items" ADD CONSTRAINT "quotation_items_quotation_id_quotations_quotation_id_fk" FOREIGN KEY ("quotation_id") REFERENCES "public"."quotations"("quotation_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "quotation_items" ADD CONSTRAINT "quotation_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "quotation_items" ADD CONSTRAINT "quotation_items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "quotation_items" ADD CONSTRAINT "quotation_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
