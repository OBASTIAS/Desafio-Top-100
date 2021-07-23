\echo 'eliminar DDBB peliculas'
DROP DATABASE peliculas;

\echo '1. Crear base de datos llamada películas.'
CREATE DATABASE peliculas;

\echo 'Conectarse DDBB peliculas'

\c peliculas;


\echo 'Crear Tabla Peliculas'
CREATE TABLE peliculas(
    id SERIAL PRIMARY KEY,
    movie VARCHAR(255), 
    premiere_year INT, 
    director VARCHAR(255)
);

\echo 'Crear Tabla Reparto'
CREATE TABLE reparto (
    id INT ,
    actors VARCHAR(255),
    FOREIGN KEY(id) REFERENCES peliculas(id) 
     
);

\echo '2. Cargar ambos archivos a su tabla correspondiente.'

\copy peliculas FROM 'peliculas.csv' header csv;
\copy reparto FROM 'reparto.csv' csv

\echo '3. Obtener el ID de la película “Titanic”.'

SELECT id FROM peliculas WHERE movie = 'Titanic';

\echo '4. Listar a todos los actores que aparecen en la película "Titanic"'

SELECT r.actors FROM peliculas as  p LEFT JOIN reparto AS r ON r.id = p.id WHERE p.movie = 'Titanic';

\echo '5. Consultar en cuántas películas del top 100 participa Harrison Ford.'

SELECT actors ,COUNT(id) as Total_de_Peliculas FROM reparto GROUP BY actors HAVING actors = 'Harrison Ford';

\echo '6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.'

SELECT * FROM peliculas as p  WHERE p.premiere_year BETWEEN 1990 AND 1999 ORDER BY p.premiere_year;

\echo '7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.'

SELECT LENGTH(movie) AS longitud_titulo FROM peliculas;

\echo '8. Consultar cual es la longitud más grande entre todos los títulos de las películas.'

SELECT MAX(LENGTH(movie)) AS maxima_longitud FROM peliculas;