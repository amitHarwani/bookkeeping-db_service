ALTER TABLE "quotations" ADD COLUMN "party_id" integer;--> statement-breakpoint
ALTER TABLE "quotations" ADD COLUMN "party_name" varchar;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "quotations" ADD CONSTRAINT "quotations_party_id_third_parties_party_id_fk" FOREIGN KEY ("party_id") REFERENCES "public"."third_parties"("party_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
