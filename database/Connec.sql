BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "user" (
	"user_id"	TEXT NOT NULL UNIQUE,
	"user_name"	TEXT,
	"user_job"	TEXT,
	"user_career"	TEXT,
	"user_location"	TEXT,
	"user_gender"	INTEGER,
	"user_capable"	TEXT,
	"user_introduction"	TEXT,
	PRIMARY KEY("user_id")
);
CREATE TABLE IF NOT EXISTS "requested_relation" (
	"request_id"	INTEGER NOT NULL UNIQUE,
	"user_id"	TEXT NOT NULL,
	"friend_id"	TEXT NOT NULL,
	"relationship"	INTEGER NOT NULL,
	PRIMARY KEY("request_id" AUTOINCREMENT),
	FOREIGN KEY("friend_id") REFERENCES "user"("user_id"),
	FOREIGN KEY("user_id") REFERENCES "user"("user_id")
);
CREATE TABLE IF NOT EXISTS "login" (
	"user_id"	TEXT NOT NULL UNIQUE,
    "user_email"	TEXT NOT NULL UNIQUE,
	"user_password"	TEXT NOT NULL,
	"user_authority"	TEXT NOT NULL,
	"social_code"	INTEGER,
	PRIMARY KEY("user_id"),
	FOREIGN KEY("user_id") REFERENCES "user"("user_id")
);
CREATE TABLE IF NOT EXISTS "relation" (
	"relation_id"	INTEGER NOT NULL UNIQUE,
	"user_id"	TEXT NOT NULL,
	"friend_id"	TEXT NOT NULL,
	"relationship"	INTEGER NOT NULL,
	PRIMARY KEY("relation_id" AUTOINCREMENT),
	FOREIGN KEY("friend_id") REFERENCES "user"("user_id"),
	FOREIGN KEY("user_id") REFERENCES "user"("user_id")
);
COMMIT;
