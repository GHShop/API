-- +micrate Up
CREATE TABLE products (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  introduction TEXT,
  cost INT,
  price INT,
  storage INT,
  shelf INT,
  artist_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX index_products_on_artist_id ON "products" USING btree ("artist_id");

-- +micrate Down
DROP TABLE IF EXISTS products;
