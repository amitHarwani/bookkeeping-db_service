CREATE TABLE IF NOT EXISTS "sale_item_profits" (
	"sale_id" integer,
	"item_id" integer,
	"total_profit" numeric,
	"cost_of_items" jsonb[],
	"purchase_ids" integer[] DEFAULT ARRAY[]::integer[],
	"remaining_units_for_profit_calc" numeric,
	CONSTRAINT "sale_item_profits_sale_id_item_id_pk" PRIMARY KEY("sale_id","item_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_item_profits" ADD CONSTRAINT "sale_item_profits_sale_id_sales_sale_id_fk" FOREIGN KEY ("sale_id") REFERENCES "public"."sales"("sale_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sale_item_profits" ADD CONSTRAINT "sale_item_profits_item_id_items_item_id_fk" FOREIGN KEY ("item_id") REFERENCES "public"."items"("item_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "sale_items" DROP COLUMN IF EXISTS "total_profit";--> statement-breakpoint
ALTER TABLE "sale_items" DROP COLUMN IF EXISTS "cost_of_items";--> statement-breakpoint
ALTER TABLE "sale_items" DROP COLUMN IF EXISTS "purchase_ids";--> statement-breakpoint
ALTER TABLE "sale_items" DROP COLUMN IF EXISTS "remaining_units_for_profit_calc";