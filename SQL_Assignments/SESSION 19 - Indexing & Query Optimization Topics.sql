-- SESSION 19 - Indexing & Query Optimization Topics: Why queries become slow Index types EXPLAIN PLAN Avoiding full table scans Demo: Run slow query ? add index ? measure improvement.
-- Tasks
-- 1.Run a SELECT query on a large 'orders' table (at least 10,000 rows) to find all orders for a specific user_id and measure the query execution time.
-- 2.Create an index on the user_id column of the 'orders' table and re-run the same SELECT query to measure the new execution time.<br><br><em><strong>Hint:</strong> Use CREATE INDEX idx_user_id ON orders(user_id); and compare the times before and after.</em>
-- 3.Use the EXPLAIN PLAN command to analyze how your SELECT query runs before and after adding the index, and write down the key differences you observe in the output.
-- 4.Write a query for a 'products' table that avoids a full table scan by using an index on the 'category' column to fetch all products in a specific category.
-- 5.Suppose your SELECT query on the 'orders' table is still slow even after adding an index. Use EXPLAIN PLAN and research at least one more optimization technique (other than indexing) using an AI tool like ChatGPT or Copilot, and describe how you would apply it.

-- 1.Run a SELECT query on a large 'orders' table (at least 10,000 rows) to find all orders for a specific user_id and measure the query execution time.

CREATE TABLE Orders_2 (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

-- Insert 10,000 rows with random user_ids and amounts
DELIMITER //
CREATE PROCEDURE SeedOrders()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 10000 DO
    INSERT INTO Orders_2 (order_id, user_id, order_date, total_amount)
    VALUES (i, FLOOR(1 + (RAND() * 1000)), 
            DATE_ADD('2026-01-01', INTERVAL FLOOR(RAND()*300) DAY),
            ROUND(RAND()*5000,2));
    SET i = i + 1;
  END WHILE;
END //
DELIMITER ;

CALL SeedOrders();

Select * from orders_2 
where user_id = 123;

SET profiling = 1;

SELECT *
FROM Orders_2
WHERE user_id = 123;

SHOW PROFILES;

-- 2.Create an index on the user_id column of the 'orders' table and re-run the same SELECT query to measure the new execution time.<br><br><em><strong>
-- Hint:</strong> Use CREATE INDEX idx_user_id ON orders(user_id); and compare the times before and after.</em>

create index idx_user_id 
on orders_2(user_id); 

set profiling = 1;

SELECT *
FROM Orders_2
WHERE user_id = 123;

show profiles;

-- 3.Use the EXPLAIN PLAN command to analyze how your SELECT query runs before and after adding the index, and write down the key differences you observe in the output.

EXPLAIN SELECT *
FROM Orders_2
WHERE user_id = 123;

EXPLAIN SELECT *
FROM Orders_2
WHERE user_id = 123;

-- Before index: Full table scan (ALL), slow, scans all rows.
-- After index: Index lookup (ref), fast, scans only relevant rows.
-- Performance impact: Execution time drops dramatically, especially as table size grows beyond 10,000 rows.

-- 4.Write a query for a 'products' table that avoids a full table scan by using an index on the 'category' column to fetch all products in a specific category.

set profiling = 1;

select * from products;

show profiles;

explain select * from products;

create index idx_category
on products(category);

set profiling = 1;

select * from products
where category like 'Electronics';

show profiles;

explain select * from products;
SHOW COLUMNS FROM Products LIKE 'category';

SELECT * 
FROM Products FORCE INDEX (idx_category)
WHERE category = 'Electronics';

ANALYZE TABLE Products;

EXPLAIN SELECT * FROM Products WHERE category = 'Electronics';

-- 5.Suppose your SELECT query on the 'orders' table is still slow even after adding an index. 
-- Use EXPLAIN PLAN and research at least one more optimization technique (other than indexing) using an AI tool like ChatGPT or Copilot, and 
-- describe how you would apply it.

EXPLAIN SELECT *
FROM Orders_2
WHERE user_id = 123;

CREATE INDEX idx_user_orders 
ON Orders_2(user_id, order_date, total_amount);

SELECT order_date, total_amount
FROM Orders_2
WHERE user_id = 123;

