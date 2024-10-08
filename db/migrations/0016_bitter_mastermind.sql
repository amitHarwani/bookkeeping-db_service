ALTER TABLE "item_transfers" RENAME TO "transfers";--> statement-breakpoint
ALTER TABLE "transfers" DROP CONSTRAINT "item_transfers_from_company_id_companies_company_id_fk";
--> statement-breakpoint
ALTER TABLE "transfers" DROP CONSTRAINT "item_transfers_to_company_id_companies_company_id_fk";
--> statement-breakpoint
ALTER TABLE "transfers" DROP CONSTRAINT "item_transfers_done_by_users_user_id_fk";
--> statement-breakpoint
ALTER TABLE "transfer_items" DROP CONSTRAINT "transfer_items_transfer_id_item_transfers_transfer_id_fk";
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfers" ADD CONSTRAINT "transfers_from_company_id_companies_company_id_fk" FOREIGN KEY ("from_company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfers" ADD CONSTRAINT "transfers_to_company_id_companies_company_id_fk" FOREIGN KEY ("to_company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfers" ADD CONSTRAINT "transfers_done_by_users_user_id_fk" FOREIGN KEY ("done_by") REFERENCES "public"."users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_items" ADD CONSTRAINT "transfer_items_transfer_id_transfers_transfer_id_fk" FOREIGN KEY ("transfer_id") REFERENCES "public"."transfers"("transfer_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
