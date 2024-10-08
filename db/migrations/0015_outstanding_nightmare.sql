CREATE TABLE IF NOT EXISTS "item_transfers" (
	"transfer_id" serial PRIMARY KEY NOT NULL,
	"from_company_id" integer NOT NULL,
	"to_company_id" integer NOT NULL,
	"from_company_name" varchar NOT NULL,
	"to_company_name" varchar NOT NULL,
	"done_by" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "transfer_items" (
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
DO $$ BEGIN
 ALTER TABLE "item_transfers" ADD CONSTRAINT "item_transfers_from_company_id_companies_company_id_fk" FOREIGN KEY ("from_company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "item_transfers" ADD CONSTRAINT "item_transfers_to_company_id_companies_company_id_fk" FOREIGN KEY ("to_company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "item_transfers" ADD CONSTRAINT "item_transfers_done_by_users_user_id_fk" FOREIGN KEY ("done_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_items" ADD CONSTRAINT "transfer_items_transfer_id_item_transfers_transfer_id_fk" FOREIGN KEY ("transfer_id") REFERENCES "public"."item_transfers"("transfer_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_items" ADD CONSTRAINT "transfer_items_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_items" ADD CONSTRAINT "transfer_items_unit_id_units_unit_id_fk" FOREIGN KEY ("unit_id") REFERENCES "public"."units"("unit_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
