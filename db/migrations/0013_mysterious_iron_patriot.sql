ALTER TABLE "cash_in_out" ADD COLUMN "purchase_id" integer;--> statement-breakpoint
ALTER TABLE "cash_in_out" ADD COLUMN "sale_id" integer;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "cash_in_out" ADD CONSTRAINT "cash_in_out_purchase_id_purchases_purchase_id_fk" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchases"("purchase_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "cash_in_out" ADD CONSTRAINT "cash_in_out_sale_id_sales_sale_id_fk" FOREIGN KEY ("sale_id") REFERENCES "public"."sales"("sale_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "transaction_date_time_index" ON "cash_in_out" USING btree ("transaction_date_time");--> statement-breakpoint
CREATE INDEX IF NOT EXISTS "company_id_index" ON "cash_in_out" USING btree ("company_id");