BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "login" (
	"user_id"	INTEGER NOT NULL UNIQUE,
	"user_account"	TEXT NOT NULL UNIQUE,
	"user_password"	TEXT NOT NULL,
	"user_name"	TEXT NOT NULL,
	"user_authority"	INTEGER NOT NULL,
	"social_login_id"	TEXT,
	"social_login_secret"	TEXT,
	"access_token"	TEXT,
	PRIMARY KEY("user_id" AUTOINCREMENT)
);
COMMIT;
