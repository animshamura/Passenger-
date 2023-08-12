create database Tourism;
-- Create the tables
CREATE TABLE tourists (
  tourist_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  nationality VARCHAR(255) NOT NULL,
  arrival_date DATE NOT NULL,
  departure_date DATE NOT NULL,
  PRIMARY KEY (tourist_id)
);

CREATE TABLE destinations (
  destination_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  PRIMARY KEY (destination_id)
);

CREATE TABLE activities (
  activity_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  destination_id INT NOT NULL,
  PRIMARY KEY (activity_id),
  FOREIGN KEY (destination_id) REFERENCES destinations (destination_id)
);

CREATE TABLE bookings (
  booking_id INT NOT NULL AUTO_INCREMENT,
  tourist_id INT NOT NULL,
  activity_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  PRIMARY KEY (booking_id),
  FOREIGN KEY (tourist_id) REFERENCES tourists (tourist_id),
  FOREIGN KEY (activity_id) REFERENCES activities (activity_id)
);

CREATE TABLE reviews (
  review_id INT NOT NULL AUTO_INCREMENT,
  tourist_id INT NOT NULL,
  activity_id INT NOT NULL,
  rating INT NOT NULL,
  review TEXT NOT NULL,
  PRIMARY KEY (review_id),
  FOREIGN KEY (tourist_id) REFERENCES tourists (tourist_id),
  FOREIGN KEY (activity_id) REFERENCES activities (activity_id)
);


INSERT INTO tourists (name, nationality, arrival_date, departure_date)
VALUES ('John Doe', 'United States', '2023-06-01', '2023-06-15'),
('Jane Doe', 'Canada', '2023-06-02', '2023-06-16'),
('Mike Smith', 'United Kingdom', '2023-06-03', '2023-06-17'),
('Mary Jones', 'Australia', '2023-06-04', '2023-06-18'),
('Peter Brown', 'New Zealand', '2023-06-05', '2023-06-19'),
('Susan Green', 'Japan', '2023-06-06', '2023-06-20');

INSERT INTO destinations (name, country)
VALUES ('Paris', 'France'),
('Rome', 'Italy'),
('London', 'United Kingdom'),
('New York City', 'United States'),
('Sydney', 'Australia'),
('Tokyo', 'Japan');

INSERT INTO activities (name, description, destination_id)
VALUES ('Eiffel Tower Tour', 'Visit the iconic Eiffel Tower and take in the stunning views of Paris.', 1),
('Colosseum Tour', 'Explore the ancient Colosseum and learn about its history.', 2),
('Big Ben Tour', 'See the iconic Big Ben and learn about its history.', 3),
('Empire State Building Tour', 'Visit the top of the Empire State Building and take in the stunning views of New York City.', 4),
('Sydney Opera House Tour', 'See the iconic Sydney Opera House and learn about its history.', 5),
('Tokyo Tower Tour', 'Visit the Tokyo Tower and take in the stunning views of Tokyo.', 6);


INSERT INTO reviews (tourist_id, activity_id, rating, review)
VALUES (1, 1, 5, 'The Eiffel Tower Tour was amazing! The views from the top were incredible.'),
(2, 2, 4, 'The Colosseum Tour was interesting, but it was a bit crowded.'),
(3, 3, 3, 'The Big Ben Tour was informative, but it was a bit short.'),
(4, 4, 5, 'The Empire State Building Tour was breathtaking! The views from the top were simply stunning.'),
(5, 5, 4, 'The Sydney Opera House Tour was beautiful, but it was a bit disappointing that we couldn'' go inside.'),
(6, 6, 5, 'The Tokyo Tower Tour was great! The views from the top were amazing and the price was reasonable.');


INSERT INTO bookings (tourist_id, activity_id, start_date, end_date)
VALUES (1, 2, '2023-06-04', '2023-06-05'),
(2, 3, '2023-06-06', '2023-06-07'),
(3, 4, '2023-06-08', '2023-06-09'),
(4, 5, '2023-06-10', '2023-06-11'),
(5, 6, '2023-06-12', '2023-06-13'),
(6, 1, '2023-06-14', '2023-06-15');

-- 1. Find all tourists who have visited at least two destinations
SELECT *
FROM tourists
WHERE tourist_id IN (
    SELECT tourist_id
    FROM bookings
    GROUP BY tourist_id
    HAVING COUNT(destination_id) >= 2
);

-- 2. Find all activities that have been booked by tourists from at least two countries
SELECT *
FROM activities
WHERE activity_id IN (
    SELECT activity_id
    FROM bookings
    GROUP BY activity_id
    HAVING COUNT(DISTINCT nationality) >= 2
);

-- 3. Find the average rating for all activities, grouped by destination
SELECT destination_id, AVG(rating) AS average_rating
FROM activities
GROUP BY destination_id;

-- 4. Find the most popular activity in each destination
SELECT destination_id, activity_id, COUNT(*) AS number_of_bookings
FROM bookings
GROUP BY destination_id, activity_id
ORDER BY number_of_bookings DESC
LIMIT 1;

-- 5. Find the least popular activity in each destination
SELECT destination_id, activity_id, COUNT(*) AS number_of_bookings
FROM bookings
GROUP BY destination_id, activity_id
ORDER BY number_of_bookings ASC
LIMIT 1;

-- 6. Find all tourists who have booked activities that have a rating of 4 stars or higher
SELECT *
FROM tourists
WHERE tourist_id IN (
    SELECT tourist_id
    FROM bookings
    WHERE activity_id IN (
        SELECT activity_id
        FROM activities
        WHERE rating >= 4
    )
);

-- 7. Find all activities that have been booked by tourists who have left a review
SELECT *
FROM activities
WHERE activity_id IN (
    SELECT activity_id
    FROM bookings
    WHERE tourist_id IN (
        SELECT tourist_id
        FROM reviews
    )
);

-- 8. Find all tourists who have booked activities that have a rating of 4 stars or higher and have left a review
SELECT *
FROM tourists
WHERE tourist_id IN (
    SELECT tourist_id
    FROM bookings
    WHERE activity_id IN (
        SELECT activity_id
        FROM activities
        WHERE rating >= 4
    )
)
AND tourist_id IN (
    SELECT tourist_id
    FROM reviews
);

-- 9. Find the average rating for all activities, grouped by destination and nationality
SELECT destination_id, nationality, AVG(rating) AS average_rating
FROM activities
GROUP BY destination_id, nationality;

-- 10. Find the most popular activity in each destination, grouped by nationality
SELECT destination_id, nationality, activity_id, COUNT(*) AS number_of_bookings
FROM bookings
GROUP BY destination_id, nationality, activity_id
ORDER BY number_of_bookings DESC
LIMIT 1;

-- 11. Find all tourists who have booked activities that have a rating of 4 stars or higher, but have not left a review
SELECT *
FROM tourists
WHERE tourist_id IN (
    SELECT tourist_id
    FROM bookings
    WHERE activity_id IN (
        SELECT activity_id
        FROM activities
        WHERE rating >= 4
    )
)
AND tourist_id NOT IN (
    SELECT tourist_id
    FROM reviews
);

-- 12. Find the most popular activity in each destination, grouped by nationality, and ordered by the average rating
SELECT destination_id, nationality, activity_id, COUNT(*) AS number_of_bookings, AVG(rating) AS average_rating
FROM bookings
GROUP BY destination_id, nationality, activity_id
ORDER BY number_of_bookings DESC, average_rating DESC
LIMIT 1;

-- 13. Find all tourists who have booked activities in both Paris and New York City, but not in any other destination
SELECT *
FROM tourists
WHERE tourist_id IN (
    SELECT tourist_id
    FROM bookings
    WHERE activity_id IN (
        SELECT activity_id
        FROM activities
        WHERE destination_id IN (1, 4)
    )
)
AND tourist_id NOT IN (
    SELECT tourist_id
    FROM bookings
    WHERE activity_id IN (
        SELECT activity_id
        FROM activities
        WHERE destination_id != 1 AND destination_id != 4
    )
);

-- 14. Find all activities that have been booked by tourists who have arrived in the last 30 days
SELECT *
FROM activities
WHERE activity_id IN (
    SELECT activity_id
    FROM bookings
    WHERE tourist_id IN (
        SELECT tourist_id
        FROM tourists
        WHERE arrival_date > NOW() - INTERVAL 30 DAY
    )
);

-- 16. Find the average rating for all activities, grouped by destination and month
SELECT destination_id, month, AVG(rating) AS average_rating
FROM activities
GROUP BY destination_id, month;

-- 17. Find the most popular activity in each destination, grouped by month, and ordered by the average rating
SELECT destination_id, month, activity_id, COUNT(*) AS number_of_bookings, AVG(rating) AS average_rating
FROM bookings
GROUP BY destination_id, month, activity_id
ORDER BY number_of_bookings DESC, average_rating DESC
LIMIT 1;

-- 18. Find all tourists who have booked activities in both Paris and New York City, and who have arrived in the last 30 days
SELECT *
FROM tourists
WHERE tourist_id IN (
    SELECT tourist_id
    FROM bookings
    WHERE activity_id IN (
        SELECT activity_id
        FROM activities
        WHERE destination_id IN (1, 4)
    )
)
AND tourist_id IN (
    SELECT tourist_id
    FROM bookings
    WHERE tourist_id IN (
        SELECT tourist_id
        FROM tourists
        WHERE arrival_date > NOW() - INTERVAL 30 DAY
    )
);

-- 19. Find all activities that have been booked by tourists who have left a review, and order the results by the number of bookings
SELECT *
FROM activities
WHERE activity_id IN (
    SELECT activity_id
    FROM bookings
    WHERE tourist_id IN (
        SELECT tourist_id
        FROM reviews
    )
);

-- 20. Find all tourists who have booked activities that have a rating of 4 stars or higher, and who have left a review, and order the results by the date of the booking
SELECT *
FROM tourists
WHERE tourist_id IN (
    SELECT tourist_id
    FROM bookings
    WHERE activity_id IN (
        SELECT activity_id
        FROM activities
        WHERE rating >= 4
    )
)
AND tourist_id IN (
    SELECT tourist_id
    FROM reviews
);
