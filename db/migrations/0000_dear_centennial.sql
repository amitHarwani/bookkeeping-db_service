CREATE TYPE "public"."user_types" AS ENUM('DEFAULT_ADMIN_USER');--> statement-breakpoint
CREATE TYPE "public"."adjustment_types" AS ENUM('ADD', 'SUBTRACT');--> statement-breakpoint
CREATE TABLE "cash_in_out" (
	"id" serial PRIMARY KEY NOT NULL,
	"transaction_date_time" timestamp NOT NULL,
	"company_id" integer NOT NULL,
	"cash_in" numeric DEFAULT '0' NOT NULL,
	"cash_out" numeric DEFAULT '0' NOT NULL,
	"purchase_id" integer,
	"sale_id" integer
);
--> statement-breakpoint
CREATE TABLE "companies" (
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
CREATE TABLE "company_tax_mapping" (
	"company_id" integer NOT NULL,
	"tax_id" integer NOT NULL,
	"registration_number" varchar NOT NULL,
	CONSTRAINT "company_tax_mapping_company_id_tax_id_pk" PRIMARY KEY("company_id","tax_id")
);
--> statement-breakpoint
CREATE TABLE "countries" (
	"country_id" serial PRIMARY KEY NOT NULL,
	"country_name" varchar NOT NULL,
	"phone_number_codes" varchar[] DEFAULT ARRAY[]::text[],
	"currency" varchar NOT NULL,
	"max_phone_number_digits" integer NOT NULL,
	"timezone" varchar NOT NULL,
	CONSTRAINT "countries_country_name_unique" UNIQUE("country_name")
);
--> statement-breakpoint
CREATE TABLE "default_features" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_type" "user_types",
	"acl" integer[] DEFAULT ARRAY[]::integer[],
	CONSTRAINT "default_features_user_type_unique" UNIQUE("user_type")
);
--> statement-breakpoint
CREATE TABLE "items" (
	"item_id" serial PRIMARY KEY NOT NULL,
	"item_name" varchar NOT NULL,
	"company_id" integer NOT NULL,
	"unit_id" integer NOT NULL,
	"unit_name" varchar NOT NULL,
	"default_selling_price" numeric,
	"default_purchase_price" numeric,
	"stock" numeric NOT NULL,
	"min_stock_to_maintain" numeric,
	"is_active" boolean DEFAULT true,
	"price_history_of_current_stock" jsonb[],
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "item_adjustments" (
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
CREATE TABLE "platform_features" (
	"feature_id" serial PRIMARY KEY NOT NULL,
	"feature_name" varchar NOT NULL,
	"is_enabled" boolean DEFAULT true,
	"is_system_admin_feature" boolean DEFAULT false,
	"dependent_feature_id" integer,
	CONSTRAINT "platform_features_feature_name_unique" UNIQUE("feature_name")
);
--> statement-breakpoint
CREATE TABLE "purchases" (
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
	"payment_due_date" timestamp,
	"amount_paid" numeric NOT NULL,
	"amount_due" numeric NOT NULL,
	"is_fully_paid" boolean DEFAULT false NOT NULL,
	"payment_completion_date" timestamp,
	"receipt_number" varchar,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "purchase_items" (
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
CREATE TABLE "purchase_returns" (
	"purchase_return_id" serial PRIMARY KEY NOT NULL,
	"purchase_return_number" integer NOT NULL,
	"purchase_id" integer NOT NULL,
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
CREATE TABLE "purchase_return_items" (
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
CREATE TABLE "quotations" (
	"quotation_id" serial PRIMARY KEY NOT NULL,
	"quotation_number" integer NOT NULL,
	"company_id" integer NOT NULL,
	"created_by" uuid,
	"party_id" integer NOT NULL,
	"party_name" varchar NOT NULL,
	"subtotal" numeric NOT NULL,
	"discount" numeric DEFAULT '0' NOT NULL,
	"total_after_discount" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric DEFAULT '0' NOT NULL,
	"tax_name" varchar DEFAULT '' NOT NULL,
	"company_tax_number" varchar DEFAULT '',
	"party_tax_number" varchar DEFAULT '',
	"total_after_tax" numeric NOT NULL,
	"sale_id" integer,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "quotations_company_id_quotation_number_unique" UNIQUE("company_id","quotation_number")
);
--> statement-breakpoint
CREATE TABLE "quotation_items" (
	"quotation_id" integer NOT NULL,
	"item_id" integer NOT NULL,
	"item_name" varchar NOT NULL,
	"company_id" integer NOT NULL,
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
CREATE TABLE "reports" (
	"report_id" serial PRIMARY KEY NOT NULL,
	"report_name" varchar NOT NULL,
	"company_id" integer NOT NULL,
	"from_date_time" timestamp,
	"to_date_time" timestamp,
	"status" varchar NOT NULL,
	"report_link" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"requested_by" uuid
);
--> statement-breakpoint
CREATE TABLE "roles" (
	"role_id" serial PRIMARY KEY NOT NULL,
	"company_id" integer,
	"role_name" varchar NOT NULL,
	"acl" integer[] DEFAULT ARRAY[]::integer[]
);
--> statement-breakpoint
CREATE TABLE "sales" (
	"sale_id" serial PRIMARY KEY NOT NULL,
	"invoice_number" integer NOT NULL,
	"company_id" integer NOT NULL,
	"party_id" integer,
	"party_name" varchar,
	"is_no_party_bill" boolean DEFAULT false NOT NULL,
	"done_by" uuid,
	"subtotal" numeric NOT NULL,
	"discount" numeric DEFAULT '0' NOT NULL,
	"total_after_discount" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric DEFAULT '0' NOT NULL,
	"tax_name" varchar DEFAULT '' NOT NULL,
	"company_tax_number" varchar DEFAULT '',
	"party_tax_number" varchar DEFAULT '',
	"total_after_tax" numeric NOT NULL,
	"is_credit" boolean DEFAULT false NOT NULL,
	"payment_due_date" timestamp,
	"amount_paid" numeric NOT NULL,
	"amount_due" numeric NOT NULL,
	"is_fully_paid" boolean DEFAULT false NOT NULL,
	"payment_completion_date" timestamp,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "sales_company_id_invoice_number_unique" UNIQUE("company_id","invoice_number")
);
--> statement-breakpoint
CREATE TABLE "sale_items" (
	"sale_id" integer NOT NULL,
	"item_id" integer NOT NULL,
	"item_name" varchar NOT NULL,
	"company_id" integer NOT NULL,
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
	CONSTRAINT "sale_items_sale_id_item_id_pk" PRIMARY KEY("sale_id","item_id")
);
--> statement-breakpoint
CREATE TABLE "sale_item_profits" (
	"sale_id" integer,
	"item_id" integer,
	"company_id" integer,
	"total_profit" numeric,
	"price_per_unit" numeric NOT NULL,
	"units_sold" numeric NOT NULL,
	"cost_of_items" jsonb[],
	"purchase_ids" integer[] DEFAULT ARRAY[]::integer[],
	"remaining_units_for_profit_calc" numeric,
	CONSTRAINT "sale_item_profits_sale_id_item_id_pk" PRIMARY KEY("sale_id","item_id")
);
--> statement-breakpoint
CREATE TABLE "sale_returns" (
	"sale_return_id" serial PRIMARY KEY NOT NULL,
	"sale_return_number" integer NOT NULL,
	"sale_id" integer NOT NULL,
	"invoice_number" integer NOT NULL,
	"company_id" integer NOT NULL,
	"subtotal" numeric NOT NULL,
	"tax" numeric DEFAULT '0' NOT NULL,
	"tax_percent" numeric DEFAULT '0' NOT NULL,
	"tax_name" varchar DEFAULT '' NOT NULL,
	"total_after_tax" numeric NOT NULL,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "sale_returns_company_id_sale_return_number_unique" UNIQUE("company_id","sale_return_number")
);
--> statement-breakpoint
CREATE TABLE "sale_return_items" (
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
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "sale_return_items_sale_return_id_item_id_pk" PRIMARY KEY("sale_return_id","item_id")
);
--> statement-breakpoint
CREATE TABLE "tax_details" (
	"tax_id" serial PRIMARY KEY NOT NULL,
	"country_id" integer NOT NULL,
	"tax_name" varchar NOT NULL,
	"tax_percentage" numeric NOT NULL,
	"tax_nickname" varchar NOT NULL,
	"is_tax_on_invoice" boolean DEFAULT false,
	"is_registration_optional" boolean DEFAULT true
);
--> statement-breakpoint
CREATE TABLE "third_parties" (
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
CREATE TABLE "transfer_items" (
	"transfer_id" integer NOT NULL,
	"item_id" integer NOT NULL,
	"item_name" varchar NOT NULL,
	"unit_id" integer NOT NULL,
	"unit_name" varchar NOT NULL,
	"units_transferred" numeric NOT NULL,
	"price_history_of_stock_transferred" jsonb[],
	CONSTRAINT "transfer_items_transfer_id_item_id_pk" PRIMARY KEY("transfer_id","item_id")
);
--> statement-breakpoint
CREATE TABLE "transfers" (
	"transfer_id" serial PRIMARY KEY NOT NULL,
	"from_company_id" integer NOT NULL,
	"to_company_id" integer NOT NULL,
	"from_company_name" varchar NOT NULL,
	"to_company_name" varchar NOT NULL,
	"done_by" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "units" (
	"unit_id" serial PRIMARY KEY NOT NULL,
	"unit_name" varchar NOT NULL,
	"company_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE "users" (
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
CREATE TABLE "user_company_mapping" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_id" uuid,
	"company_id" integer,
	"role_id" integer,
	CONSTRAINT "user_company_mapping_user_id_company_id_role_id_unique" UNIQUE("user_id","company_id","role_id")
);
--> statement-breakpoint
ALTER TABLE "cash_in_out" ADD CONSTRAINT "cash_in_out_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cash_in_out" ADD CONSTRAINT "cash_in_out_purchase_id_purchases_purchase_id_fk" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchases"("purchase_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cash_in_out" ADD CONSTRAINT "cash_in_out_sale_id_sales_sale_id_fk" FOREIGN KEY ("sale_id") REFERENCES "public"."sales"("sale_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "companies" ADD CONSTRAINT "companies_country_id_countries_country_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("country_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "companies" ADD CONSTRAINT "companies_created_by_users_user_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "company_tax_mapping" ADD CONSTRAINT "company_tax_mapping_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "company_tax_mapping" ADD CONSTRAINT "company_tax_mapping_tax_id_tax_details_tax_id_fk" FOREIGN KEY ("tax_id") REFERENCES "public"."tax_details"("tax_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "items" ADD CONSTRAINT "items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "items" ADD CONSTRAINT "items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "item_adjustments" ADD CONSTRAINT "item_adjustments_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "item_adjustments" ADD CONSTRAINT "item_adjustments_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "item_adjustments" ADD CONSTRAINT "item_adjustments_done_by_users_user_id_fk" FOREIGN KEY ("done_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchases" ADD CONSTRAINT "purchases_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchases" ADD CONSTRAINT "purchases_party_id_third_parties_party_id_fk" FOREIGN KEY ("party_id") REFERENCES "public"."third_parties"("party_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_items" ADD CONSTRAINT "purchase_items_purchase_id_purchases_purchase_id_fk" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchases"("purchase_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_items" ADD CONSTRAINT "purchase_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_items" ADD CONSTRAINT "purchase_items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_items" ADD CONSTRAINT "purchase_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_returns" ADD CONSTRAINT "purchase_returns_purchase_id_purchases_purchase_id_fk" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchases"("purchase_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_returns" ADD CONSTRAINT "purchase_returns_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_return_items" ADD CONSTRAINT "purchase_return_items_purchase_return_id_purchase_returns_purchase_return_id_fk" FOREIGN KEY ("purchase_return_id") REFERENCES "public"."purchase_returns"("purchase_return_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_return_items" ADD CONSTRAINT "purchase_return_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_return_items" ADD CONSTRAINT "purchase_return_items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "purchase_return_items" ADD CONSTRAINT "purchase_return_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quotations" ADD CONSTRAINT "quotations_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quotations" ADD CONSTRAINT "quotations_created_by_users_user_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quotations" ADD CONSTRAINT "quotations_party_id_third_parties_party_id_fk" FOREIGN KEY ("party_id") REFERENCES "public"."third_parties"("party_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quotation_items" ADD CONSTRAINT "quotation_items_quotation_id_quotations_quotation_id_fk" FOREIGN KEY ("quotation_id") REFERENCES "public"."quotations"("quotation_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quotation_items" ADD CONSTRAINT "quotation_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quotation_items" ADD CONSTRAINT "quotation_items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quotation_items" ADD CONSTRAINT "quotation_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reports" ADD CONSTRAINT "reports_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reports" ADD CONSTRAINT "reports_requested_by_users_user_id_fk" FOREIGN KEY ("requested_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "roles" ADD CONSTRAINT "roles_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sales" ADD CONSTRAINT "sales_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sales" ADD CONSTRAINT "sales_party_id_third_parties_party_id_fk" FOREIGN KEY ("party_id") REFERENCES "public"."third_parties"("party_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sales" ADD CONSTRAINT "sales_done_by_users_user_id_fk" FOREIGN KEY ("done_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_items" ADD CONSTRAINT "sale_items_sale_id_sales_sale_id_fk" FOREIGN KEY ("sale_id") REFERENCES "public"."sales"("sale_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_items" ADD CONSTRAINT "sale_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_items" ADD CONSTRAINT "sale_items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_items" ADD CONSTRAINT "sale_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_item_profits" ADD CONSTRAINT "sale_item_profits_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_item_profits" ADD CONSTRAINT "sale_item_profits_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_returns" ADD CONSTRAINT "sale_returns_sale_id_sales_sale_id_fk" FOREIGN KEY ("sale_id") REFERENCES "public"."sales"("sale_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_returns" ADD CONSTRAINT "sale_returns_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_return_items" ADD CONSTRAINT "sale_return_items_sale_return_id_sale_returns_sale_return_id_fk" FOREIGN KEY ("sale_return_id") REFERENCES "public"."sale_returns"("sale_return_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_return_items" ADD CONSTRAINT "sale_return_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_return_items" ADD CONSTRAINT "sale_return_items_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sale_return_items" ADD CONSTRAINT "sale_return_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tax_details" ADD CONSTRAINT "tax_details_country_id_countries_country_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("country_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "third_parties" ADD CONSTRAINT "third_parties_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "third_parties" ADD CONSTRAINT "third_parties_country_id_countries_country_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("country_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transfer_items" ADD CONSTRAINT "transfer_items_transfer_id_transfers_transfer_id_fk" FOREIGN KEY ("transfer_id") REFERENCES "public"."transfers"("transfer_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transfer_items" ADD CONSTRAINT "transfer_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transfer_items" ADD CONSTRAINT "transfer_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transfers" ADD CONSTRAINT "transfers_from_company_id_companies_company_id_fk" FOREIGN KEY ("from_company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transfers" ADD CONSTRAINT "transfers_to_company_id_companies_company_id_fk" FOREIGN KEY ("to_company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transfers" ADD CONSTRAINT "transfers_done_by_users_user_id_fk" FOREIGN KEY ("done_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "units" ADD CONSTRAINT "units_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_country_id_countries_country_id_fk" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("country_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_company_mapping" ADD CONSTRAINT "user_company_mapping_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_company_mapping" ADD CONSTRAINT "user_company_mapping_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_company_mapping" ADD CONSTRAINT "user_company_mapping_role_id_roles_role_id_fk" FOREIGN KEY ("role_id") REFERENCES "public"."roles"("role_id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "transaction_date_time_index" ON "cash_in_out" USING btree ("transaction_date_time");--> statement-breakpoint
CREATE INDEX "company_id_index" ON "cash_in_out" USING btree ("company_id");