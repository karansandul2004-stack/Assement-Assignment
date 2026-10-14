-- SESSION 16 - String FunctionsTopics:CONCAT, LOWER, UPPERSUBSTR, LEFT, RIGHTREPLACE, TRIMDemo:Clean inconsistent product codes.
-- Tasks
-- 1.Write an SQL query using CONCAT to combine first_name and last_name columns from a users table into a single full_name column and display the result.
-- 2.Given a table called playlists with a column song_title, write a query to display all song titles in uppercase using the UPPER function.
-- 3.You have a table food_items with a column item_code that sometimes contains extra spaces at the beginning or end. Write an SQL query to select item_code values after removing all leading and trailing spaces using TRIM.
-- 4.In a table called movies, the column imdb_id contains codes like 'tt1234567'. Write a query to extract just the numeric part (the last 7 characters) using RIGHT and display it as movie_number.<br><br><em><strong>Hint:</strong> Use RIGHT(imdb_id, 7) to get the numeric part.</em>
-- 5.A products table has a column sku_code where some entries use dashes (e.g. 'MOB-123-XY'). Write an SQL query to replace all dashes '-' with underscores '_' in sku_code using the REPLACE function and display the updated codes.

-- 1.Write an SQL query using CONCAT to combine first_name and last_name columns from a users table into a single full_name column and display the result.

CREATE TABLE Users_1 (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

INSERT INTO Users_1 (user_id, first_name, last_name) VALUES
(1, 'Aditi', 'Sharma'),
(2, 'Rohan', 'Mehta'),
(3, 'Sneha', 'Patel'),
(4, 'Karan', 'Joshi'),
(5, 'Priya', 'Desai');

select user_id,
first_name,
last_name,
concat(first_name," ",last_name) as full_name
from users_1;

-- 2.Given a table called playlists with a column song_title, write a query to display all song titles in uppercase using the UPPER function.

CREATE TABLE Playlists_1 (
    playlist_id INT PRIMARY KEY,
    song_title VARCHAR(100)
);

INSERT INTO Playlists_1 (playlist_id, song_title) VALUES
(1, 'Shape of You'),
(2, 'Blinding Lights'),
(3, 'Tum Hi Ho'),
(4, 'Channa Mereya'),
(5, 'Teri Mitti');

Select 
playlist_id,
upper(song_title) song_title_upper 
from playlists_1;

-- 3.You have a table food_items with a column item_code that sometimes contains extra spaces at the beginning or end. 
-- Write an SQL query to select item_code values after removing all leading and trailing spaces using TRIM.

CREATE TABLE Food_Items (
    item_id INT PRIMARY KEY,
    item_code VARCHAR(50)
);

INSERT INTO Food_Items (item_id, item_code) VALUES
(1, '  PIZZA01  '),
(2, 'BURGER02   '),
(3, '   PASTA03'),
(4, 'SANDWICH04'),
(5, '  SALAD05   ');

Select 
item_id,
trim(item_code) item_code
from food_items;

-- 4.In a table called movies, the column imdb_id contains codes like 'tt1234567'. 
-- Write a query to extract just the numeric part (the last 7 characters) using RIGHT and display it as movie_number.<br><br><em><strong>
-- Hint:</strong> Use RIGHT(imdb_id, 7) to get the numeric part.</em>

CREATE TABLE Movies_1 (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    imdb_id VARCHAR(20)
);

INSERT INTO Movies_1 (movie_id, title, imdb_id) VALUES
(1, 'Inception', 'tt1375666'),
(2, 'The Dark Knight', 'tt0468569'),
(3, 'Interstellar', 'tt0816692'),
(4, 'Parasite', 'tt6751668'),
(5, 'Dangal', 'tt5074352');

select movie_id,
title,
imdb_id,
right(imdb_id,7) numeric_id
from movies_1;

-- 5.A products table has a column sku_code where some entries use dashes (e.g. 'MOB-123-XY'). 
-- Write an SQL query to replace all dashes '-' with underscores '_' in sku_code using the REPLACE function and display the updated codes.

CREATE TABLE Products_1 (
    product_id INT PRIMARY KEY,
    sku_code VARCHAR(50)
);

INSERT INTO Products_1 (product_id, sku_code) VALUES
(1, 'MOB-123-XY'),
(2, 'LAP-456-ZZ'),
(3, 'TAB-789-AA'),
(4, 'CAM-321-BB'),
(5, 'TV-654-CC');

select
product_id,
replace(sku_code, '-', '_' ) as update_sku_code
from products_1;

