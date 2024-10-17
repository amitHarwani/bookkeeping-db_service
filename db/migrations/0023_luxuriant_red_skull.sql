ALTER TABLE "cash_in_out" ADD COLUMN "sale_return_id" integer;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "cash_in_out" ADD CONSTRAINT "cash_in_out_sale_return_id_sale_returns_sale_return_id_fk" FOREIGN KEY ("sale_return_id") REFERENCES "public"."sale_returns"("sale_return_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
