
USE sakila;
#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT COUNT(*) AS copy_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

#2
SELECT film_id, title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);


#Use a subquery to display all actors who appear in the film "Alone Trip".
select first_name 
from actor
where actor_id in (Select actor_id
from film_actor
where film_id = (select film_id 
from film
	where title = 'Alone Trip'));
#Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
select title
from film 
where film_id in (select film_id
from film_category 
where category_id = (select category_id 
from category
where name = 'family'));
#Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT c.first_name, c.email
FROM customer c
WHERE c.address_id IN (
    SELECT a.address_id
    FROM address a
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    WHERE co.country = 'Canada');
#Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
#First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in



SELECT fa.film_id, f.title
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id IN (SELECT fa.actor_id, COUNT(*) AS film_count
FROM film_actor fa
GROUP BY fa.actor_id
ORDER BY film_count DESC
LIMIT 1);

SELECT f.film_id, f.title
FROM film f
JOIN (
    SELECT fa.film_id
    FROM film_actor fa
    WHERE fa.actor_id = (
        SELECT fa.actor_id
        FROM film_actor fa
        GROUP BY fa.actor_id
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
) subquery ON f.film_id = subquery.film_id;

#Find the films rented by the most profitable customer in the Sakila database. You can use the customer and payment tables to find the most
#profitable customer, i.e., the customer who has made the largest sum of payments.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_payments
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_payments DESC
LIMIT 1;

SELECT f.film_id, f.title
From film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id 
JOIN customer c ON r.customer_id = c.customer_id
where c.customer_id = (SELECT c.customer_id
FROM customer JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY SUM(p.amount) DESC
lIMIT 1);

#Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
#You can use subqueries to accomplish this.
SELECT customer_id, total_amount_spent
FROM (
    SELECT customer_id, SUM(amount) AS total_amount_spent
    FROM payment
    GROUP BY customer_id
) AS subquery
WHERE total_amount_spent > (
    SELECT AVG(total_amount_spent)
    FROM (
        SELECT customer_id, SUM(amount) AS total_amount_spent
        FROM payment
        GROUP BY customer_id
    ) AS average_subquery
);
