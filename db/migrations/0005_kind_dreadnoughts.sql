ALTER TABLE "purchases" ALTER COLUMN "payment_due_date" SET DATA TYPE timestamp;--> statement-breakpoint
ALTER TABLE "purchases" ALTER COLUMN "payment_completion_date" SET DATA TYPE timestamp;--> statement-breakpoint
ALTER TABLE "sales" ALTER COLUMN "payment_due_date" SET DATA TYPE timestamp;--> statement-breakpoint
ALTER TABLE "sales" ALTER COLUMN "payment_completion_date" SET DATA TYPE timestamp;