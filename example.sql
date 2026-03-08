-- docker compose build
-- docker compose up -d


-- docker compose exec -it flink ./bin/sql-client.sh

show catalogs;
-- CREATE CATALOG iceberg_hive WITH (
--         'type' = 'iceberg',
--         'catalog-type'='hive',
--         'warehouse' = 's3a://warehouse',
--         'hive-conf-dir' = './conf');

CREATE CATALOG iceberg_hive WITH (
  'type' = 'iceberg',
  'catalog-type' = 'hive',
  'warehouse' = 's3a://warehouse/',
  'hive.metastore.uris' = 'thrift://hive-metastore:9083',
  's3.endpoint' = 'http://minio:9000',
  's3.access-key' = 'admin',
  's3.secret-key' = 'password',
  's3.path-style-access' = 'true',
   'hive-conf-dir' = './conf'
);

CREATE DATABASE `iceberg_hive`.`mydb`;

USE `iceberg_hive`.`mydb`;

-- Create the orders table
CREATE TABLE orders (
    order_id STRING,
    name STRING,
    order_value DOUBLE,
    priority INT,
    state STRING,
    order_date STRING,
    customer_id STRING,
    ts STRING
);

-- Insert static values into the orders table
INSERT INTO orders
VALUES
    ('order001', 'Product A', 100.00, 1, 'California', '2024-04-03', 'cust001', '1234567890'),
    ('order002', 'Product B', 150.00, 2, 'New York', '2024-04-03', 'cust002', '1234567890'),
    ('order003', 'Product C', 200.00, 1, 'Texas', '2024-04-03', 'cust003', '1234567890');

-- Verify the inserted data
SELECT * FROM orders;
select count(*) nrows, sum(order_value) total_value from orders;

select
    name,
    count(*) as nrows,
    sum(order_value) as total_value
from orders
group by name;

-- AVRO formats and others

CREATE TABLE sales_rep_avro (
  sales_id BIGINT,
  sales_person_name VARCHAR
)
WITH ('format' = 'AVRO');

INSERT INTO sales_rep_avro VALUES
(25, 'X'),
(4, 'Y'),
(21, 'X'),
(23, 'X');

SELECT
    sales_person_name,
    count(*) nrows,
    avg(sales_id) avg_score,
    sum(sales_id) total_score
FROM sales_rep_avro
GROUP BY sales_person_name;