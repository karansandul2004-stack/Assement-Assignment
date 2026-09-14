-- SESSION 6 - Aggregate FunctionsTopics:SUM(), COUNT(), AVG(), MIN(), MAX()Rounding numbers (ROUND)Demo:Total revenue, average salary, highest order value.
-- Tasks
-- 1.Write an SQL query using the SUM() function to calculate the total amount spent by users on food orders in a table food_orders (columns: order_id, user_id, amount) — imagine it's like Zomato's order history.
-- 2.Using the COUNT() function, find out how many songs a user has added to their playlist in a table spotify_playlists (columns: playlist_id, user_id, song_id).
-- 3.Write an SQL query to get the average rating given to a movie in a table bookmyshow_reviews (columns: review_id, movie_id, rating), and round the result to 1 decimal place using the ROUND() function.<br><br><em><strong>Hint:</strong> Use AVG() with ROUND() to format the output.</em>
-- 4.Find the minimum and maximum transaction values for a user from a table paytm_transactions (columns: txn_id, user_id, amount) — show both the smallest and largest transaction amounts.
-- 5.Given a table myntra_orders (columns: order_id, user_id, total_price), write an SQL query to display the total number of orders, the average order value (rounded to 2 decimals), and the highest order value for each user_id.<br><br><em><strong>Constraint:</strong> Use GROUP BY to get results per user.</em>

-- 1.Write an SQL query using the SUM() function to calculate the total amount spent by users on food orders in a table food_orders (columns: order_id, user_id, amount) — imagine it's like Zomato's order history.

create table food_orders(
order_id int primary key,
user_id int,
amount decimal(10,2)
);

insert into food_orders (order_id, user_id, amount)
values
(1, 101, 450.00),
(2, 102, 320.00),
(3, 103, 280.00),
(4, 101, 190.00),
(5, 104, 350.00),
(6, 105, 410.00),
(7, 102, 520.00),
(8, 103, 260.00),
(9, 104, 180.00),
(10, 105, 295.00);

SELECT 
    user_id, SUM(amount) as total_amount
FROM
    food_orders
GROUP BY user_id;

-- 2.Using the COUNT() function, find out how many songs a user has added to their playlist in a table spotify_playlists (columns: playlist_id, user_id, song_id).

CREATE TABLE spotify_playlists (
    playlist_id INT,
    user_id INT,
    song_id INT
);

INSERT INTO spotify_playlists (playlist_id, user_id, song_id)
VALUES
(1, 101, 1001),
(1, 101, 1002),
(1, 101, 1003),
(2, 102, 1004),
(2, 102, 1005),
(3, 103, 1006),
(3, 103, 1007),
(3, 103, 1008),
(3, 103, 1009),
(4, 104, 1010);

SELECT 
    user_id, COUNT(song_id) songs
FROM
    spotify_playlists
GROUP BY user_id;

-- 3.Write an SQL query to get the average rating given to a movie in a table bookmyshow_reviews (columns: review_id, movie_id, rating), and round the result to 1 decimal place using the ROUND() function.<br><br><em><strong>Hint:</strong> Use AVG() with ROUND() to format the output.</em>

CREATE TABLE bookmyshow_reviews (
    review_id INT PRIMARY KEY,
    movie_id INT,
    rating DECIMAL(2,1)
);

INSERT INTO bookmyshow_reviews (review_id, movie_id, rating)
VALUES
(1, 101, 4.5),
(2, 101, 4.0),
(3, 101, 5.0),
(4, 102, 3.5),
(5, 102, 4.0),
(6, 103, 4.8),
(7, 103, 4.2),
(8, 104, 3.9),
(9, 104, 4.1),
(10, 105, 5.0);

SELECT 
    movie_id, ROUND(AVG(rating), 1) as average_rating
FROM
    bookmyshow_reviews
GROUP BY movie_id;

-- 4.Find the minimum and maximum transaction values for a user from a table paytm_transactions (columns: txn_id, user_id, amount) — show both the smallest and largest transaction amounts.

CREATE TABLE paytm_transactions (
    txn_id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2)
);

INSERT INTO paytm_transactions (txn_id, user_id, amount)
VALUES
(1, 101, 250.00),
(2, 101, 1200.00),
(3, 101, 499.00),
(4, 102, 150.00),
(5, 102, 950.00),
(6, 103, 75.00),
(7, 103, 2000.00),
(8, 104, 350.00),
(9, 104, 1800.00),
(10, 105, 625.00);

SELECT 
    user_id,
    MIN(amount) minimum_amount,
    MAX(amount) maximum_amount
FROM
    paytm_transactions
group by user_id;

-- 5.Given a table myntra_orders (columns: order_id, user_id, total_price), write an SQL query to display the total number of orders, the average order value (rounded to 2 decimals), and the highest order value for each user_id.<br><br><em><strong>Constraint:</strong> Use GROUP BY to get results per user.</em>

CREATE TABLE myntra_orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    total_price DECIMAL(10,2)
);

INSERT INTO myntra_orders (order_id, user_id, total_price)
VALUES
(1, 101, 1299.00),
(2, 101, 2499.50),
(3, 102, 899.00),
(4, 102, 1599.00),
(5, 102, 3499.00),
(6, 103, 799.00),
(7, 103, 1999.00),
(8, 104, 4599.00),
(9, 104, 2999.00),
(10, 105, 999.00);

SELECT 
    user_id,
    COUNT(order_id) total_orders,
    ROUND(AVG(total_price), 2) average_order,
    MAX(total_price) highest_order_value
FROM
    myntra_orders
GROUP BY user_id;