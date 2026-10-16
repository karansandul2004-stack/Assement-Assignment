-- SESSION 18 - Views Topics: CREATE VIEW Updating views View limitations Good practices for analytics views Demo: Create view for Dashboard reporting (Daily Sales).
-- Tasks
-- 1.Create a SQL view named TopRatedRestaurants that selects the restaurant name, average rating, and total number of reviews from a table of Zomato-style restaurant reviews, showing only restaurants with an average rating above 4.0.
-- 2.Update the TopRatedRestaurants view to also include the city column from the original restaurants table by joining the relevant tables.<br><br><em><strong>Hint:</strong> Use an INNER JOIN to combine data from both tables in your view definition.</em>
-- 3.Try to update the average rating column directly through the TopRatedRestaurants view and observe what error or limitation occurs. Write down the exact error message and explain why this happens based on SQL view limitations.
-- 4.Create a view called DailyOrderSummary that shows, for each date, the total number of food orders and the total revenue from a Swiggy-style orders table. Ensure the view only includes dates from the last 30 days.<br><br><em><strong>Constraint:</strong> Use WHERE and GROUP BY clauses in your view definition.</em>
-- 5.List 3 good practices you should follow when creating SQL views for analytics dashboards, and for each, give a one-line example related to a Flipkart sales reporting scenario.


-- 1.Create a SQL view named TopRatedRestaurants that selects the restaurant name, average rating, and total number of reviews 
-- from a table of Zomato-style restaurant reviews, showing only restaurants with an average rating above 4.0.

CREATE TABLE RestaurantReviews (
    review_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    rating DECIMAL(2,1),
    review_text VARCHAR(255)
);

INSERT INTO RestaurantReviews (review_id, restaurant_name, rating, review_text) VALUES
(1, 'Domino’s', 3.8, 'Good but slow service'),
(2, 'Burger King', 4.2, 'Loved the burgers'),
(3, 'Subway', 4.5, 'Fresh and healthy'),
(4, 'McDonald’s', 3.9, 'Average experience'),
(5, 'Pizza Hut', 4.3, 'Great taste'),
(6, 'KFC', 4.1, 'Crispy chicken'),
(7, 'Cafe Coffee Day', 4.6, 'Excellent coffee'),
(8, 'Starbucks', 4.8, 'Premium vibes');

Create view TopRatedRestaurants As
Select
	restaurant_name,
    avg(rating) as avg_rating,
    Count(review_text) as total_no_reviews
from restaurantreviews
group by restaurant_name
having avg(rating) > 4.0;

select * from TopRatedRestaurants;

-- 2.Update the TopRatedRestaurants view to also include the city column from the original restaurants table by joining the relevant tables.<br><br><em><strong>
-- Hint:</strong> Use an INNER JOIN to combine data from both tables in your view definition.</em>

create or replace view TopRatedRestaurants as
select rr.restaurant_name,
r.city,
avg(rr.rating) as avg_rating,
count(rr.review_text) as total_no_reviews
from restaurantreviews rr
inner join restaurants r
on rr.review_id = r.restaurants_id
group by rr.restaurant_name,
r.city
having avg(rr.rating) > 4.0;

Select * from TopRatedRestaurants;

-- 3.Try to update the average rating column directly through the TopRatedRestaurants view and observe what error or limitation occurs. 
-- Write down the exact error message and explain why this happens based on SQL view limitations.

update TopRatedRestaurants
set avg_rating = 4.9
where restaurant_name = 'Burger King';

-- 0	27	11:44:16	update TopRatedRestaurants
-- set avg_rating = 4.9
-- where restaurant_name = 'Burger King'	Error Code: 1288. The target table TopRatedRestaurants of the UPDATE is not updatable	0.000 sec

-- 4.Create a view called DailyOrderSummary that shows, for each date, the total number of food orders and the total revenue from a Swiggy-style orders table. 
-- Ensure the view only includes dates from the last 30 days.<br><br><em><strong>Constraint:</strong> Use WHERE and GROUP BY clauses in your view definition.</em>

CREATE TABLE Food_Orders1 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(100),
    total_amount DECIMAL(10,2)
);

INSERT INTO Food_Orders1 (order_id, order_date, customer_name, total_amount) VALUES
(1, '2026-09-20', 'Aditi Sharma', 450.00),
(2, '2026-09-20', 'Rohan Mehta', 720.00),
(3, '2026-09-21', 'Sneha Patel', 980.00),
(4, '2026-09-21', 'Karan Joshi', 650.00),
(5, '2026-09-22', 'Priya Desai', 870.00),
(6, '2026-09-22', 'Ankit Verma', 560.00),
(7, '2026-09-23', 'Neha Gupta', 430.00),
(8, '2026-09-23', 'Rahul Singh', 1250.00),
(9, '2026-09-24', 'Divya Nair', 780.00),
(10, '2026-09-24', 'Aman Khan', 920.00);

create view DailyOrderSummary as
select order_date,
count(order_id) as total_food_order,
sum(total_amount) as total_revenue
from food_orders1
where order_date >= curdate() - interval 30 day
group by order_date;

select * from DailyOrderSummary;

-- 5.List 3 good practices you should follow when creating SQL views for analytics dashboards, and for each, 
-- give a one-line example related to a Flipkart sales reporting scenario.

-- 1Practice: Avoid overly complex joins or nested queries in a single view; keep each view focused on one purpose.
-- A view that only tracks daily sales totals
-- CREATE VIEW DailySales AS
-- SELECT order_date, SUM(price) AS total_sales
-- FROM FlipkartOrders
-- GROUP BY order_date;
-- This keeps the view lightweight and easy to query in dashboards.

-- 2Practice: Name views and columns clearly so analysts instantly understand their purpose.
-- A view for category-level revenue
-- CREATE VIEW CategoryRevenue AS
-- SELECT category AS product_category,
--       SUM(price) AS total_revenue
-- FROM FlipkartProducts
-- GROUP BY category;
-- Clear naming avoids confusion when multiple teams use the dashboard.

-- 3Practice: Restrict views to only the data needed for reporting (e.g., recent sales, active products).
-- A view showing only last 90 days of orders
-- CREATE VIEW RecentOrders AS
-- SELECT order_id, order_date, price
-- FROM FlipkartOrders
-- WHERE order_date >= CURDATE() - INTERVAL 90 DAY;
-- This ensures dashboards stay fast and relevant without pulling unnecessary historical data.