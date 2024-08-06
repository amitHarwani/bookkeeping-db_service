CREATE TABLE IF NOT EXISTS "role_feature_mapping" (
	"role_id" integer,
	"feature_id" integer,
	"feature_name" varchar NOT NULL,
	CONSTRAINT "role_feature_mapping_role_id_feature_id_pk" PRIMARY KEY("role_id","feature_id")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "role_feature_mapping" ADD CONSTRAINT "role_feature_mapping_role_id_roles_role_id_fk" FOREIGN KEY ("role_id") REFERENCES "public"."roles"("role_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "role_feature_mapping" ADD CONSTRAINT "role_feature_mapping_feature_id_platform_features_feature_id_fk" FOREIGN KEY ("feature_id") REFERENCES "public"."platform_features"("feature_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
ALTER TABLE "roles" DROP COLUMN IF EXISTS "acl";