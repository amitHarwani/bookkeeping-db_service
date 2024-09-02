DO $$ BEGIN
 CREATE TYPE "public"."user_types" AS ENUM('DEFAULT_ADMIN_USER');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."adjustment_types" AS ENUM('ADD', 'SUBTRACT');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."return_types" AS ENUM('CREDIT', 'DEBIT');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "companies" (
	"company_id" serial PRIMARY KEY NOT NULL,
	"company_name" varchar NOT NULL,
	"country_id" integer NOT NULL,
	"address" varchar NOT NULL,
	"phone_number" varchar NOT NULL,
	"day_start_time" time NOT NULL,
	"is_main_branch" boolean DEFAULT true,
	"main_branch_id" integer,
	"decimal_round_to" integer NOT NULL,
	"created_by" uuid NOT NULL,
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "companies_company_name_unique" UNIQUE("company_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "company_tax_mapping" (
	"company_id" integer NOT NULL,
	"tax_id" integer NOT NULL,
	"registration_number" varchar NOT NULL,
	CONSTRAINT "company_tax_mapping_company_id_tax_id_pk" PRIMARY KEY("company_id","tax_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "countries" (
	"country_id" serial PRIMARY KEY NOT NULL,
	"country_name" varchar NOT NULL,
	"phone_number_codes" varchar[] DEFAULT ARRAY[]::text[],
	"currency" varchar NOT NULL,
	"max_phone_number_digits" integer NOT NULL,
	"timezone" varchar NOT NULL,
	CONSTRAINT "countries_country_name_unique" UNIQUE("country_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "default_features" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_type" "user_types",
	"acl" integer[] DEFAULT ARRAY[]::integer[],
	CONSTRAINT "default_features_user_type_unique" UNIQUE("user_type")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "items" (
	"item_id" serial PRIMARY KEY NOT NULL,
	"item_name" varchar NOT NULL,
	"company_id" integer NOT NULL,
	"unit_id" integer NOT NULL,
	"unit_name" varchar NOT NULL,
	"default_selling_price" numeric,
	"default_purchase_price" numeric,
	"stock" numeric NOT NULL,
	"min_stock_to_maintain" bigint,
	"is_active" boolean DEFAULT true,
	"price_history_of_current_stock" jsonb[],
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "item_adjustments" (
	"adjustment_id" serial PRIMARY KEY NOT NULL,
	"item_id" integer NOT NULL,
	"company_id" integer NOT NULL,
	"adjustment_type" "adjustment_types" NOT NULL,
	"stock_adjusted" numeric NOT NULL,
	"price_per_unit" numeric,
	"reason" varchar NOT NULL,
	"done_by" uuid NOT NULL,
	"adjusted_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "platform_features" (
	"feature_id" serial PRIMARY KEY NOT NULL,
	"feature_name" varchar NOT NULL,
	"is_enabled" boolean DEFAULT true,
	"is_system_admin_feature" boolean DEFAULT false,
	"dependent_feature_id" integer,
	CONSTRAINT "platform_features_feature_name_unique" UNIQUE("feature_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchases" (
	"purchase_id" serial PRIMARY KEY NOT NULL,
	"invoice_number" integer NOT NULL,
	"company_id" integer NOT NULL,
	"party_id" integer NOT NULL,
	"party_name" varchar NOT NULL,
	"subtotal" numeric NOT NULL,
	"discount" numeric DEFAULT '0' NOT NULL,
	"total_after_discount" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
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
	"purchase_id" integer NOT NULL,
	"item_id" integer NOT NULL,
	"item_name" varchar NOT NULL,
	"company_id" integer NOT NULL,
	"unit_id" integer NOT NULL,
	"unit_name" varchar NOT NULL,
	"units_purchased" numeric NOT NULL,
	"price_per_unit" numeric NOT NULL,
	"subtotal" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "purchase_items_purchase_id_item_id_pk" PRIMARY KEY("purchase_id","item_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "returns" (
	"return_id" serial PRIMARY KEY NOT NULL,
	"company_id" integer NOT NULL,
	"return_type" "return_types" NOT NULL,
	"purchase_id" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "return_items" (
	"return_id" integer NOT NULL,
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
CREATE TABLE IF NOT EXISTS "roles" (
	"role_id" serial PRIMARY KEY NOT NULL,
	"company_id" integer,
	"role_name" varchar NOT NULL,
	"acl" integer[] DEFAULT ARRAY[]::integer[]
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tax_details" (
	"tax_id" serial PRIMARY KEY NOT NULL,
	"country_id" integer NOT NULL,
	"tax_name" varchar NOT NULL,
	"tax_percentage" numeric NOT NULL,
	"tax_nickname" varchar NOT NULL,
	"is_tax_on_invoice" boolean DEFAULT false,
	"is_registration_optional" boolean DEFAULT true
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "third_parties" (
	"party_id" serial PRIMARY KEY NOT NULL,
	"company_id" integer NOT NULL,
	"party_name" varchar NOT NULL,
	"default_sale_credit_allowance_indays" integer NOT NULL,
	"default_purchase_credit_allowance_indays" integer NOT NULL,
	"country_id" integer NOT NULL,
	"phone_number" varchar,
	"tax_details" jsonb[],
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "units" (
	"unit_id" serial PRIMARY KEY NOT NULL,
	"unit_name" varchar NOT NULL,
	"company_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"user_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"full_name" varchar NOT NULL,
	"email" varchar NOT NULL,
	"password" varchar NOT NULL,
	"refresh_token" varchar,
	"country_id" integer,
	"mobile_number" varchar NOT NULL,
	"is_logged_in" boolean DEFAULT false,
	"is_sub_user" boolean DEFAULT false,
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "users_email_unique" UNIQUE("email"),
	CONSTRAINT "users_mobile_number_unique" UNIQUE("mobile_number")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_company_mapping" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" uuid,
	"company_id" integer,
	"role_id" integer,
	CONSTRAINT "user_company_mapping_user_id_company_id_role_id_unique" UNIQUE("user_id","company_id","role_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "companies" ADD CONSTRAINT "companies_country_id_countries_country_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("country_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "companies" ADD CONSTRAINT "companies_created_by_users_user_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "company_tax_mapping" ADD CONSTRAINT "company_tax_mapping_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
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
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "item_adjustments" ADD CONSTRAINT "item_adjustments_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "item_adjustments" ADD CONSTRAINT "item_adjustments_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "item_adjustments" ADD CONSTRAINT "item_adjustments_done_by_users_user_id_fk" FOREIGN KEY ("done_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
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
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "roles" ADD CONSTRAINT "roles_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "tax_details" ADD CONSTRAINT "tax_details_country_id_countries_country_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("country_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "third_parties" ADD CONSTRAINT "third_parties_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "third_parties" ADD CONSTRAINT "third_parties_country_id_countries_country_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("country_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "units" ADD CONSTRAINT "units_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "users" ADD CONSTRAINT "users_country_id_countries_country_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("country_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_company_mapping" ADD CONSTRAINT "user_company_mapping_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_company_mapping" ADD CONSTRAINT "user_company_mapping_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_company_mapping" ADD CONSTRAINT "user_company_mapping_role_id_roles_role_id_fk" FOREIGN KEY ("role_id") REFERENCES "public"."roles"("role_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
