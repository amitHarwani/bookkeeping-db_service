DO $$ BEGIN
 CREATE TYPE "public"."adjustment_types" AS ENUM('ADD', 'SUBTRACT');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "item_adjustments" (
	"adjustment_id" serial PRIMARY KEY NOT NULL,
	"item_id" integer NOT NULL,
	"company_id" integer NOT NULL,
	"adjustment_type" "adjustment_types" NOT NULL,
	"stock_adjusted" numeric NOT NULL,
	"reason" varchar NOT NULL,
	"done_by" uuid NOT NULL,
	"adjusted_at" timestamp DEFAULT now()
);
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
