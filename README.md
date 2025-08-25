# consultas-SQL
consultas con postgreSQL a traves de dbeaver.
-lo primero que he hecho ha sido cargar la BBDD en dbeaver.
-lo siguiente ha sido crear el esquema de las tablas directamente en dbeaver y las he colocado y organizado para poder ver mas claro todas las relaciones, para facilitar a si las consultas. 
adjunto archivo del esquema- ![alt text](<diagrama bbdd-1.png>)

1.Consultas:
-a continuacion tan solo explicare las consultas que sean algo mas complejas, como lo entendi y como llegue hasta hacer esa consulta.

 4. Obtén las películas cuyo idioma coincide con el idioma original.
SELECT title
FROM film
WHERE language_id = original_language_id
OR original_language_id IS NULL; 

"aqui se saca las peliculas en las que el idioma es igual que el original, pero como puede ser que alguna peli no tenga idioma original o este vacio se añade el NULL para que si es NULL tambien la muestre."

9.  SELECT 
    MIN(replacement_cost) AS minimo,
    MAX(replacement_cost) AS maximo,
    AVG(replacement_cost) AS promedio
   FROM film;
   
   "Aquí puedo ver cuál es la película con el costo de reemplazo más bajo, cuál es la más cara y también el costo promedio. Si la desviación es grande, quiere decir que los precios de reemplazo varían mucho, es decir, hay películas que cuestan mucho reemplazar y otras que cuestan poco."

11. SELECT payment.amount, rental.rental_date
    FROM payment
    JOIN rental ON payment.rental_id = rental.rental_id
    ORDER BY rental.rental_date DESC
    LIMIT 1 OFFSET 2;
   
   "Aqui usamos el primer JOIN para unir las tablas rental (fecha alquiler)  y payment (costo por alquiler), el ORDER BY DESC ordena del mas reciente al mas antiguo y el LIMIT 1 es para quedarme con 1 despues de saltar 2 (OFFSET 2)."

17. SELECT a.first_name, a.last_name
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'Egg Igby';
   
   "Aqui utilizamos el pirmer doble JOIN para unir las tablas ya que tenemos que unir actor con film actor y con film, primero unimos actor con film actor para ver que actor esta en que pelicula y luego con film para filtrar el titulo, fa abreviatura film actor, f abreviatura film ya abreviatura actor."

19. SELECT f.title
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Comedy' AND f.length > 180;
   
   "Esta es semejante a la anterior solo que unimos las tablas film, film_category y category, en film category estan los ids, en category esta la categoria (comedia) y en film esta la duracion y el tiempo, la "f", "fc" y "c" son abreviaturas."
  
  "Estas me resultaron un poco mas dificiles pero al hacer la primera y tenerla de guia, esta segunda resulta un poco mas facil."


21. SELECT AVG(TIMESTAMPDIFF(HOUR, rental_date, return_date)) AS media_duracion_horas
    FROM rental
    WHERE return_date IS NOT NULL;
  
  " En esta me tuve que apoyar de la IA porque no sabia como hacer para calcular la diferencia en horas entre devolucion y alquiler, se me atraganto un poco y la encontre compleja, a pesar que despues de verla y entenderla es sencilla de lo que parece."

26. SELECT 
     AVG(amount) AS promedio,
     STDDEV(amount) AS desviacion_estandar,
     VARIANCE(amount) AS varianza
    FROM payment;
  
  "En esta tuve que buscar como se hacia la desviacion estandar ya que no lo recordaba. "


29. SELECT 
     f.film_id,
     f.title,
     COUNT(i.inventory_id) AS cantidad_disponible
   FROM film f
   LEFT JOIN inventory i ON f.film_id = i.film_id
   GROUP BY f.film_id, f.title
   ORDER BY f.title;

" En esta consulta usamos el LEFT JOIN entre film e inventory, el LEFT JOIN hace que si una pelicula no tiene copias en el inventario aparezca vacio o null."

45. SELECT DISTINCT
      a.first_name,
      a.last_name
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN film f ON fa.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Action'
    ORDER BY a.last_name, a.first_name;

  "Esta consulta me resulto liosa ya que hay que hacer muchos JOIN al tener que pasar por muchas tablas."

52.  -- paso1:
  CREATE TEMPORARY TABLE peliculas_alquiladas (
    film_id INT,
    title VARCHAR(255),
    total_alquileres INT);
-- paso2:
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
  
  "esta me resulto super liosa al tener que hacerla en dos pasos ."

55.  WITH fecha_primera_alquiler AS (
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
  
" esta al igual que la anterior necesite de la AI para resolverla ."


 