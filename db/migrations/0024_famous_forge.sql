ALTER TABLE "cash_in_out" DROP CONSTRAINT "cash_in_out_sale_return_id_sale_returns_sale_return_id_fk";
--> statement-breakpoint
ALTER TABLE "cash_in_out" DROP COLUMN IF EXISTS "sale_return_id";