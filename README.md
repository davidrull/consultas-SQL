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
aqui se saca las peliculas en las que el idioma es igual que el original, pero como puede ser que alguna peli no tenga idioma original o este vacio se añade el NULL para que si es NULL tambien la muestre.

9. SELECT 
    MIN(replacement_cost) AS minimo,
    MAX(replacement_cost) AS maximo,
    AVG(replacement_cost) AS promedio
   FROM film;
   Aquí puedo ver cuál es la película con el costo de reemplazo más bajo, cuál es la más cara y también el costo promedio. Si la desviación es grande, quiere decir que los precios de reemplazo varían mucho, es decir, hay películas que cuestan mucho reemplazar y otras que cuestan poco. 
   