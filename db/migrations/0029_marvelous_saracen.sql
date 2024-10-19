CREATE TABLE IF NOT EXISTS "reports" (
	"report_id" serial PRIMARY KEY NOT NULL,
	"report_name" varchar NOT NULL,
	"from_date_time" timestamp,
	"to_date_time" timestamp,
	"status" varchar NOT NULL,
	"report_link" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL
);
