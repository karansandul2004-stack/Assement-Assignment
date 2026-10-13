-- SESSION 14 - Window Functions (Part 2: ROW_NUMBER, RANK, DENSE_RANK)Topics:ROW_NUMBERRANKDENSE_RANKDemo:Top 3 selling products per region.
-- Tasks
-- 1.Given a table Orders with columns (order_id, user_id, order_date, total_amount), write an SQL query using ROW_NUMBER() to assign a unique sequential number to each order per user, ordered by order_date descending.
-- 2.Suppose you have a table called Songs with columns (song_id, artist, streams). Write an SQL query using RANK() to list each song along with its rank based on streams within each artist.
-- 3.For a table named Movies with columns (movie_id, genre, rating), write an SQL query using DENSE_RANK() to assign a rank to each movie within its genre based on rating, with the highest rating getting rank 1.
-- 4.Imagine a table named Influencers with columns (id, platform, followers). Write an SQL query to display the top 3 influencers per platform using ROW_NUMBER(), showing id, platform, followers, and their row number.<br><br><em><strong>Hint:</strong> Use a subquery or CTE to filter for row numbers less than or equal to 3.</em>


-- 1.Given a table Orders with columns (order_id, user_id, order_date, total_amount), write an SQL query using ROW_NUMBER() to assign a unique sequential number to 
-- each order per user, ordered by order_date descending.

CREATE TABLE Orders_1 (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO Orders_1 (order_id, user_id, order_date, total_amount) VALUES
(1, 101, '2023-10-01', 450.00),
(2, 101, '2023-10-05', 720.00),
(3, 101, '2023-10-10', 980.00),
(4, 102, '2023-09-15', 650.00),
(5, 102, '2023-09-20', 870.00),
(6, 103, '2023-08-12', 560.00),
(7, 103, '2023-08-18', 1200.00),
(8, 104, '2023-07-01', 300.00),
(9, 104, '2023-07-05', 1500.00),
(10, 105, '2023-06-25', 700.00);

Select order_id,
user_id,
order_date,
total_amount, 
row_number() over(partition by user_id order by order_date desc) as row_rank 
from orders_1;

-- 2.Suppose you have a table called Songs with columns (song_id, artist, streams). 
-- Write an SQL query using RANK() to list each song along with its rank based on streams within each artist.

alter table songs add column streams int;

update songs set streams = 5000000 where song_id = 1;
update songs set streams = 4200000 where song_id = 2;
update songs set streams = 3800000 where song_id = 3;
update songs set streams = 3500000 where song_id = 4;
update songs set streams = 2900000 where song_id = 5;
update songs set streams = 3100000 where song_id = 6;
update songs set streams = 1900000 where song_id = 7;
update songs set streams = 4800000 where song_id = 8;

select song_id, 
song_name,
artist_name, 
streams, 
rank() over (partition by artist_name order by streams desc) as rnk 
from songs;

-- 3.For a table named Movies with columns (movie_id, genre, rating), write an SQL query using DENSE_RANK() to assign a rank to 
-- each movie within its genre based on rating, with the highest rating getting rank 1.

select movie_id,
genre,
rating,
dense_rank() over(partition by genre order by rating desc) as rnk_rating
from movies;

-- 4.Imagine a table named Influencers with columns (id, platform, followers). 
-- Write an SQL query to display the top 3 influencers per platform using ROW_NUMBER(), showing id, platform, followers, 
-- and their row number.<br><br><em><strong>Hint:</strong> Use a subquery or CTE to filter for row numbers less than or equal to 3.</em>

alter table influencers 
add column platfrom varchar(50),
add column followers int;

update influencers set platfrom = "Instagram", followers = 120000 where influencer_id = 1;
update influencers set platfrom = "YouTube", followers = 150000 where influencer_id = 2;
update influencers set platfrom = "Twitter", followers = 90000 where influencer_id = 3;

with RankInfluencer as (
select influencer_id, influencer_name, city,
platfrom,
followers,
row_number() over(partition by platfrom order by followers desc) as row_num
from influencers
)
select influencer_id,influencer_name,city,
platfrom,
followers,
row_num
from RankInfluencer
where row_num <= 3;