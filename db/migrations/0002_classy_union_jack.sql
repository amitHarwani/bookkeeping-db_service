DO $$ BEGIN
 CREATE TYPE "public"."return_types" AS ENUM('CREDIT', 'DEBIT');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchases" (
	"purchase_id" bigserial PRIMARY KEY NOT NULL,
	"invoice_number" integer NOT NULL,
	"company_id" integer NOT NULL,
	"party_id" integer NOT NULL,
	"party_name" varchar NOT NULL,
	"subtotal" numeric NOT NULL,
	"discount" numeric DEFAULT '0' NOT NULL,
	"total_after_discount" numeric NOT NULL,
	"tax_percent" numeric DEFAULT '0' NOT NULL,
	"tax_name" varchar DEFAULT '' NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"is_credit" boolean DEFAULT false NOT NULL,
	"payment_due_date" date,
	"amount_paid" numeric NOT NULL,
	"amount_due" numeric NOT NULL,
	"is_fully_paid" boolean DEFAULT false NOT NULL,
	"payment_completion_date" date,
	"receipt_number" varchar,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_items" (
	"purchase_id" bigserial NOT NULL,
	"item_id" integer NOT NULL,
	"item_name" varchar NOT NULL,
	"company_id" integer NOT NULL,
	"unit_id" integer NOT NULL,
	"unit_name" varchar NOT NULL,
	"units_purchased" numeric NOT NULL,
	"price_per_unit" numeric NOT NULL,
	"subtotal" numeric NOT NULL,
	"tax_percent" numeric NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "purchase_items_purchase_id_item_id_pk" PRIMARY KEY("purchase_id","item_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "returns" (
	"return_id" bigserial PRIMARY KEY NOT NULL,
	"company_id" integer NOT NULL,
	"return_type" "return_types" NOT NULL,
	"purchase_id" bigserial
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "return_items" (
	"return_id" bigserial NOT NULL,
	"item_id" integer NOT NULL,
	"item_name" varchar NOT NULL,
	"unit_id" integer NOT NULL,
	"unit_name" varchar NOT NULL,
	"units_returned" numeric NOT NULL,
	"price_per_unit" numeric NOT NULL,
	"subtotal" numeric NOT NULL,
	"tax_percent" numeric NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"date_time_of_return" timestamp DEFAULT now(),
	CONSTRAINT "return_items_return_id_item_id_pk" PRIMARY KEY("return_id","item_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchases" ADD CONSTRAINT "purchases_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchases" ADD CONSTRAINT "purchases_party_id_third_parties_party_id_fk" FOREIGN KEY ("party_id") REFERENCES "public"."third_parties"("party_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_items" ADD CONSTRAINT "purchase_items_purchase_id_purchases_purchase_id_fk" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchases"("purchase_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_items" ADD CONSTRAINT "purchase_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_items" ADD CONSTRAINT "purchase_items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_items" ADD CONSTRAINT "purchase_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "returns" ADD CONSTRAINT "returns_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "returns" ADD CONSTRAINT "returns_purchase_id_purchases_purchase_id_fk" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchases"("purchase_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_items" ADD CONSTRAINT "return_items_return_id_returns_return_id_fk" FOREIGN KEY ("return_id") REFERENCES "public"."returns"("return_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_items" ADD CONSTRAINT "return_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_items" ADD CONSTRAINT "return_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
