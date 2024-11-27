USE sakila;

/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/ /* OK */

SELECT
DISTINCT(title)
FROM film;

/* 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/ /* OK */

SELECT
DISTINCT(title),
rating
FROM film
WHERE rating = 'PG-13';

/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.*/ /* OK */

SELECT
DISTINCT(title),
description
FROM film
WHERE description LIKE '%amazing%';

/* 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/ /* OK */

SELECT
DISTINCT(title),
length
FROM film
WHERE length > 120;

/* 5. Recupera los nombres de todos los actores.*/ /* OK */ 

SELECT
first_name,
last_name
FROM actor;

/* 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/ /* OK */

SELECT
first_name,
last_name
FROM actor
WHERE last_name LIKE '%Gibson%';

/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/ /* REPASAR */

SELECT
actor_id,
first_name,
last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20
AND actor_id IS NOT NULL;

/* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su* clasificación.*/ /* OK */

SELECT
title,
rating
FROM FILM
WHERE rating NOT LIKE"R"
AND rating NOT LIKE "PG-13";

/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.*/ /* OK */

SELECT
rating,
COUNT(film_id) AS recuento
FROM film
GROUP BY
rating;

/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/ /* ok */
/* Usamos tablas customer AS c y rental AS r */

SELECT
c.customer_id,
c.first_name,
c.last_name,
COUNT(r.rental_id) AS peliculas_alquiladas
FROM customer AS c
LEFT JOIN rental AS r
ON r.customer_id = c.customer_id
GROUP BY
c.customer_id,
c.first_name,
c.last_name;

/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.*/ /* OK */
/* Usamos tablas: category AS c, film_category AS fc, inventory AS i y rate AS r */

SELECT
c.name AS categoria,
COUNT(r.rental_id) AS recuento_alquiler
FROM category AS c
LEFT JOIN film_category AS fc
ON c.category_id = fc.category_id
LEFT JOIN inventory AS i
ON fc.film_id = i.film_id
LEFT JOIN rental AS r
ON r.inventory_id = i.inventory_id
GROUP BY
c.name;

/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.*/ /* OK */
/* Usamos tablas: film AS f, category AS c y film_category AS fc */

SELECT
rating AS Clasificación,
AVG(length) AS promedio
FROM film
GROUP BY
rating;

/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/ /* OK */

SELECT
first_name,
last_name
FROM actor as A
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
JOIN film AS f
ON f.film_id = fa.film_id
WHERE f.title = "Indian Love";

/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/ /* OK */

SELECT
title,
description
FROM film
WHERE description LIKE "%dog%" OR description LIKE "%cat%";

/* 15. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/ /* OK */

SELECT
title,
release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

SELECT
title,
release_year
FROM film
WHERE release_year = 2006;

/* 16. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/ /* OK */

SELECT
f.title AS titulo,
c.name AS categoria
FROM film AS f
LEFT JOIN film_category AS fc
ON f.film_id = fc.film_id
LEFT JOIN category AS c
ON c.category_id = fc.category_id
WHERE c.name = 'Family';

/* 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film*/ /* OK */

SELECT
title AS titulo,
rating AS categoria,
length AS durAción
FROM film
WHERE rating = "R" AND length > 120;

/* BONUS */

/* 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/ /* OK */
/* Usamos tablas: actor AS a y film_actor AS fa */

SELECT
a.first_name,
a.last_name,
COUNT(fa.film_id) AS numero_peliculas
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY
a.first_name,
a.last_name
HAVING numero_peliculas > 10;

/* 19. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.*/

SELECT
a.first_name,
a.last_name
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL; 

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/

SELECT
c.name as categoria,
AVG(f.length) AS promedio_duracion
FROM category AS c
LEFT JOIN film_category AS fc
ON c.category_id = fc.category_id
LEFT JOIN film AS f
ON f.film_id = c.category_id
GROUP BY
name
HAVING promedio > 120;

/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.*/

SELECT
a.first_name,
a.last_name,
COUNT(fa.film_id) AS num_peliculas
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY
a.first_name,
a.last_name
HAVING num_peliculas >= 5;

/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días */
/* y luego selecciona las películas correspondientes.*/
/* Usamos tablas: film AS f, rental AS r */

SELECT
f.title
FROM film AS f
WHERE f.film_id IN (
	SELECT
    rental_id
    FROM rental AS r
    GROUP BY
    r.rental_id
    HAVING COUNT(r.rental_id) > 5
    );

/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.*/


/* 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.*/ /* OK */

SELECT
f.title AS titulo,
c.name,
f.length AS duración
FROM film AS f
LEFT JOIN film_category AS fc
ON fc.film_id = f.film_id
LEFT JOIN category AS c
ON fc.category_id = c.category_id
WHERE f.length > 180 AND c.name = 'comedy';

/* 25. Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/

SELECT
a.first_name,
a.last_name
FROM actor AS A