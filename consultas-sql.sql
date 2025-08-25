
-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
 SELECT title AS nombre_pelicula
 FROM film
 WHERE rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
 SELECT first_name AS nombre
 FROM actor
 WHERE actor_id BETWEEN 30 AND 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
 SELECT title AS nombre_pelicula
 FROM film
 WHERE language_id = original_language_id
 OR original_language_id IS NULL;

-- 5. Ordena las películas por duración de forma ascendente.
 SELECT title AS nombre, length AS duracion
 FROM film 
 ORDER BY length asc;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
 SELECT first_name AS nombre , last_name AS apellido
 FROM actor
 WHERE last_name = 'ALLEN';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.
 SELECT rating AS clasificacion, COUNT(*) AS recuento
 FROM film
 GROUP BY rating;

-- 8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.
 SELECT title
 FROM film
 WHERE rating = 'PG-13'
 OR length > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
 SELECT 
    MIN(replacement_cost) AS minimo,
    MAX(replacement_cost) AS maximo,
    AVG(replacement_cost) AS promedio
 FROM film;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
 SELECT MAX(length) AS max_duracion, MIN(length) AS min_duracion
 FROM film;

-- 11.  Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
 SELECT payment.amount, rental.rental_date
 FROM payment
 JOIN rental ON payment.rental_id = rental.rental_id
 ORDER BY rental.rental_date DESC
 LIMIT 1 OFFSET 2;
-- 12.  Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.
  SELECT title
  FROM film
  WHERE rating NOT IN ('NC-17', 'G');
-- 13.  Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración
  SELECT rating, AVG(length) AS promedio_duracion
  FROM film
  GROUP BY rating;
-- 14.  Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
  SELECT title
  FROM film
  WHERE length > 180;
--15. ¿Cuánto dinero ha generado en total la empresa?
  SELECT SUM(amount) AS total_ingresos
  FROM payment;
-- 16. Muestra los 10 clientes con mayor valor de id.
  SELECT *
  FROM customer
  ORDER BY customer_id DESC
  LIMIT 10;
-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
  SELECT a.first_name, a.last_name
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  JOIN film f ON fa.film_id = f.film_id
  WHERE f.title = 'Egg Igby';
-- 18. Selecciona todos los nombres de las películas únicos.
  SELECT DISTINCT title
  FROM film;
-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
  SELECT f.title
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Comedy' AND f.length > 180;
-- 20.  Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
  SELECT c.name AS categoria, AVG(f.length) AS promedio_duracion
  FROM category c
  JOIN film_category fc ON c.category_id = fc.category_id
  JOIN film f ON fc.film_id = f.film_id
  GROUP BY c.name
  HAVING AVG(f.length) > 110;
-- 21.  ¿Cuál es la media de duración del alquiler de las películas?
  SELECT AVG(TIMESTAMPDIFF(HOUR, rental_date, return_date)) AS media_duracion_horas
  FROM rental
  WHERE return_date IS NOT NULL;
-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
  SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo
  FROM actor;
-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
  SELECT DATE(rental_date) AS fecha, COUNT(*) AS cantidad_alquileres
  FROM rental
  GROUP BY DATE(rental_date)
  ORDER BY cantidad_alquileres DESC;
-- 24. Encuentra las películas con una duración superior al promedio.
  SELECT title, length
  FROM film
  WHERE length > (
    SELECT AVG(length)
    FROM film);
-- 25. Averigua el número de alquileres registrados por mes.
  SELECT 
   TO_CHAR(rental_date, 'Month') AS mes,
   COUNT(*) AS cantidad_alquileres
  FROM rental
  GROUP BY mes
  ORDER BY mes;
-- 26.  Encuentra el promedio, la desviación estándar y varianza del total pagado.
  SELECT 
   AVG(amount) AS promedio,
   STDDEV(amount) AS desviacion_estandar,
   VARIANCE(amount) AS varianza
  FROM payment;
-- 27. ¿Qué películas se alquilan por encima del precio medio?.
  SELECT title, rental_rate
  FROM film
  WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film);
-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
  SELECT actor_id, COUNT(film_id) AS cantidad_peliculas
  FROM film_actor
  GROUP BY actor_id
  HAVING COUNT(film_id) > 40;
-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
  SELECT 
    f.film_id,
    f.title,
    COUNT(i.inventory_id) AS cantidad_disponible
  FROM film f
  LEFT JOIN inventory i ON f.film_id = i.film_id
  GROUP BY f.film_id, f.title
  ORDER BY f.title;
-- 30. Obtener los actores y el número de películas en las que ha actuado.
  SELECT 
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS cantidad_peliculas
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  GROUP BY a.first_name, a.last_name
  ORDER BY cantidad_peliculas DESC;
-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
  SELECT 
     f.title,
     a.first_name,
     a.last_name
  FROM film f
  LEFT JOIN film_actor fa ON f.film_id = fa.film_id
  LEFT JOIN actor a ON fa.actor_id = a.actor_id
  ORDER BY f.title, a.last_name, a.first_name;
-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
  SELECT 
     a.first_name,
     a.last_name,
     f.title
  FROM actor a
  LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
  LEFT JOIN film f ON fa.film_id = f.film_id
  ORDER BY a.last_name, a.first_name, f.title;
-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
  SELECT 
     film.title,
     rental.rental_date,
     rental.return_date
  FROM film
  JOIN inventory ON film.film_id = inventory.film_id
  JOIN rental ON inventory.inventory_id = rental.inventory_id
  ORDER BY film.title, rental.rental_date;
-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
  SELECT 
    customer_id,
    SUM(amount) AS total_gastado
  FROM payment
  GROUP BY customer_id
  ORDER BY total_gastado DESC
  LIMIT 5;
-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
  SELECT *
  FROM actor
  WHERE first_name = 'JOHNNY';
-- 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
  SELECT 
    first_name AS Nombre,
    last_name AS Apellido
  FROM actor;
-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
  SELECT 
    MIN(actor_id) AS id_minimo,
    MAX(actor_id) AS id_maximo
  FROM actor;
-- 38. Cuenta cuántos actores hay en la tabla “actorˮ.
  SELECT COUNT(*) AS total_actores
  FROM actor;
-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
  SELECT *
  FROM actor
  ORDER BY last_name ASC;
-- 40.  Selecciona las primeras 5 películas de la tabla “filmˮ.
  SELECT *
  FROM film
  LIMIT 5;
-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?.
  SELECT 
    first_name,
    COUNT(*) AS cantidad
  FROM actor
  GROUP BY first_name
  ORDER BY cantidad DESC
  LIMIT 1;
-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
  SELECT 
    rental.rental_id,
    customer.first_name,
    customer.last_name
  FROM rental
  JOIN customer ON rental.customer_id = customer.customer_id
  ORDER BY rental.rental_id;
-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
  SELECT 
    c.first_name,
    c.last_name,
    r.rental_date
  FROM customer c
  LEFT JOIN rental r ON c.customer_id = r.customer_id
  ORDER BY c.last_name, c.first_name, r.rental_date;
-- 44.  Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
  SELECT 
    f.title,
    c.name AS category_name
  FROM film f
  CROSS JOIN category c;
-- no aporta valor ya que un CROSS JOIN junta todas las pelis con todas las categorias sin importar si tienen relacion, y muchas combinaciones no tienen sentido ya que no todas las pelis son de todas las categorias.
-- 45.  Encuentra los actores que han participado en películas de la categoría 'Action'.
  SELECT DISTINCT
    a.first_name,
    a.last_name
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  JOIN film f ON fa.film_id = f.film_id
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Action'
  ORDER BY a.last_name, a.first_name;
-- 46.  Encuentra todos los actores que no han participado en películas
  SELECT a.actor_id, a.first_name, a.last_name
  FROM actor a
  LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
  WHERE fa.film_id IS NULL;
--47.  Selecciona el nombre de los actores y la cantidad de películas en las que han participado
  SELECT 
    a.first_name, 
    a.last_name, 
    COUNT(fa.film_id) AS cantidad_peliculas
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  GROUP BY a.actor_id, a.first_name, a.last_name
  ORDER BY cantidad_peliculas DESC;
--48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado
  CREATE VIEW actor_num_peliculas AS
  SELECT 
    a.first_name, 
    a.last_name, 
    COUNT(fa.film_id) AS cantidad_peliculas
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  GROUP BY a.actor_id, a.first_name, a.last_name;
--49. Calcula el número total de alquileres realizados por cada cliente.
  SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_alquileres
  FROM customer c
  JOIN rental r ON c.customer_id = r.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name
--50. Calcula la duración total de las películas en la categoría 'Action'
  SELECT 
    SUM(f.length) AS duracion_total_minutos
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Action';
--51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente
  --paso1:
  CREATE TEMPORARY TABLE cliente_rentas_temporal (
    customer_id INT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    total_alquileres INT);
  --paso 2:
  INSERT INTO cliente_rentas_temporal (customer_id, first_name, last_name, total_alquileres)
  SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_alquileres
  FROM customer c
  JOIN rental r ON c.customer_id = r.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name;
--52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces
  --paso1:
  CREATE TEMPORARY TABLE peliculas_alquiladas (
    film_id INT,
    title VARCHAR(255),
    total_alquileres INT);
--paso2:
  INSERT INTO peliculas_alquiladas (film_id, title, total_alquileres)
  SELECT 
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS total_alquileres
  FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN film f ON i.film_id = f.film_id
  GROUP BY f.film_id, f.title
  HAVING COUNT(r.rental_id) >= 10;

--53.  Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película
  SELECT DISTINCT f.title
  FROM customer c
  JOIN rental r ON c.customer_id = r.customer_id
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN film f ON i.film_id = f.film_id
  WHERE c.first_name = 'TAMMY'
  AND c.last_name = 'SANDERS'
  AND r.return_date IS NULL
  ORDER BY f.title;

--54.  Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido
  SELECT DISTINCT a.first_name, a.last_name
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  JOIN film_category fc ON fa.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Sci-Fi'
  ORDER BY a.last_name, a.first_name;
--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido
  WITH fecha_primera_alquiler AS (
  SELECT MIN(r.rental_date) AS primera_fecha
  FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN film f ON i.film_id = f.film_id
  WHERE f.title = 'Spartacus Cheaper'),
   peliculas_alquiladas_despues AS (
  SELECT DISTINCT i.film_id
  FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN fecha_primera_alquiler fpa ON r.rental_date > fpa.primera_fecha)
  SELECT DISTINCT a.first_name, a.last_name
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  JOIN peliculas_alquiladas_despues pad ON fa.film_id = pad.film_id
  ORDER BY a.last_name, a.first_name;
--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
  SELECT a.first_name, a.last_name
  FROM actor a
  WHERE NOT EXISTS (
   SELECT 1
   FROM film_actor fa
   JOIN film_category fc ON fa.film_id = fc.film_id
   JOIN category c ON fc.category_id = c.category_id
   WHERE fa.actor_id = a.actor_id
    AND c.name = 'Music')
   ORDER BY a.last_name, a.first_name;
--57.  Encuentra el título de todas las películas que fueron alquiladas por más de 8 días
  SELECT DISTINCT f.title
  FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN film f ON i.film_id = f.film_id
  WHERE DATEDIFF(r.return_date, r.rental_date) > 8;
--58.  Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ
  SELECT DISTINCT f.title
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Animation'
  ORDER BY f.title;
--59.  Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película
  SELECT f2.title
  FROM film f1
  JOIN film f2 ON f1.length = f2.length
  WHERE f1.title = 'Dancing Fever'
  ORDER BY f2.title;
--60.  Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido
  SELECT c.first_name, c.last_name
  FROM customer c
  JOIN rental r ON c.customer_id = r.customer_id
  JOIN inventory i ON r.inventory_id = i.inventory_id
  GROUP BY c.customer_id, c.first_name, c.last_name
  HAVING COUNT(DISTINCT i.film_id) >= 7
  ORDER BY c.last_name, c.first_name;
--61.  Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres
  SELECT 
    c.name AS categoria,
    COUNT(r.rental_id) AS total_alquileres
  FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN film f ON i.film_id = f.film_id
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  GROUP BY c.name
  ORDER BY total_alquileres DESC;

--62. Encuentra el número de películas por categoría estrenadas en 2006.
  SELECT 
    c.name AS categoria,
    COUNT(f.film_id) AS cantidad_peliculas
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE f.release_year = 2006
  GROUP BY c.name
  ORDER BY cantidad_peliculas DESC;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos
  SELECT s.staff_id, s.first_name, s.last_name, st.store_id, st.address_id
  FROM staff s
  CROSS JOIN store st;
--64.  Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas
   SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_alquileres
  FROM customer c
  LEFT JOIN rental r ON c.customer_id = r.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name
  ORDER BY total_alquileres DESC;



