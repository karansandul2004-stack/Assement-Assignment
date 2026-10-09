-- SESSION 10 - UNION & UNION ALLTopics:Combine multiple tablesDifference between UNION vs UNION ALLCompatible column structuresDemo:Combine online + offline sales tables.
-- Tasks
-- 1.Create two tables: AppOrders (for orders placed via a food delivery app like Zomato) and InStoreOrders (for direct restaurant orders), each with columns: order_id, customer_name, amount, and order_date. Insert at least 3 sample records into each table.
-- 2.Write a SQL query using UNION to combine all unique customer names from both AppOrders and InStoreOrders tables into a single list.
-- 3.Write a SQL query using UNION ALL to display every order (including duplicates if any) from both AppOrders and InStoreOrders, showing order_id, customer_name, amount, and order_date.
-- 4.Demonstrate the difference between UNION and UNION ALL by adding a duplicate customer_name in both tables, then running both queries and noting the difference in the result count.<br><br><em><strong>Hint:</strong> UNION removes duplicates, UNION ALL does not.</em>

-- 1.Create two tables: AppOrders (for orders placed via a food delivery app like Zomato) and InStoreOrders (for direct restaurant orders), each with columns: order_id, customer_name, amount, and order_date. Insert at least 3 sample records into each table.

CREATE TABLE AppOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    amount DECIMAL(10,2),
    order_date DATE
);

CREATE TABLE InStoreOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    amount DECIMAL(10,2),
    order_date DATE
);

-- App orders (Zomato-style)
INSERT INTO AppOrders VALUES
(1, 'Aditi Sharma', 450.00, '2026-10-01'),
(2, 'Rohan Mehta', 720.00, '2026-10-02'),
(3, 'Sneha Patel', 980.00, '2026-10-03');

-- In-store restaurant orders
INSERT INTO InStoreOrders VALUES
(101, 'Mehul Desai', 650.00, '2026-10-01'),
(102, 'Kavya Iyer', 870.00, '2026-10-02'),
(103, 'Arjun Singh', 560.00, '2026-10-03');

select order_id, customer_name, amount, order_date
from apporders
union
select order_id, customer_name, amount, order_date
from instoreorders;

select order_id, customer_name, amount, order_date
from apporders
union all
select order_id, customer_name, amount, order_date
from instoreorders;

-- 2.Write a SQL query using UNION to combine all unique customer names from both AppOrders and InStoreOrders tables into a single list.

select customer_name from apporders
union
select customer_name from instoreorders;

-- 3.Write a SQL query using UNION ALL to display every order (including duplicates if any) from both AppOrders and InStoreOrders, showing order_id, customer_name, amount, and order_date.

select order_id, customer_name, amount, order_date
from apporders
union all
select order_id, customer_name, amount, order_date
from instoreorders;

-- 4.Demonstrate the difference between UNION and UNION ALL by adding a duplicate customer_name in both tables, then running both queries and noting the difference in the result count.<br><br><em><strong>Hint:</strong> UNION removes duplicates, UNION ALL does not.</em>

-- Add duplicate customer in AppOrders
INSERT INTO AppOrders VALUES
(4, 'Aditi Sharma', 500.00, '2026-10-04');

-- Add duplicate customer in InStoreOrders
INSERT INTO InStoreOrders VALUES
(104, 'Aditi Sharma', 600.00, '2026-10-04');

select customer_name
from apporders
union
select customer_name
from instoreorders;

select customer_name
from apporders
union all
select customer_name
from instoreorders;

