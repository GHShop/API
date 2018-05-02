-- +micrate Up
CREATE TABLE sales (
  id BIGSERIAL PRIMARY KEY,
  count INT,
  price INT,
  product_id BIGINT,
  clerk_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX sale_product_id_idx ON sales (product_id);
CREATE INDEX sale_clerk_id_idx ON sales (clerk_id);

-- +micrate Down
DROP TABLE IF EXISTS sales;
