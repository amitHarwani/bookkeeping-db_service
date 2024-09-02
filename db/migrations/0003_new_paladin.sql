ALTER TABLE "purchases" ADD COLUMN "tax" numeric DEFAULT '0' NOT NULL;--> statement-breakpoint
ALTER TABLE "purchase_items" ADD COLUMN "tax" numeric DEFAULT '0' NOT NULL;