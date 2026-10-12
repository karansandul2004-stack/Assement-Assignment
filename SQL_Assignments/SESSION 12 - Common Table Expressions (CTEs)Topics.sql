-- SESSION 12 - Common Table Expressions (CTEs)Topics:WITH clauseTemporary result setsRecursive CTE introDemo:WITH SalesCTE AS (…) ? Calculate YoY growth.
-- Tasks
-- 1.Write an SQL query using the WITH clause to create a temporary result set called TopArtists that selects the top 3 most-followed artists from a table SpotifyArtists (columns: artist_id, name, followers), then select all rows from TopArtists.
-- 2.Using a table named FlipkartOrders (columns: order_id, user_id, order_date, total_amount), write a query with a CTE called MonthlyTotals that calculates the total sales amount for each month in 2023, then select the month with the highest total sales from MonthlyTotals.<br><br><em><strong>Hint:</strong> Use EXTRACT(MONTH FROM order_date) or DATE_FORMAT(order_date, '%m') depending on your SQL dialect.</em>
-- 3.Create a recursive CTE to generate a list of dates for the next 7 days starting from today in a table called CalendarDays (columns: day_date).<br><br><em><strong>Hint:</strong> Use UNION ALL inside your CTE and limit recursion to 7 levels.</em>
-- 4.Given a table called ZomatoRestaurants (columns: id, name, city, rating), use a CTE to find the average rating for each city, then select all restaurants in cities where the average rating is above 4.0.
-- 5.Use ChatGPT or Copilot to help you write an SQL query with a CTE that, given a table IPLMatches (columns: match_id, team, runs, match_year), calculates the total runs scored by each team in 2023 and lists only teams with more than 2000 runs.

-- 1.Write an SQL query using the WITH clause to create a temporary result set called TopArtists that selects the top 3 most-followed artists from a 
-- table SpotifyArtists (columns: artist_id, name, followers), then select all rows from TopArtists.

CREATE TABLE SpotifyArtists (
    artist_id INT PRIMARY KEY,
    name VARCHAR(100),
    followers INT
);

INSERT INTO SpotifyArtists (artist_id, name, followers) VALUES
(1, 'Arijit Singh', 5000000),
(2, 'Shreya Ghoshal', 4200000),
(3, 'Badshah', 3800000),
(4, 'Neha Kakkar', 3500000),
(5, 'Jubin Nautiyal', 2900000),
(6, 'Atif Aslam', 3100000);

WITH TopArtists AS (
    SELECT artist_id, name, followers
    FROM spotifyartists
    ORDER BY followers DESC
    LIMIT 3
)
SELECT *
FROM TopArtists;

-- 2.Using a table named FlipkartOrders (columns: order_id, user_id, order_date, total_amount), write a query with a CTE called MonthlyTotals 
-- that calculates the total sales amount for each month in 2023, then select the month with the highest total sales from MonthlyTotals.<br><br><em><strong>Hint:</strong> 
-- Use EXTRACT(MONTH FROM order_date) or DATE_FORMAT(order_date, '%m') depending on your SQL dialect.</em>

CREATE TABLE FlipkartOrders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO FlipkartOrders (order_id, user_id, order_date, total_amount) VALUES
(1, 101, '2023-01-15', 2500.00),
(2, 102, '2023-01-20', 1800.00),
(3, 103, '2023-02-05', 3200.00),
(4, 104, '2023-02-18', 1500.00),
(5, 105, '2023-03-10', 4200.00),
(6, 106, '2023-03-22', 2800.00),
(7, 107, '2023-07-01', 5000.00),
(8, 108, '2023-07-15', 4700.00),
(9, 109, '2023-07-25', 3900.00),
(10, 110, '2023-11-11', 6000.00),
(11, 111, '2023-11-20', 5500.00),
(12, 112, '2023-12-05', 7000.00);

WITH MonthlyTotals AS (
    SELECT 
        EXTRACT(MONTH FROM order_date) AS month,
        SUM(total_amount) AS total_sales
    FROMZ FlipkartOrders
    WHERE EXTRACT(YEAR FROM order_date) = 2023
    GROUP BY EXTRACT(MONTH FROM order_date)
)
SELECT month, total_sales
FROM MonthlyTotals
ORDER BY total_sales DESC
LIMIT 1;

-- 3.Create a recursive CTE to generate a list of dates for the next 7 days starting from today in a table called CalendarDays (columns: day_date).
-- <br><br><em><strong>Hint:</strong> Use UNION ALL inside your CTE and limit recursion to 7 levels.</em>

create table CalenderDays(
day_date date primary key
);

with recursive Next7days as (

select current_date() as day_date,
1 as level
union all 
select day_date + interval 1 day,
level + 1
from Next7days
where level < 7
)
select day_date from Next7days;

-- 4.Given a table called ZomatoRestaurants (columns: id, name, city, rating), use a CTE to find the average rating for each city, 
-- then select all restaurants in cities where the average rating is above 4.0.

With CityAverges as (
select city ,avg(rating) as avg_rating
from zomato_reviews
group by city
)
select z.review_id, z.name, z.rating ,z.city 
from zomato_reviews z
join CityAverges c 
on z.city = c.city
where c.avg_rating > 4.0;

-- 5.Use ChatGPT or Copilot to help you write an SQL query with a CTE that, given a table IPLMatches (columns: match_id, team, runs, match_year), 
-- calculates the total runs scored by each team in 2023 and lists only teams with more than 2000 runs.

CREATE TABLE IPLMatches (
    match_id INT PRIMARY KEY,
    team VARCHAR(50),
    runs INT,
    match_year INT
);

INSERT INTO IPLMatches (match_id, team, runs, match_year) VALUES
-- Mumbai Indians
(1, 'Mumbai Indians', 180, 2023),
(2, 'Mumbai Indians', 190, 2023),
(3, 'Mumbai Indians', 200, 2023),
(4, 'Mumbai Indians', 175, 2023),
(5, 'Mumbai Indians', 210, 2023),
(6, 'Mumbai Indians', 185, 2023),
(7, 'Mumbai Indians', 195, 2023),
(8, 'Mumbai Indians', 205, 2023),
(9, 'Mumbai Indians', 220, 2023),
(10, 'Mumbai Indians', 215, 2023),

-- Chennai Super Kings
(11, 'Chennai Super Kings', 200, 2023),
(12, 'Chennai Super Kings', 220, 2023),
(13, 'Chennai Super Kings', 198, 2023),
(14, 'Chennai Super Kings', 210, 2023),
(15, 'Chennai Super Kings', 205, 2023),
(16, 'Chennai Super Kings', 215, 2023),
(17, 'Chennai Super Kings', 225, 2023),
(18, 'Chennai Super Kings', 230, 2023),
(19, 'Chennai Super Kings', 240, 2023),
(20, 'Chennai Super Kings', 250, 2023),

-- Royal Challengers Bangalore
(21, 'Royal Challengers Bangalore', 210, 2023),
(22, 'Royal Challengers Bangalore', 205, 2023),
(23, 'Royal Challengers Bangalore', 215, 2023),
(24, 'Royal Challengers Bangalore', 220, 2023),
(25, 'Royal Challengers Bangalore', 225, 2023),
(26, 'Royal Challengers Bangalore', 230, 2023),
(27, 'Royal Challengers Bangalore', 240, 2023),
(28, 'Royal Challengers Bangalore', 245, 2023),
(29, 'Royal Challengers Bangalore', 250, 2023),
(30, 'Royal Challengers Bangalore', 255, 2023),

-- Delhi Capitals
(31, 'Delhi Capitals', 150, 2023),
(32, 'Delhi Capitals', 160, 2023),
(33, 'Delhi Capitals', 170, 2023),
(34, 'Delhi Capitals', 180, 2023),
(35, 'Delhi Capitals', 190, 2023),
(36, 'Delhi Capitals', 200, 2023),
(37, 'Delhi Capitals', 210, 2023),
(38, 'Delhi Capitals', 220, 2023),
(39, 'Delhi Capitals', 230, 2023),
(40, 'Delhi Capitals', 240, 2023);


WITH TeamRuns AS (
    SELECT team, SUM(runs) AS total_runs
    FROM IPLMatches
    WHERE match_year = 2023
    GROUP BY team
)
SELECT team, total_runs
FROM TeamRuns
WHERE total_runs > 2000;

