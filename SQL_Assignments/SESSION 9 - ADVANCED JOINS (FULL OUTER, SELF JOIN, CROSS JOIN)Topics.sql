-- SESSION 9 - ADVANCED JOINS: FULL OUTER, SELF JOIN, CROSS JOINTopics:FULL OUTERSELF JOINCROSS JOIN (Cartesian)When to use eachDemo:Self join employees table ? manager relationship.
-- Tasks
-- 1.Create two tables, influencers and brands, with at least 3 sample rows each. Use a FULL OUTER JOIN to list all influencers and brands, showing influencer_name and brand_name, matching on city. If there is no match, display NULL for the missing side.<br><br><em><strong>Hint:</strong> Use LEFT JOIN, RIGHT JOIN, and UNION if your SQL dialect does not support FULL OUTER JOIN directly.</em>
-- 2.Given a table called playlists with columns (id, playlist_name, parent_playlist_id), write a SELF JOIN query to display each playlist alongside its parent playlist's name, similar to how Spotify might nest playlists.
-- 3.Create two tables: users and offers. Write a CROSS JOIN query to generate all possible combinations of users and offers, displaying user_name and offer_title. Explain in a comment how this could be used for a Flipkart-style personalized offer campaign.
-- 4.You have an employees table with columns (id, name, manager_id). Write a SELF JOIN to display each employee's name along with their manager's name. Then, modify your query to only show employees who do not have a manager (i.e., top-level managers).
-- 5.Use ChatGPT or Copilot to help you write a SQL query that finds all pairs of users from a users table who live in the same city (excluding pairs where the user is compared with themselves). Paste the query and briefly describe how the AI helped you improve or debug it.

-- Tasks
-- 1.Create two tables, influencers and brands, with at least 3 sample rows each. Use a FULL OUTER JOIN to list all influencers and brands, 
-- showing influencer_name and brand_name, matching on city. If there is no match, display NULL for the missing side.<br><br><em><strong>Hint:</strong> 
-- Use LEFT JOIN, RIGHT JOIN, and UNION if your SQL dialect does not support FULL OUTER JOIN directly.</em>

CREATE TABLE influencers (
    influencer_id INT PRIMARY KEY,
    influencer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO influencers VALUES
(1, 'Aditi Sharma', 'Mumbai'),
(2, 'Rohan Mehta', 'Delhi'),
(3, 'Sneha Patel', 'Ahmedabad');

INSERT INTO brands VALUES
(101, 'TechWorld', 'Delhi'),
(102, 'FoodiesHub', 'Ahmedabad'),
(103, 'StyleStreet', 'Bangalore');

Select i.influencer_name, b.brand_name, i.city, b.city
from influencers i
Join brands b
on i.city = b.city;

Select i.influencer_name, b.brand_name, i.city, b.city
from influencers i
Left Join brands b
on i.city = b.city

Union

Select i.influencer_name, b.brand_name, i.city, b.city
from influencers i
Right Join brands b
on i.city = b.city;

-- 2.Given a table called playlists with columns (id, playlist_name, parent_playlist_id), write a SELF JOIN query to display each playlist alongside its parent 
-- playlist's name, similar to how Spotify might nest playlists.

select * from playlist;

alter table playlist 
add parent_playlist_id int Null;

update playlist set parent_playlist_id = 1 where duration = 2400;
update playlist set parent_playlist_id = 1 where duration = 3200;
update playlist set parent_playlist_id = 4 where duration = 2100;
update playlist set parent_playlist_id = Null where duration = 3600;
update playlist set parent_playlist_id = 7 where duration = 4000;
update playlist set parent_playlist_id = 7 where duration = 900;
update playlist set parent_playlist_id = 8 where duration = 1800;

Select parent.playlist_id,
child.user_id,
parent.duration, 
child.parent_playlist_id
from playlist parent
left join playlist child
on parent.parent_playlist_id = child.parent_playlist_id;	

-- 3.Create two tables: users and offers. Write a CROSS JOIN query to generate all possible combinations of users and offers, displaying user_name and offer_title. 
-- Explain in a comment how this could be used for a Flipkart-style personalized offer campaign.

Select * From users;

CREATE TABLE offers (
    offer_id INT PRIMARY KEY,
    offer_title VARCHAR(100)
);

INSERT INTO offers VALUES
(101, '10% Off Electronics'),
(102, 'Buy 1 Get 1 Free'),
(103, 'Free Delivery on Orders Above ₹500');

select u.user_id, o.offer_title
from users u
cross join offers o;

-- 4.You have an employees table with columns (id, name, manager_id). Write a SELF JOIN to display each employee's name along with their manager's name. 
-- Then, modify your query to only show employees who do not have a manager (i.e., top-level managers).

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT NULL
);

INSERT INTO employees (id, name, manager_id) VALUES
(1, 'Aditi Sharma', NULL),   -- Top-level manager
(2, 'Rohan Mehta', 1),       -- Reports to Aditi
(3, 'Sneha Patel', 1),       -- Reports to Aditi
(4, 'Mehul Desai', 2),       -- Reports to Rohan
(5, 'Kavya Iyer', 2),        -- Reports to Rohan
(6, 'Arjun Singh', 3),       -- Reports to Sneha
(7, 'Priya Nair', 3),        -- Reports to Sneha
(8, 'Vikas Kumar', NULL),    -- Another top-level manager
(9, 'Neha Joshi', 8),        -- Reports to Vikas
(10, 'Rahul Verma', 8);      -- Reports to Vikas

select e.id as employee_id,
e.name as employee_name,
m.name as manager_name
from employees e
left join employees m
on e.manager_id = m.id;

WITH duplicates AS (
    SELECT 
        id,
        ROW_NUMBER() OVER (
            PARTITION BY manager_id
            ORDER BY id
        ) AS row_num
    FROM employees
)
DELETE FROM employees
WHERE id IN (
    SELECT id FROM duplicates WHERE row_num > 1
);

select * from employees;

-- 5.Use ChatGPT or Copilot to help you write a SQL query that finds all pairs of users from a users table who live in the same city 
-- (excluding pairs where the user is compared with themselves). Paste the query and briefly describe how the AI helped you improve or debug it.

SELECT 
    u1.user_id AS user1_id,
    u1.username AS user1_name,
    u2.user_id AS user2_id,
    u2.username AS user2_name,
    u1.city
FROM users u1
JOIN users u2
    ON u1.city = u2.city
   AND u1.user_id < u2.user_id;
