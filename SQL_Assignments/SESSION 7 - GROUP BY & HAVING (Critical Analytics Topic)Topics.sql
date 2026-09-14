-- SESSION 7 - GROUP BY & HAVING (Critical Analytics Topic)Topics:GROUP BY basicsHAVING vs WHEREAggregation filtersDemo:Total revenue per region ? show only regions with revenue > 1M.
-- Tasks
-- 1.Write an SQL query to display the total number of orders placed by each user in a 'food_orders' table, grouped by user_id.
-- 2.Using a 'transactions' table with columns (transaction_id, user_id, amount, payment_method), write an SQL query to show the total amount spent by each payment_method.
-- 3.Given a 'movies' table with columns (movie_id, genre, box_office_collection), write an SQL query to display each genre and its total box_office_collection, but only show genres where the total collection is above 10 crore.<br><br><em><strong>Hint:</strong> Use GROUP BY and HAVING together to filter the aggregated results.</em>
-- 4.Suppose you have a 'playlist' table with columns (playlist_id, user_id, song_id, duration). Write an SQL query to find users who have created playlists with a combined song duration of more than 2 hours (7200 seconds), showing user_id and total duration.

-- 1.Write an SQL query to display the total number of orders placed by each user in a 'food_orders' table, grouped by user_id.

SELECT 
    COUNT(order_id) AS Total_orders, user_id
FROM
    food_orders
GROUP BY user_id;

-- 2.Using a 'transactions' table with columns (transaction_id, user_id, amount, payment_method), write an SQL query to show the total amount spent by each payment_method.

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(20)
);

INSERT INTO transactions (transaction_id, user_id, amount, payment_method)
VALUES
(1, 101, 450.00, 'UPI'),
(2, 102, 320.00, 'Cash'),
(3, 103, 280.00, 'Card'),
(4, 101, 190.00, 'UPI'),
(5, 104, 350.00, 'Wallet'),
(6, 105, 410.00, 'Cash'),
(7, 102, 520.00, 'Card'),
(8, 103, 260.00, 'UPI'),
(9, 104, 180.00, 'Wallet'),
(10, 105, 295.00, 'Cash');

SELECT 
    SUM(amount) AS total_amount_spent, 
    payment_method
FROM
    transactions
GROUP BY payment_method;

-- 3.Given a 'movies' table with columns (movie_id, genre, box_office_collection), write an SQL query to display each genre and its total box_office_collection, but only show genres where the total collection is above 10 crore.<br><br><em><strong>Hint:</strong> Use GROUP BY and HAVING together to filter the aggregated results.</em>

Alter table movies 
add box_office_collection decimal(10,2);

INSERT INTO movies (movie_id, movie_name, release_year, genre, rating, box_office_collection)
VALUES
(7, 'Drishyam 2', 2022, 'Thriller', 8.2, 9.80),
(8, 'Zindagi Na Milegi Dobara', 2011, 'Drama', 8.2, 4.60),
(9, 'Avengers: Endgame', 2019, 'Action', 8.4, 18.30),
(10, 'Yeh Jawaani Hai Deewani', 2013, 'Romance', 7.9, 3.90);

Update movies SET box_office_collection = 12.50 where movie_id = 1;
UPDATE movies SET box_office_collection = 8.20 WHERE movie_id = 2;
UPDATE movies SET box_office_collection = 6.80 WHERE movie_id = 3;
UPDATE movies SET box_office_collection = 5.10 WHERE movie_id = 4;
UPDATE movies SET box_office_collection = 15.00 WHERE movie_id = 5;
UPDATE movies SET box_office_collection = 7.50 WHERE movie_id = 6;

SELECT 
    genre,
    SUM(box_office_collection) AS total_box_office_collection
FROM
    movies
GROUP BY genre
HAVING SUM(box_office_collection) > 10;

-- 4.Suppose you have a 'playlist' table with columns (playlist_id, user_id, song_id, duration). Write an SQL query to find users who have created playlists with a combined song duration of more than 2 hours (7200 seconds), showing user_id and total duration.

CREATE TABLE playlist (
    playlist_id INT,
    user_id INT,
    song_id INT,
    duration INT
);

INSERT INTO playlist (playlist_id, user_id, song_id, duration)
VALUES
(1, 101, 1001, 1800),
(1, 101, 1002, 2400),
(1, 101, 1003, 3200),
(2, 102, 1004, 1500),
(2, 102, 1005, 2100),
(3, 103, 1006, 3600),
(3, 103, 1007, 4000),
(3, 103, 1008, 900),
(4, 104, 1009, 2500),
(4, 104, 1010, 1800);

SELECT 
    user_id, SUM(duration) AS combined_song_duration
FROM
    playlist
GROUP BY user_id
HAVING SUM(duration) > 7200;

