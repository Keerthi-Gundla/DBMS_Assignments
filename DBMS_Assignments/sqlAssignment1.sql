SHOW DATABASES;
USE sakila;

-- 1. Find out the PG-13 rated comedy movies. DO NOT use the film_list table.

SELECT film.title 
FROM category JOIN film_category
ON category.category_id = film_category.category_id
JOIN film 
ON film.film_id = film_category.film_id
WHERE category.name="comedy"
AND film.rating="PG-13";

-- 2. Find out the top 3 rented horror movies.

SELECT film.title, sum(payment.amount) AS GrossRent
FROM film, film_category, category, rental, payment, inventory
WHERE film.film_id = film_category.film_id 
AND category.category_id = film_category.category_id
AND rental.inventory_id=inventory.inventory_id 
AND rental.rental_id=payment.rental_id 
AND inventory.film_id=film.film_id
AND category.name="Horror" 
GROUP BY film.title
ORDER BY sum(payment.amount) DESC
LIMIT 3;

-- 3. Find out the list of customers from India who have rented sports movies.

SELECT customer_list.name
FROM film_list,customer_list,rental,inventory
WHERE film_list.FID=inventory.film_id
And inventory.inventory_id=rental.inventory_id
And rental.customer_id=customer_list.ID
AND customer_list.country="India"
AND film_list.category="Sports";

-- 4. Find out the list of customers from Canada who have rented “NICK WAHLBERG” movies.

SELECT customer_list.name
FROM customer_list,rental,inventory,film_actor,actor
WHERE inventory.inventory_id=rental.inventory_id
And rental.customer_id=customer_list.ID
And film_actor.actor_id=actor.actor_id
And film_actor.film_id=inventory.film_id
AND customer_list.country="Canada"
AND actor.first_name="NICK" 
And actor.last_name="WAHLBERG";

-- 5. Find out the number of movies in which “SEAN WILLIAMS” acted.

SELECT count(*) AS NoOfMoviesActed
FROM film_actor,actor,film
WHERE film_actor.actor_id=actor.actor_id
AND film_actor.film_id=film.film_id
AND actor.first_name="SEAN"
AND actor.last_name="WILLIAMS";

