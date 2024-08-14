DO $$ BEGIN
 CREATE TYPE "public"."user_types" AS ENUM('DEFAULT_ADMIN_USER');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "default_features" (
	"id" serial PRIMARY KEY NOT NULL,
	"user_type" "user_types",
	"acl" integer[] DEFAULT ARRAY[]::integer[],
	CONSTRAINT "default_features_user_type_unique" UNIQUE("user_type")
);
