-- SESSION 13 - Window Functions (Part 1: OVER, PARTITION BY)Topics:OVER()PARTITION BYRow-level calculationsDemo:Find each employee’s salary vs department average.
-- Tasks
-- 1.Create a table called Orders with columns: order_id, user_id, order_amount, and app_name (e.g., 'Zomato', 'Swiggy', 'Flipkart'). Insert at least 10 sample records with different users and apps. Write an SQL query using the OVER() function to display each order's amount along with the total order amount for all orders.
-- 2.Using the Orders table, write an SQL query to show each user's order_id, order_amount, and the average order_amount for that user using the OVER(PARTITION BY user_id) clause.<br><br><em><strong>Hint:</strong> Use AVG(order_amount) OVER(PARTITION BY user_id) to get the per-user average.</em>
-- 3.Suppose you have a table called Playlist with columns: song_id, user_id, and duration_sec. Write an SQL query to display each song's duration, and the total duration of songs added by each user using SUM(duration_sec) OVER(PARTITION BY user_id).
-- 4.Given a table named MovieRatings with columns: rating_id, user_id, movie_name, and rating (1-5), write an SQL query to show each rating, the average rating per movie, and the difference between the user's rating and the movie's average rating using window functions.<br><br><em><strong>Hint:</strong> Use AVG(rating) OVER(PARTITION BY movie_name) and subtract it from the user's rating.</em>


-- 1.Create a table called Orders with columns: order_id, user_id, order_amount, and app_name (e.g., 'Zomato', 'Swiggy', 'Flipkart'). 
-- Insert at least 10 sample records with different users and apps. Write an SQL query using the OVER() function to display each order's amount along with 
-- the total order amount for all orders.

CREATE TABLE app_Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_amount DECIMAL(10,2),
    app_name VARCHAR(50)
);

INSERT INTO app_Orders (order_id, user_id, order_amount, app_name) VALUES
(1, 101, 450.00, 'Zomato'),
(2, 102, 720.00, 'Swiggy'),
(3, 103, 980.00, 'Flipkart'),
(4, 104, 650.00, 'Zomato'),
(5, 105, 870.00, 'Swiggy'),
(6, 106, 560.00, 'Flipkart'),
(7, 107, 1200.00, 'Zomato'),
(8, 108, 300.00, 'Swiggy'),
(9, 109, 1500.00, 'Flipkart'),
(10, 110, 700.00, 'Zomato');

select order_id, 
user_id, 
order_amount, 
app_name,
sum(order_amount) over() as total_order_amount from app_orders;

-- 2.Using the Orders table, write an SQL query to show each user's order_id, order_amount, and the average order_amount for that user using 
-- the OVER(PARTITION BY user_id) clause.<br><br><em><strong>Hint:</strong> Use AVG(order_amount) OVER(PARTITION BY user_id) to get the per-user average.</em>

Select order_id, 
order_amount, 
AVG(order_amount) OVER(PARTITION BY user_id) as avg_order_amount
from app_orders;

-- 3.Suppose you have a table called Playlist with columns: song_id, user_id, and duration_sec. 
-- Write an SQL query to display each song's duration, and the total duration of songs added by each user using SUM(duration_sec) OVER(PARTITION BY user_id).

select song_id, 
user_id,
duration,
Sum(duration) over(partition by user_id) total_duration
from playlist;

-- 4.Given a table named MovieRatings with columns: rating_id, user_id, movie_name, and rating (1-5), 
-- write an SQL query to show each rating, the average rating per movie, and the difference between the user's 
-- rating and the movie's average rating using window functions.<br><br><em><strong>Hint:</strong> 
-- Use AVG(rating) OVER(PARTITION BY movie_name) and subtract it from the user's rating.</em>

CREATE TABLE MovieRatings (
    rating_id INT PRIMARY KEY,
    user_id INT,
    movie_name VARCHAR(100),
    rating INT CHECK (rating BETWEEN 1 AND 5)
);

INSERT INTO MovieRatings (rating_id, user_id, movie_name, rating) VALUES
(1, 101, 'Inception', 5),
(2, 102, 'Inception', 4),
(3, 103, 'Inception', 3),
(4, 104, 'Interstellar', 5),
(5, 105, 'Interstellar', 4),
(6, 106, 'Interstellar', 5),
(7, 107, 'The Dark Knight', 5),
(8, 108, 'The Dark Knight', 4),
(9, 109, 'The Dark Knight', 5),
(10, 110, 'The Dark Knight', 3);

Select rating_id,
user_id,
movie_name,
rating, 
avg(rating) over (partition by movie_name) as avg_movie_rating,
rating - avg(rating) over (partition by movie_name) as Difference_user_movie
from movieratings;