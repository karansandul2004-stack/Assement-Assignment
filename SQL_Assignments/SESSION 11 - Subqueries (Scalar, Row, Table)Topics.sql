-- SESSION 11 - Subqueries (Scalar, Row, Table)Topics:Subquery in SELECTSubquery in WHERESubquery in FROM (derived tables)Demo:Find employees earning above company average salary.
-- Tasks
-- 1.Write a SQL query to display the names and ratings of restaurants (from a table named Restaurants) where the rating is higher than the average rating of all restaurants in the table.<br><br><em><strong>Hint:</strong> Use a subquery in the WHERE clause to calculate the average rating.</em>
-- 2.In a Flipkart-style Products table (columns: product_id, name, price, category), write a SQL query to list each product name along with the average price of its category as an additional column using a scalar subquery in the SELECT statement.
-- 3.Given a Playlists table (playlist_id, user_id, playlist_name) and a Users table (user_id, username), write a SQL query using a subquery in the FROM clause to show each username and the number of playlists they have created, displaying only users who have created more playlists than the average number of playlists per user.<br><br><em><strong>Hint:</strong> Use a derived table (subquery in FROM) to count playlists per user, then filter with a subquery in WHERE.</em>
-- 4.Suppose you have an Orders table (order_id, user_id, total_amount) for a food delivery app. Write a query to find all user_ids who have placed at least one order with a total_amount greater than the average order amount, using a subquery in the WHERE clause.

-- 1.Write a SQL query to display the names and ratings of restaurants (from a table named Restaurants) where the rating is higher than the 
-- average rating of all restaurants in the table.<br><br><em><strong>Hint:</strong> Use a subquery in the WHERE clause to calculate the average rating.</em>

select restaurant_name, rating
from restaurants 
where rating > (
select avg(rating) as avg_rating
from restaurants
);


-- 2.In a Flipkart-style Products table (columns: product_id, name, price, category), write a SQL query to list 
-- each product name along with the average price of its category as an additional column using a scalar subquery in the SELECT statement.

select p.product_id, p.product_name, p.price, p.category,
(
select avg(price)
from products
where category = p.category
) as avg_products_price
from products p;

-- 3.Given a Playlists table (playlist_id, user_id, playlist_name) and a Users table (user_id, username), write a SQL query using a subquery in the 
-- FROM clause to show each username and the number of playlists they have created, displaying only users who have created more playlists than the average number 
-- of playlists per user.<br><br><em><strong>Hint:</strong> Use a derived table (subquery in FROM) to count playlists per user, then filter with a subquery in WHERE.</em>

-- SELECT u.username, playlist_counts.num_playlists
-- FROM (
--    SELECT user_id, COUNT(*) AS num_playlists
--    FROM Playlist
--    GROUP BY user_id
-- ) AS playlist_counts
-- JOIN Users u
--    ON u.user_id = playlist_counts.user_id
-- WHERE playlist_counts.num_playlists > (
--    SELECT AVG(num_playlists)
--    FROM (
--        SELECT user_id, COUNT(*) AS num_playlists
--        FROM Playlist
--        GROUP BY user_id
--    ) AS avg_counts
-- );
-- use it when table are present as per the question

-- 4.Suppose you have an Orders table (order_id, user_id, total_amount) for a food delivery app. 
-- Write a query to find all user_ids who have placed at least one order with a total_amount greater than the average order amount, using a subquery in the WHERE clause.

select distinct customer_name, total_amount
from orders
where total_amount > (
Select avg(total_amount) as avg_amount
from orders);

