-- 1. Find out the number of documentaries with deleted scenes.

SELECT count(*) as NoOfDocmentaries
FROM film,film_list
WHERE film.film_id=film_list.FID
AND film.special_features LIKE "%Deleted Scenes%"
AND film_list.category="Documentary";

-- 2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens.

SELECT count(DISTINCT film_list.FID) as NoOfSciFiMoviesRented
FROM film_list,inventory,rental,staff,store
WHERE film_list.FID=inventory.film_id
AND inventory.store_id=store.store_id
AND rental.staff_id=staff.staff_id
AND staff.store_id=store.store_id
AND staff.first_name="Jon"
AND staff.last_name="Stephens"
AND film_list.category="Sci-Fi";

-- 3. Find out the total sales from Animation movies.

SELECT category, sum(total_sales) as totalsales
FROM sales_by_film_category
WHERE category="Animation";

-- 4. Find out the top 3 rented category of movies by “PATRICIA JOHNSON”.

SELECT category.name,count(film.film_id)
FROM rental,film,category,inventory,actor,film_actor,film_category
WHERE rental.inventory_id=inventory.inventory_id
AND inventory.film_id=film.film_id
AND film_category.category_id=category.category_id
AND film_actor.film_id=film.film_id
AND actor.actor_id=film_actor.actor_id
AND film_category.film_id=film.film_id
AND actor.first_name="PATRICIA"
AND actor.last_name="JOHNSON"
GROUP BY category.name
ORDER BY count(film.film_id) DESC
LIMIT 3;

 -- actor “PATRICIA JOHNSON” doesnot exists
 
SELECT *
FROM actor
WHERE actor.first_name="PATRICIA"
AND actor.last_name="JOHNSON";

-- 5. Find out the number of R rated movies rented by “SUSAN WILSON”.

SELECT count(DISTINCT film.film_id) 
FROM film, customer,rental,inventory
WHERE film.film_id=inventory.film_id
AND inventory.inventory_id=rental.inventory_id
AND rental.customer_id=customer.customer_id
AND film.rating="R"
AND customer.first_name="SUSAN"
AND customer.last_name="WILSON";
