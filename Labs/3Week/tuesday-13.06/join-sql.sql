USE sakila;
show tables;
Select amount, return_date 
From payment join rental 
using (rental_id);
#List the number of films per category
select * from country;
select * from city;
select * from payment;
Select count(film_category.film_if) as number_of_film, category.name from film_category join category on 
film_category.category_id = category.category_id
group by category.name;
#Retrieve the store ID, city, and country for each store
SELECT store.store_id, city.city, country.country
FROM store join address on store.address_id = address.address_id
join city on address.city_id = city.city_id 
join country on city.country_id = country.country_id;

#Calculate the total revenue generated by each store in dollars.
SELECT store.store_id, sum(payment.amount) 
From store 
join staff on
store.store_id = staff.store_id join payment on staff.staff_id = payment.staff_id
group by store_id;

#Determine the average running time of films for each category.
SELECT AVG(LENGTH), name
FROM FILM JOIN film_category on film.film_id = film_category.film_id join category on film_category.category_id = category.category_id
group by name;
#Identify the film categories with the longest average running time.
SELECT AVG(LENGTH), name
FROM FILM JOIN film_category on film.film_id = film_category.film_id join category on film_category.category_id = category.category_id
group by name
order by AVG(LENGTH) desc;
#Display the top 10 most frequently rented movies in descending order.
Select film.title, count(payment.rental_id) as frequency
from film join inventory on film.film_id = inventory.film_id join rental on inventory.inventory_id = rental.inventory_id 
join payment on rental.rental_id = payment.rental_id
group by title
order by frequency desc
limit 10;
#b)
SELECT title
FROM film AS f
JOIN inventory AS inv
ON f.film_id = inv.film_id
JOIN rental as r
ON inv.inventory_id = r.inventory_id
GROUP BY inv.film_id
ORDER BY count(inv.film_id) DESC
LIMIT 10;


#Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT *
from inventory
JOIN film
ON film.film_id = inventory.film_id
WHERE film.title="Academy Dinosaur" AND inventory.store_id = 1;

