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
	CONSTRAINT "countries_country_name_unique" UNIQUE("country_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "platform_features" (
	"feature_id" serial PRIMARY KEY NOT NULL,
	"feature_name" varchar NOT NULL,
	"is_enabled" boolean DEFAULT true,
	CONSTRAINT "platform_features_feature_name_unique" UNIQUE("feature_name")
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
	"user_id" uuid,
	"company_id" integer,
	"role_id" integer,
	CONSTRAINT "user_company_mapping_user_id_company_id_pk" PRIMARY KEY("user_id","company_id")
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