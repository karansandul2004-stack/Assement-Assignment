-- SESSION 8 - JOINS: INNER, LEFT, RIGHT (Foundation Session)Topics:Relationship between tablesPrimary / Foreign KeysINNER JOINLEFT JOINRIGHT JOINDemo:Join Orders + Customers ? Customer Segment ? Revenue.
-- Tasks
-- 1.Create two tables in your SQL database: Users (user_id, username, city) and Orders (order_id, user_id, product, amount). Insert at least 3 users and 5 orders, making sure some users have no orders.
-- 2.Write an SQL query using INNER JOIN to list all usernames and their ordered products, showing only users who have placed at least one order.
-- 3.Write an SQL query using LEFT JOIN to display all usernames along with their ordered products. For users who haven't placed any orders, show NULL for the product.
-- 4.Write an SQL query using RIGHT JOIN to show all orders and the corresponding username for each order. If an order has a user_id that doesn't exist in the Users table, display NULL for the username.<br><br><em><strong>Hint:</strong> Try deleting one user and keeping their order to test this case.</em>
-- 5.Suppose you want to analyze food delivery data like Zomato. Create a CustomerSegments table (segment_id, segment_name), and link it to Users with a foreign key. Write an SQL query to show each username, their segment name, and total order amount (use JOINs as needed).

-- 1.Create two tables in your SQL database: Users (user_id, username, city) and Orders (order_id, user_id, product, amount). Insert at least 3 users and 5 orders, making sure some users have no orders.

CREATE TABLE users_orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product VARCHAR(50),
    amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users_orders (order_id, user_id, product, amount)
VALUES
(1, 1, 'Laptop', 75000.00),
(2, 2, 'Headphones', 2500.00),
(3, 1, 'Mouse', 800.00),
(4, 3, 'Keyboard', 1500.00),
(5, 2, 'Monitor', 12000.00);

SELECT 
    u.user_id, u.username, ud.order_id, ud.product
FROM
    users u
        JOIN
    users_orders ud ON u.user_id = ud.user_id;
    
-- 2.Write an SQL query using INNER JOIN to list all usernames and their ordered products, showing only users who have placed at least one order.

SELECT 
    u.username, ud.product
FROM
    users u
        INNER JOIN
    users_orders ud ON u.user_id = ud.user_id;
    
-- 3.Write an SQL query using LEFT JOIN to display all usernames along with their ordered products. For users who haven't placed any orders, show NULL for the product.

SELECT 
    u.username, ud.product
FROM
    users u
        LEFT JOIN
    users_orders ud ON u.user_id = ud.user_id;
    
-- 4.Write an SQL query using RIGHT JOIN to show all orders and the corresponding username for each order. If an order has a user_id that doesn't exist in the Users table, display NULL for the username.<br><br><em><strong>Hint:</strong> Try deleting one user and keeping their order to test this case.</em>
Show create table users_orders;

DELETE FROM users
WHERE user_id = 3;

SELECT
    ud.order_id,
    ud.product,
    ud.amount,
    u.username
FROM users u
RIGHT JOIN users_orders ud
ON u.user_id = ud.user_id;

-- 5.Suppose you want to analyze food delivery data like Zomato. Create a CustomerSegments table (segment_id, segment_name), and link it to Users with a foreign key. Write an SQL query to show each username, their segment name, and total order amount (use JOINs as needed).

CREATE TABLE CustomerSegments (
    segment_id INT PRIMARY KEY,
    segment_name VARCHAR(30)
);

INSERT INTO CustomerSegments (segment_id, segment_name)
VALUES
(1, 'Silver'),
(2, 'Gold'),
(3, 'Platinum');

alter table users
add column segment_id int;

update users set segment_id = 1 where user_id = 1;
update users set segment_id = 2 where user_id = 2;
update users set segment_id = 1 where user_id = 4;
update users set segment_id = 2 where user_id = 5;
update users set segment_id = 3 where user_id = 6;
update users set segment_id = 1 where user_id = 7;
update users set segment_id = 2 where user_id = 8;

Alter table users
add constraint fk_users_segment
foreign key (segment_id) 
references customersegments(segment_id);

select * from users;

select u.user_id ,u.username, sum(ud.amount) as total_amount, c.segment_name from users u
join users_orders ud
on u.user_id = ud.user_id
join customersegments c
on u.segment_id = c.segment_id
group by u.user_id, u.username ,c.segment_name;