-- +micrate Up
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  oauth_id BIGINT,
  email VARCHAR,
  name VARCHAR,
  level_number INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX index_users_on_oauth_id ON "users" USING btree ("oauth_id")

-- +micrate Down
DROP TABLE IF EXISTS users;
