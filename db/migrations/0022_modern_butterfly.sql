ALTER TABLE "sale_returns" DROP CONSTRAINT "sale_returns_party_id_third_parties_party_id_fk";
--> statement-breakpoint
ALTER TABLE "sale_returns" DROP COLUMN IF EXISTS "company_tax_number";--> statement-breakpoint
ALTER TABLE "sale_returns" DROP COLUMN IF EXISTS "party_tax_number";--> statement-breakpoint
ALTER TABLE "sale_returns" DROP COLUMN IF EXISTS "party_id";--> statement-breakpoint
ALTER TABLE "sale_returns" DROP COLUMN IF EXISTS "party_name";--> statement-breakpoint
ALTER TABLE "sale_returns" DROP COLUMN IF EXISTS "is_no_party_bill";