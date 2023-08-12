create database Tourism;
-- Create the tables
CREATE TABLE tourists (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  nationality VARCHAR(255) NOT NULL,
  arrival_date DATE NOT NULL,
  departure_date DATE NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE destinations (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE activities (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  destination_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (destination_id) REFERENCES destinations (id)
);

CREATE TABLE bookings (
  id INT NOT NULL AUTO_INCREMENT,
  tourist_id INT NOT NULL,
  activity_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (tourist_id) REFERENCES tourists (id),
  FOREIGN KEY (activity_id) REFERENCES activities (id)
);

CREATE TABLE reviews (
  id INT NOT NULL AUTO_INCREMENT,
  tourist_id INT NOT NULL,
  activity_id INT NOT NULL,
  rating INT NOT NULL,
  review TEXT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (tourist_id) REFERENCES tourists (id),
  FOREIGN KEY (activity_id) REFERENCES activities (id)
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

SELECT *
FROM bookings
WHERE activity_id = 6;

SELECT *
FROM tourists
WHERE arrival_date <= CURDATE() AND departure_date >= CURDATE()
AND nationality = 'United Kingdom';

SELECT *
FROM destinations
WHERE country = 'Italy';

SELECT *
FROM activities
WHERE destination_id = (SELECT destination_id FROM destinations WHERE name = 'Paris');

SELECT *
FROM bookings
WHERE tourist_id = 2;

SELECT *
FROM reviews
WHERE rating = 5;

SELECT DISTINCT tourists.*
FROM tourists
INNER JOIN bookings ON tourists.tourist_id = bookings.tourist_id
INNER JOIN activities ON bookings.activity_id = activities.activity_id 
INNER JOIN destinations ON activities.destination_id = destinations.destination_id
WHERE destinations.name = 'New York City';

SELECT *
FROM bookings
WHERE activity_id = 6;

SELECT DISTINCT tourists.*
FROM tourists
INNER JOIN reviews ON tourists.tourist_id = reviews.tourist_id;

SELECT *
FROM activities
WHERE description LIKE '%stunning%';

SELECT reviews.*
FROM reviews
INNER JOIN tourists ON reviews.tourist_id = tourists.tourist_id 
WHERE tourists.nationality = 'Australia';

SELECT DISTINCT tourists.*
FROM tourists
INNER JOIN bookings ON tourists.tourist_id = bookings.tourist_id
INNER JOIN activities ON bookings.activity_id = activities.activity_id
INNER JOIN destinations ON activities.destination_id = destinations.destination_id
WHERE destinations.country = 'France';

SELECT *
FROM activities
WHERE activity_id IN (SELECT activity_id FROM reviews WHERE rating >= 4);

SELECT DISTINCT tourists.*
FROM tourists
INNER JOIN bookings ON tourists.tourist_id = bookings.tourist_id
INNER JOIN activities ON bookings.activity_id = activities.activity_id
INNER JOIN destinations ON activities.destination_id = destinations.destination_id
WHERE destinations.country IN ('Italy', 'Australia')
GROUP BY tourists.tourist_id
HAVING COUNT(DISTINCT destinations.country) = 2;

SELECT *
FROM bookings
WHERE start_date BETWEEN '2023-06-06' AND '2023-06-12';

SELECT *
FROM activities
WHERE activity_id NOT IN (SELECT activity_id FROM reviews);

SELECT *
FROM tourists
WHERE DATEDIFF(departure_date, arrival_date) > 10;

SELECT activities.activity_id, activities.name, AVG(reviews.rating) AS average_rating
FROM activities
LEFT JOIN reviews ON activities.activity_id= reviews.activity_id
GROUP BY activities.activity_id, activities.name;

SELECT activities.activity_id, activities.name, AVG(reviews.rating) AS average_rating
FROM activities
LEFT JOIN reviews ON activities.activity_id = reviews.activity_id
GROUP BY activities.activity_id, activities.name
ORDER BY average_rating DESC
LIMIT 5;

SELECT bookings.*
FROM bookings
INNER JOIN tourists ON bookings.tourist_id = tourists.tourist_id
WHERE tourists.nationality = 'United States';

SELECT activities.activity_id, activities.name, COUNT(bookings.booking_id) AS num_bookings
FROM activities
LEFT JOIN bookings ON activities.activity_id = bookings.activity_id
GROUP BY activities.activity_id, activities.name
ORDER BY num_bookings DESC;

