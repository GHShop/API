-- +micrate Up
CREATE TABLE artists (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  introduction VARCHAR,
  user_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX index_artists_on_user_id ON "artists" USING btree ("user_id");

-- +micrate Down
DROP TABLE IF EXISTS artists;
