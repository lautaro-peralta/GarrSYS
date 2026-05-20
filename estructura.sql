-- PostgreSQL database structure for The Garrison System

--
-- Table structure for table "admins"
--
DROP TABLE IF EXISTS "admins" CASCADE;
CREATE TABLE "admins" (
  "id" VARCHAR(36) NOT NULL,
  "dni" VARCHAR(255) NOT NULL,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL,
  "user_id" VARCHAR(36) DEFAULT NULL,
  "department" VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "admins_dni_unique" UNIQUE ("dni"),
  CONSTRAINT "admins_user_id_unique" UNIQUE ("user_id")
);

--
-- Table structure for table "zones"
--
DROP TABLE IF EXISTS "zones" CASCADE;
CREATE TABLE "zones" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "is_headquarters" BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT "zones_name_unique" UNIQUE ("name")
);

--
-- Table structure for table "authorities"
--
DROP TABLE IF EXISTS "authorities" CASCADE;
CREATE TABLE "authorities" (
  "id" VARCHAR(36) NOT NULL,
  "dni" VARCHAR(255) NOT NULL,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL,
  "user_id" VARCHAR(36) DEFAULT NULL,
  "rank" INT NOT NULL,
  "zone_id" INT NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "authorities_dni_unique" UNIQUE ("dni"),
  CONSTRAINT "authorities_user_id_unique" UNIQUE ("user_id")
);
CREATE INDEX "authorities_zone_id_index" ON "authorities" ("zone_id");

--
-- Table structure for table "clients"
--
DROP TABLE IF EXISTS "clients" CASCADE;
CREATE TABLE "clients" (
  "id" VARCHAR(36) NOT NULL,
  "dni" VARCHAR(255) NOT NULL,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL,
  "user_id" VARCHAR(36) DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "clients_dni_unique" UNIQUE ("dni"),
  CONSTRAINT "clients_user_id_unique" UNIQUE ("user_id")
);

--
-- Table structure for table "distributors"
--
DROP TABLE IF EXISTS "distributors" CASCADE;
CREATE TABLE "distributors" (
  "id" VARCHAR(36) NOT NULL,
  "dni" VARCHAR(255) NOT NULL,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL,
  "user_id" VARCHAR(36) DEFAULT NULL,
  "zone_id" INT DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "distributors_dni_unique" UNIQUE ("dni"),
  CONSTRAINT "distributors_user_id_unique" UNIQUE ("user_id")
);
CREATE INDEX "distributors_zone_id_index" ON "distributors" ("zone_id");

--
-- Table structure for table "products"
--
DROP TABLE IF EXISTS "products" CASCADE;
CREATE TABLE "products" (
  "id" SERIAL PRIMARY KEY,
  "description" VARCHAR(255) NOT NULL,
  "detail" VARCHAR(255) NOT NULL,
  "price" INT NOT NULL,
  "stock" INT NOT NULL,
  "is_illegal" BOOLEAN NOT NULL DEFAULT FALSE
);

--
-- Table structure for table "distributors_products"
--
DROP TABLE IF EXISTS "distributors_products" CASCADE;
CREATE TABLE "distributors_products" (
  "distributor_id" VARCHAR(36) NOT NULL,
  "product_id" INT NOT NULL,
  PRIMARY KEY ("distributor_id", "product_id")
);
CREATE INDEX "distributors_products_distributor_id_index" ON "distributors_products" ("distributor_id");
CREATE INDEX "distributors_products_product_id_index" ON "distributors_products" ("product_id");

--
-- Table structure for table "sales"
--
DROP TABLE IF EXISTS "sales" CASCADE;
CREATE TABLE "sales" (
  "id" SERIAL PRIMARY KEY,
  "description" VARCHAR(255) DEFAULT NULL,
  "sale_date" TIMESTAMP NOT NULL,
  "sale_amount" INT NOT NULL,
  "distributor_id" VARCHAR(36) NOT NULL,
  "client_id" VARCHAR(36) DEFAULT NULL,
  "authority_id" VARCHAR(36) DEFAULT NULL
);
CREATE INDEX "sales_distributor_id_index" ON "sales" ("distributor_id");
CREATE INDEX "sales_client_id_index" ON "sales" ("client_id");
CREATE INDEX "sales_authority_id_index" ON "sales" ("authority_id");

--
-- Table structure for table "sale_details"
--
DROP TABLE IF EXISTS "sale_details" CASCADE;
CREATE TABLE "sale_details" (
  "id" SERIAL PRIMARY KEY,
  "quantity" INT NOT NULL,
  "subtotal" DECIMAL(10,2) NOT NULL,
  "sale_id" INT NOT NULL,
  "product_id" INT NOT NULL
);
CREATE INDEX "sale_details_sale_id_index" ON "sale_details" ("sale_id");
CREATE INDEX "sale_details_product_id_index" ON "sale_details" ("product_id");

--
-- Table structure for table "bribes"
--
DROP TABLE IF EXISTS "bribes" CASCADE;
CREATE TABLE "bribes" (
  "id" SERIAL PRIMARY KEY,
  "amount" INT NOT NULL,
  "paid" BOOLEAN NOT NULL DEFAULT FALSE,
  "creation_date" TIMESTAMP NOT NULL,
  "authority_id" VARCHAR(36) NOT NULL,
  "sale_id" INT NOT NULL
);
CREATE INDEX "bribes_authority_id_index" ON "bribes" ("authority_id");
CREATE INDEX "bribes_sale_id_index" ON "bribes" ("sale_id");

--
-- Table structure for table "topics"
--
DROP TABLE IF EXISTS "topics" CASCADE;
CREATE TABLE "topics" (
  "id" SERIAL PRIMARY KEY,
  "description" VARCHAR(255) NOT NULL
);

--
-- Table structure for table "strategic_decisions"
--
DROP TABLE IF EXISTS "strategic_decisions" CASCADE;
CREATE TABLE "strategic_decisions" (
  "id" SERIAL PRIMARY KEY,
  "description" VARCHAR(255) NOT NULL,
  "start_date" TIMESTAMP NOT NULL,
  "end_date" TIMESTAMP NOT NULL,
  "topic_id" INT NOT NULL
);
CREATE INDEX "strategic_decisions_topic_id_index" ON "strategic_decisions" ("topic_id");

--
-- Table structure for table "partners"
--
DROP TABLE IF EXISTS "partners" CASCADE;
CREATE TABLE "partners" (
  "id" VARCHAR(36) NOT NULL,
  "dni" VARCHAR(255) NOT NULL,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL,
  "user_id" VARCHAR(36) DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "partners_dni_unique" UNIQUE ("dni"),
  CONSTRAINT "partners_user_id_unique" UNIQUE ("user_id")
);

--
-- Table structure for table "consejos_shelby"
--
DROP TABLE IF EXISTS "consejos_shelby" CASCADE;
CREATE TABLE "consejos_shelby" (
  "id" SERIAL PRIMARY KEY,
  "partner_id" VARCHAR(36) NOT NULL,
  "decision_id" INT NOT NULL,
  "join_date" TIMESTAMP NOT NULL,
  "role" VARCHAR(255) DEFAULT NULL,
  "notes" VARCHAR(255) DEFAULT NULL
);
CREATE INDEX "consejos_shelby_partner_id_index" ON "consejos_shelby" ("partner_id");
CREATE INDEX "consejos_shelby_decision_id_index" ON "consejos_shelby" ("decision_id");

--
-- Table structure for table "clandestine_agreements"
--
DROP TABLE IF EXISTS "clandestine_agreements" CASCADE;
CREATE TABLE "clandestine_agreements" (
  "id" SERIAL PRIMARY KEY,
  "shelby_council_id" INT NOT NULL,
  "admin_id" VARCHAR(36) NOT NULL,
  "authority_id" VARCHAR(36) NOT NULL,
  "agreement_date" TIMESTAMP NOT NULL,
  "description" VARCHAR(255) DEFAULT NULL,
  "status" VARCHAR(255) NOT NULL DEFAULT 'ACTIVE'
);
CREATE INDEX "clandestine_agreements_shelby_council_id_index" ON "clandestine_agreements" ("shelby_council_id");
CREATE INDEX "clandestine_agreements_admin_id_index" ON "clandestine_agreements" ("admin_id");
CREATE INDEX "clandestine_agreements_authority_id_index" ON "clandestine_agreements" ("authority_id");

--
-- Table structure for table "email_verifications"
--
DROP TABLE IF EXISTS "email_verifications" CASCADE;
CREATE TABLE "email_verifications" (
  "id" SERIAL PRIMARY KEY,
  "token" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "status" VARCHAR(255) NOT NULL,
  "expires_at" TIMESTAMP NOT NULL,
  "verified_at" TIMESTAMP DEFAULT NULL,
  "created_at" TIMESTAMP NOT NULL
);

--
-- Table structure for table "monthly_reviews"
--
DROP TABLE IF EXISTS "monthly_reviews" CASCADE;
CREATE TABLE "monthly_reviews" (
  "id" SERIAL PRIMARY KEY,
  "year" INT NOT NULL,
  "month" INT NOT NULL,
  "review_date" TIMESTAMP NOT NULL,
  "status" VARCHAR(255) NOT NULL DEFAULT 'PENDING',
  "observations" TEXT DEFAULT NULL,
  "total_sales_amount" INT DEFAULT NULL,
  "total_sales_count" INT DEFAULT NULL,
  "recommendations" TEXT DEFAULT NULL,
  "created_at" TIMESTAMP NOT NULL,
  "updated_at" TIMESTAMP NOT NULL,
  "reviewed_by_id" VARCHAR(36) NOT NULL
);
CREATE INDEX "monthly_reviews_reviewed_by_id_index" ON "monthly_reviews" ("reviewed_by_id");

--
-- Table structure for table "persons"
--
DROP TABLE IF EXISTS "persons" CASCADE;
CREATE TABLE "persons" (
  "id" VARCHAR(36) NOT NULL,
  "dni" VARCHAR(255) NOT NULL,
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "phone" VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL,
  "user_id" VARCHAR(36) DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "persons_dni_unique" UNIQUE ("dni"),
  CONSTRAINT "persons_user_id_unique" UNIQUE ("user_id")
);

--
-- Table structure for table "users"
--
DROP TABLE IF EXISTS "users" CASCADE;
CREATE TABLE "users" (
  "id" VARCHAR(36) NOT NULL,
  "username" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "password" VARCHAR(255) NOT NULL,
  "roles" TEXT NOT NULL,
  "is_active" BOOLEAN NOT NULL DEFAULT TRUE,
  "is_verified" BOOLEAN NOT NULL DEFAULT FALSE,
  "email_verified" BOOLEAN NOT NULL DEFAULT FALSE,
  "last_login_at" TIMESTAMP DEFAULT NULL,
  "profile_completeness" INT NOT NULL DEFAULT 25,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "person_id" VARCHAR(36) DEFAULT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "users_username_unique" UNIQUE ("username"),
  CONSTRAINT "users_email_unique" UNIQUE ("email"),
  CONSTRAINT "users_person_id_unique" UNIQUE ("person_id")
);

--
-- Table structure for table "refresh_tokens"
--
DROP TABLE IF EXISTS "refresh_tokens" CASCADE;
CREATE TABLE "refresh_tokens" (
  "id" VARCHAR(36) NOT NULL,
  "token" VARCHAR(255) NOT NULL,
  "expires_at" TIMESTAMP NOT NULL,
  "created_at" TIMESTAMP NOT NULL,
  "ip_address" VARCHAR(255) DEFAULT NULL,
  "user_agent" VARCHAR(255) DEFAULT NULL,
  "is_revoked" BOOLEAN NOT NULL DEFAULT FALSE,
  "revoked_at" TIMESTAMP DEFAULT NULL,
  "user_id" VARCHAR(36) NOT NULL,
  PRIMARY KEY ("id"),
  CONSTRAINT "refresh_tokens_token_unique" UNIQUE ("token")
);
CREATE INDEX "refresh_tokens_user_id_index" ON "refresh_tokens" ("user_id");

--
-- Table structure for table "role_requests"
--
DROP TABLE IF EXISTS "role_requests" CASCADE;
CREATE TABLE "role_requests" (
  "id" VARCHAR(36) NOT NULL,
  "requested_role" VARCHAR(255) NOT NULL,
  "role_to_remove" VARCHAR(255) DEFAULT NULL,
  "status" VARCHAR(255) NOT NULL DEFAULT 'PENDING',
  "justification" TEXT DEFAULT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "reviewed_at" TIMESTAMP DEFAULT NULL,
  "admin_comments" TEXT DEFAULT NULL,
  "user_id" VARCHAR(36) NOT NULL,
  "reviewed_by_id" VARCHAR(36) DEFAULT NULL,
  PRIMARY KEY ("id")
);
CREATE INDEX "role_requests_user_id_index" ON "role_requests" ("user_id");
CREATE INDEX "role_requests_reviewed_by_id_index" ON "role_requests" ("reviewed_by_id");

--
-- Table structure for table "partners_decisions"
--
DROP TABLE IF EXISTS "partners_decisions" CASCADE;
CREATE TABLE "partners_decisions" (
  "partner_id" VARCHAR(36) NOT NULL,
  "strategic_decision_id" INT NOT NULL,
  PRIMARY KEY ("partner_id", "strategic_decision_id")
);
CREATE INDEX "partners_decisions_partner_id_index" ON "partners_decisions" ("partner_id");
CREATE INDEX "partners_decisions_strategic_decision_id_index" ON "partners_decisions" ("strategic_decision_id");

--
-- Table structure for table "strategic_decisions_socios"
--
DROP TABLE IF EXISTS "strategic_decisions_socios" CASCADE;
CREATE TABLE "strategic_decisions_socios" (
  "strategic_decision_id" INT NOT NULL,
  "user_id" VARCHAR(36) NOT NULL,
  PRIMARY KEY ("strategic_decision_id", "user_id")
);
CREATE INDEX "strategic_decisions_socios_strategic_decision_id_index" ON "strategic_decisions_socios" ("strategic_decision_id");
CREATE INDEX "strategic_decisions_socios_user_id_index" ON "strategic_decisions_socios" ("user_id");

--
-- Table structure for table "user_verifications"
--
DROP TABLE IF EXISTS "user_verifications" CASCADE;
CREATE TABLE "user_verifications" (
  "id" SERIAL PRIMARY KEY,
  "token" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "status" VARCHAR(255) NOT NULL,
  "expires_at" TIMESTAMP NOT NULL,
  "verified_at" TIMESTAMP DEFAULT NULL,
  "attempts" INT NOT NULL,
  "max_attempts" INT NOT NULL,
  "created_at" TIMESTAMP NOT NULL,
  "updated_at" TIMESTAMP NOT NULL
);

--
-- FOREIGN KEYS
--

ALTER TABLE "admins"
  ADD CONSTRAINT "admins_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "authorities"
  ADD CONSTRAINT "authorities_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT "authorities_zone_id_foreign" FOREIGN KEY ("zone_id") REFERENCES "zones" ("id") ON UPDATE CASCADE;

ALTER TABLE "bribes"
  ADD CONSTRAINT "bribes_authority_id_foreign" FOREIGN KEY ("authority_id") REFERENCES "authorities" ("id") ON UPDATE CASCADE,
  ADD CONSTRAINT "bribes_sale_id_foreign" FOREIGN KEY ("sale_id") REFERENCES "sales" ("id") ON UPDATE CASCADE;

ALTER TABLE "clandestine_agreements"
  ADD CONSTRAINT "clandestine_agreements_admin_id_foreign" FOREIGN KEY ("admin_id") REFERENCES "admins" ("id") ON UPDATE CASCADE,
  ADD CONSTRAINT "clandestine_agreements_authority_id_foreign" FOREIGN KEY ("authority_id") REFERENCES "authorities" ("id") ON UPDATE CASCADE,
  ADD CONSTRAINT "clandestine_agreements_shelby_council_id_foreign" FOREIGN KEY ("shelby_council_id") REFERENCES "consejos_shelby" ("id") ON UPDATE CASCADE;

ALTER TABLE "clients"
  ADD CONSTRAINT "clients_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "consejos_shelby"
  ADD CONSTRAINT "consejos_shelby_decision_id_foreign" FOREIGN KEY ("decision_id") REFERENCES "strategic_decisions" ("id") ON UPDATE CASCADE,
  ADD CONSTRAINT "consejos_shelby_partner_id_foreign" FOREIGN KEY ("partner_id") REFERENCES "partners" ("id") ON UPDATE CASCADE;

ALTER TABLE "distributors"
  ADD CONSTRAINT "distributors_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT "distributors_zone_id_foreign" FOREIGN KEY ("zone_id") REFERENCES "zones" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "distributors_products"
  ADD CONSTRAINT "distributors_products_distributor_id_foreign" FOREIGN KEY ("distributor_id") REFERENCES "distributors" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT "distributors_products_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "monthly_reviews"
  ADD CONSTRAINT "monthly_reviews_reviewed_by_id_foreign" FOREIGN KEY ("reviewed_by_id") REFERENCES "partners" ("id") ON UPDATE CASCADE;

ALTER TABLE "partners"
  ADD CONSTRAINT "partners_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "partners_decisions"
  ADD CONSTRAINT "partners_decisions_partner_id_foreign" FOREIGN KEY ("partner_id") REFERENCES "partners" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT "partners_decisions_strategic_decision_id_foreign" FOREIGN KEY ("strategic_decision_id") REFERENCES "strategic_decisions" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "persons"
  ADD CONSTRAINT "persons_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE "refresh_tokens"
  ADD CONSTRAINT "refresh_tokens_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON UPDATE CASCADE;

ALTER TABLE "role_requests"
  ADD CONSTRAINT "role_requests_reviewed_by_id_foreign" FOREIGN KEY ("reviewed_by_id") REFERENCES "users" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT "role_requests_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON UPDATE CASCADE;

ALTER TABLE "sale_details"
  ADD CONSTRAINT "sale_details_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "products" ("id") ON UPDATE CASCADE,
  ADD CONSTRAINT "sale_details_sale_id_foreign" FOREIGN KEY ("sale_id") REFERENCES "sales" ("id") ON UPDATE CASCADE;

ALTER TABLE "sales"
  ADD CONSTRAINT "sales_authority_id_foreign" FOREIGN KEY ("authority_id") REFERENCES "authorities" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT "sales_client_id_foreign" FOREIGN KEY ("client_id") REFERENCES "clients" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT "sales_distributor_id_foreign" FOREIGN KEY ("distributor_id") REFERENCES "distributors" ("id") ON UPDATE CASCADE;

ALTER TABLE "strategic_decisions"
  ADD CONSTRAINT "strategic_decisions_topic_id_foreign" FOREIGN KEY ("topic_id") REFERENCES "topics" ("id") ON UPDATE CASCADE;

ALTER TABLE "strategic_decisions_socios"
  ADD CONSTRAINT "strategic_decisions_socios_strategic_decision_id_foreign" FOREIGN KEY ("strategic_decision_id") REFERENCES "strategic_decisions" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT "strategic_decisions_socios_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "users"
  ADD CONSTRAINT "users_person_id_foreign" FOREIGN KEY ("person_id") REFERENCES "persons" ("id") ON DELETE SET NULL ON UPDATE CASCADE;
