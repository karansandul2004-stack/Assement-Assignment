-- SESSION 15 - Date FunctionsTopics:DATE, YEAR(), MONTH(), DAY(), NOW()DATE_ADD, DATE_SUBDATEDIFFDemo:Calculate customer churn age (days since last visit).
-- Tasks
-- 1.Write an SQL query using the NOW() function to display the current date and time as 'CurrentDateTime' in your result set.
-- 2.Suppose you have a table called Orders with a column order_date (DATE type). Write a query to display each order's order_date, the year, month, and day as separate columns using YEAR(), MONTH(), and DAY().
-- 3.Imagine you are building a feature like Zomato's order delivery estimate. Given a table Deliveries with a column delivery_date, write a query to show delivery_date and a new column expected_pickup_date which is 2 days before delivery_date using DATE_SUB().
-- 4.You have a table called Subscriptions with columns user_id, start_date, and end_date. Write a query to display user_id, start_date, end_date, and the total number of days of each subscription using DATEDIFF().<br><br><em><strong>Hint:</strong> Use DATEDIFF(end_date, start_date) to get the duration.</em>
-- 5.Create an SQL query for a table named AppLogins (columns: user_id, last_login_date) to find all users who haven't logged in for more than 30 days from today. Use NOW() and DATEDIFF() in your query.<br><br><em><strong>Constraint:</strong> Only select user_id and last_login_date for users who meet the criteria.</em>

-- 1.Write an SQL query using the NOW() function to display the current date and time as 'CurrentDateTime' in your result set.

Select now() as CurrentDateTime;

-- 2.Suppose you have a table called Orders with a column order_date (DATE type). 
-- Write a query to display each order's order_date, the year, month, and day as separate columns using YEAR(), MONTH(), and DAY().

Select order_date, 
Year(order_date) as order_year,
month(order_date) as order_month,
day(order_date) as order_day
from orders_1;

-- 3.Imagine you are building a feature like Zomato's order delivery estimate. Given a table Deliveries with a column delivery_date, 
-- write a query to show delivery_date and a new column expected_pickup_date which is 2 days before delivery_date using DATE_SUB().

create table Deliveries (
delivery_id int primary key,
delivery_date date
);

INSERT INTO Deliveries (delivery_id, delivery_date) VALUES
(1, '2023-10-10'),
(2, '2023-10-15'),
(3, '2023-10-20'),
(4, '2023-11-01'),
(5, '2023-11-05');

Select 
delivery_date,
date_sub(delivery_date, interval 2 day) as expected_pickup_date
from deliveries;

-- 4.You have a table called Subscriptions with columns user_id, start_date, and end_date. 
-- Write a query to display user_id, start_date, end_date, and the total number of days of each subscription using DATEDIFF().<br><br><em><strong>
-- Hint:</strong> Use DATEDIFF(end_date, start_date) to get the duration.</em>

CREATE TABLE Subscriptions (
    user_id INT PRIMARY KEY,
    start_date DATE,
    end_date DATE
);

INSERT INTO Subscriptions (user_id, start_date, end_date) VALUES
(101, '2023-01-01', '2023-03-01'),
(102, '2023-02-15', '2023-04-10'),
(103, '2023-05-01', '2023-05-20'),
(104, '2023-06-10', '2023-07-25'),
(105, '2023-08-01', '2023-09-15');

Select user_id,
start_date,
end_date,
datediff(end_date, start_date) as total_days
from subscriptions;

-- 5.Create an SQL query for a table named AppLogins (columns: user_id, last_login_date) to find all users who haven't logged in for more than 30 days from today. 
-- Use NOW() and DATEDIFF() in your query.<br><br><em><strong>Constraint:</strong> Only select user_id and last_login_date for users who meet the criteria.</em>

CREATE TABLE AppLogins (
    user_id INT PRIMARY KEY,
    last_login_date DATE
);

INSERT INTO AppLogins (user_id, last_login_date) VALUES
(101, '2023-09-01'),
(102, '2023-10-01'),
(103, '2023-08-20'),
(104, '2023-09-10'),
(105, '2023-07-25');

select user_id,
last_login_date
from Applogins
where datediff(now(),last_login_date) > 30;

select user_id,
last_login_date,
datediff(now(),last_login_date) 
from Applogins;