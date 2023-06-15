USE sakila;
#1
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*)=1;

#2
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*)>1;
#3
SELECT staff_id, COUNT(*) AS rental_count
FROM rental
GROUP BY staff_id;
#4
SELECT rating, COUNT(*) AS rating_count
FROM film
GROUP BY rating;

#5 What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT ROUND(AVG(length), 2) AS average_length, rating
FROM film 
GROUP BY rating;

#6 Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, AVG(length) AS average_duration
FROM film 
GROUP BY rating
HAVING  average_duration > 120;



