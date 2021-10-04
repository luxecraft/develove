CREATE TABLE "users" (
  "username" varchar,
  "email" varchar,
  "fullName" varchar,
  "tags" varchar,
  "uid" integer primary key,
);

CREATE TABLE "guilds" (
  "name" varchar,
  "members" varchar,
  "uid" integer,
  "tags" varchar,
  "gid" integer
);

CREATE TABLE "posts" (
  "title" varchar,
  "tags" varchar,
  "uid" integer,
  "data" text,
  "hearts" integer
  "pid" integer primary key
);

CREATE TABLE "gid" (
  "mid" integer,
  "timestamp" timestamp,
  "text" varchar,
  "uid" integer
);

CREATE TABLE "thread" (
  "tid" integer,
  "uid" integer,
  "title" varchar,
  "tags" varchar
);

CREATE TABLE "answers" (
  "fid" integer,
  "tid" integer,
  "upvotes" integer
);

CREATE TABLE "connections" (
  "fid" integer,
  "tid" integer,
  "connected" boolean
);

CREATE TABLE "invites" (
  "gid" integer,
  "uid" integer
);

ALTER TABLE "posts" ADD FOREIGN KEY ("uid") REFERENCES "users" ("uid");

ALTER TABLE "thread" ADD FOREIGN KEY ("uid") REFERENCES "users" ("uid");

ALTER TABLE "thread" ADD FOREIGN KEY ("tid") REFERENCES "answers" ("tid");

ALTER TABLE "users" ADD FOREIGN KEY ("uid") REFERENCES "gid" ("uid");

ALTER TABLE "users" ADD FOREIGN KEY ("uid") REFERENCES "guilds" ("uid");

ALTER TABLE "invites" ADD FOREIGN KEY ("gid") REFERENCES "guilds" ("gid");

ALTER TABLE "users" ADD FOREIGN KEY ("uid") REFERENCES "invites" ("uid");

ALTER TABLE "connections" ADD FOREIGN KEY ("fid") REFERENCES "users" ("uid");

ALTER TABLE "connections" ADD FOREIGN KEY ("tid") REFERENCES "users" ("uid");