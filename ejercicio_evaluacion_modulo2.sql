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
/* Usamos tablas customer AS c y rental AS r

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
/* -- Tablas: category AS c, film_category AS fc, inventory AS i y rate AS r */

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

/* 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla*/ /* OK */

SELECT
title AS titulo,
rating AS categoria,
length AS durAción
FROM film
WHERE rating = "R" AND length > 120;
