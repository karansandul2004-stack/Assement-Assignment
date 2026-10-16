-- SESSION 17 - CASE WHEN (Conditional Logic) Topics: CASE WHEN ELSE END Categorizing data on the fly Binning values Demo: Classify customers into High/Medium/Low value.
-- Tasks
-- 1.Write an SQL query using CASE WHEN to classify orders in a 'FoodOrders' table as 'Small', 'Medium', or 'Large' based on the total_amount: 'Small' for less than 300, 'Medium' for 300 to 999, and 'Large' for 1000 and above.
-- 2.Given a 'Movies' table with a 'rating' column (out of 10), write an SQL query that adds a new column 'popularity' which shows 'Blockbuster' for ratings 8 and above, 'Hit' for 5 to 7.9, and 'Average' for below 5 using CASE WHEN ELSE END.
-- 3.For a 'FlipkartProducts' table with a 'price' column, write an SQL query to create a 'price_category' column that bins prices as 'Budget' (below 500), 'Standard' (500 to 2000), and 'Premium' (above 2000) using CASE WHEN.
-- 4.Write an SQL query for a 'SpotifyTracks' table that uses CASE WHEN to assign a 'duration_label' column: 'Short' for tracks under 180 seconds, 'Medium' for 180-300 seconds, and 'Long' for over 300 seconds.<br><br><em><strong>Hint:</strong> Use multiple WHEN conditions to cover all possible durations.</em>


-- 1.Write an SQL query using CASE WHEN to classify orders in a 'FoodOrders' table as 'Small', 'Medium', or 'Large' based on the total_amount: 
-- 'Small' for less than 300, 'Medium' for 300 to 999, and 'Large' for 1000 and above.

Select *,
(Case
	When amount < 300 Then 'Small'
    When amount between 300 and 400 Then 'Medium'
    Else 'Large' End) as amount_level
from food_orders;

-- 2.Given a 'Movies' table with a 'rating' column (out of 10), write an SQL query that adds a new column 'popularity' which shows 'Blockbuster' 
-- for ratings 8 and above, 'Hit' for 5 to 7.9, and 'Average' for below 5 using CASE WHEN ELSE END.

Select * from movies;

INSERT INTO Movies (movie_id, movie_name, release_year, genre, rating, box_office_collection) VALUES
(11, 'Epic Fail', 2020, 'Comedy', 4.2, 15000000.00),   -- Average
(12, 'Hidden Gem', 2019, 'Drama', 5.8, 25000000.00),   -- Hit
(13, 'Mega Hit', 2021, 'Action', 8.5, 12000000.00),   -- Blockbuster
(14, 'Cult Classic', 2018, 'Thriller', 7.2, 45000000.00), -- Hit
(15, 'Box Office Smash', 2022, 'Adventure', 9.1, 20000000.00); -- Blockbuster


select *, 
(Case
	When rating >= 8 Then 'Blockbusster'
    when rating between 5 and 7.9 then 'Hit'
    else 'Average'
    end) as popularity
from movies;

-- 3.For a 'FlipkartProducts' table with a 'price' column, write an SQL query to create a 'price_category' column that bins prices as 'Budget' (below 500), 
-- 'Standard' (500 to 2000), and 'Premium' (above 2000) using CASE WHEN.

CREATE TABLE FlipkartProducts (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO FlipkartProducts (product_id, product_name, price) VALUES
(1, 'USB Cable', 150.00),       -- Budget
(2, 'Wireless Mouse', 750.00),  -- Standard
(3, 'Bluetooth Speaker', 1800.00), -- Standard
(4, 'Smartphone', 25000.00),    -- Premium
(5, 'Notebook', 80.00),         -- Budget
(6, 'Headphones', 1200.00),     -- Standard
(7, 'Gaming Laptop', 55000.00); -- Premium

Select *,
(Case 
	when price < 500 then 'Budget'
    when price between 500 and 20000 then 'Standard'
    else 'Premium' end) as price_category
from flipkartproducts;

-- 4.Write an SQL query for a 'SpotifyTracks' table that uses CASE WHEN to assign a 'duration_label' column: 'Short' for tracks under 180 seconds, 
-- 'Medium' for 180-300 seconds, and 'Long' for over 300 seconds.<br><br><em><strong>Hint:</strong> Use multiple WHEN conditions to cover all possible durations.</em>

CREATE TABLE SpotifyTracks (
    track_id INT PRIMARY KEY,
    track_name VARCHAR(100),
    duration_seconds INT
);

INSERT INTO SpotifyTracks (track_id, track_name, duration_seconds) VALUES
(1, 'Pop Hit', 150),     -- Short
(2, 'Indie Tune', 240),  -- Medium
(3, 'Epic Ballad', 320), -- Long
(4, 'Quick Intro', 90),  -- Short
(5, 'Classic Rock', 300),-- Medium (edge case)
(6, 'Live Jam', 480);    -- Long

Select *,
(Case
	When duration_seconds < 180 Then 'Short'
    When duration_seconds between 180 and 300 Then 'Medium'
    else 'Long' End) as duration_label
from spotifytracks;