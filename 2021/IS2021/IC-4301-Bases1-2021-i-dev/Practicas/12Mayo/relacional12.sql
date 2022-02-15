--  Nombre: Josué David Castro Ramírez
--  Carné : 2020065036

-- Creación del Esquema:
DROP schema IF EXISTS movies;

CREATE schema IF NOT EXISTS movies default CHARACTER SET utf8;
USE movies;


-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS CATEGORIES;
CREATE TABLE IF NOT EXISTS CATEGORIES(
	ctgr_id INT PRIMARY KEY,
    ctgr_name VARCHAR(100) NOT NULL
);
-- --------------------------------------------------------------------------
DROP TABLE IF EXISTS MOVIES;
CREATE TABLE IF NOT EXISTS MOVIES(
	mv_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mv_title VARCHAR(100) NOT NULL,
    mv_release_date DATETIME,
    mv_ctgr_id INT,
   
    CONSTRAINT fk_id FOREIGN KEY(mv_ctgr_id) REFERENCES CATEGORIES(ctgr_id)
);
-- --------------------------------------------------------------------------
DROP TABLE IF EXISTS USERS;
CREATE TABLE IF NOT EXISTS USERS(
	usr_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    usr_user_name VARCHAR(100) NOT NULL,
    usr_f_name VARCHAR(100),
    usr_l_name VARCHAR(100)
);
-- --------------------------------------------------------------------------
DROP TABLE IF EXISTS RATINGS;
CREATE TABLE IF NOT EXISTS RATINGS(
	rt_mv_id INT NOT NULL,
    rt_score INT NOT NULL,
    rt_review VARCHAR(200),
    rt_usr_id INT NOT NULL,
    CONSTRAINT fk_mv_id  FOREIGN KEY(rt_mv_id)  references MOVIES(mv_id),
	CONSTRAINT fk_usr_id FOREIGN KEY(rt_usr_id) references USERS(usr_id)
);
-- --------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO CATEGORIES(ctgr_id, ctgr_name) VALUES (1,'Accion');
INSERT INTO CATEGORIES(ctgr_id, ctgr_name) VALUES (2,'Ciencia Ficción');
INSERT INTO CATEGORIES(ctgr_id, ctgr_name) VALUES (3,'Comedia');
INSERT INTO CATEGORIES(ctgr_id, ctgr_name) VALUES (4,'Drama');
INSERT INTO CATEGORIES(ctgr_id, ctgr_name) VALUES (5,'Románticas');
INSERT INTO CATEGORIES(ctgr_id, ctgr_name) VALUES (6,'Suspenso');
INSERT INTO CATEGORIES(ctgr_id, ctgr_name) VALUES (7,'Terror');
-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO USERS(usr_user_name, usr_f_name, usr_l_name) VALUES ('sjcr_23','Josue','Castro');
INSERT INTO USERS(usr_user_name, usr_f_name, usr_l_name) VALUES ('sdcr_22','David','Ramírez');
INSERT INTO USERS(usr_user_name, usr_f_name, usr_l_name) VALUES ('spar_21','Pacco','Apache');
INSERT INTO USERS(usr_user_name, usr_f_name, usr_l_name) VALUES ('sdcr_20','Danny','Cheng');
INSERT INTO USERS(usr_user_name, usr_f_name, usr_l_name) VALUES ('scr_19','Celeste','Cascante');
-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('Los 3 Chiflados','2001-01-01',3);
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('Star Wars IV','2002-02-02',2);
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('Titanic','2003-03-03', 4);
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('Búsqueda Implacable','2004-04-04', 1);
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('MA1103: Cálculo y Álgebra Lineal','2005-05-05', 7);
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('MA1102: Cálculo Diferencial e Integral','2006-06-06', 7);
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('MA1103: Cálculo y Álgebra Lineal','2007-07-07', 7);
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('MA1403: Matematica Discreta','2008-08-08', 7);
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('MA2404: Probabilidades','2009-09-09', 7);
INSERT INTO MOVIES(mv_title, mv_release_date, mv_ctgr_id) VALUES ('MA3405: Estadistica','2010-10-10', 7);
-- ---------------------------------------------------------------------------------------------------------------------------
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (1,1,5,'XD');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (1,2,1,'Equisde');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (2,2,2,'Ta buena');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (2,3,2,'Epica');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (3,3,3,'Mucho texto');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (3,4,3,'Mae que aburrimiento legal');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (4,4,4,'¿Sherlock Holmes X Rambo?');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (5,5,1,'aiuda :c');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (5,4,1,'help :c');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (5,3,1,'ajuda :c');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (5,2,1,'ave purisima :c');
INSERT INTO RATINGS(rt_mv_id, rt_usr_id, rt_score, rt_review) VALUES (5,1,1,'ya valio :c');
-- ---------------------------------------------------------------------------------------------------------------------------

-- PARTE 3:

    -- a. Implemente una función llamada “number_of_ratings” que retorne la cantidad de 
    --    calificaciones de una película a partir del ID de la película (movie_id)
    
    DROP FUNCTION IF EXISTS number_of_ratings;
    DELIMITER $$
    CREATE FUNCTION number_of_ratings(mv_id INT) RETURNS INT READS SQL DATA
    BEGIN
        DECLARE number_of_reviews INT;
        SELECT COUNT(RATINGS.rt_review) INTO number_of_reviews FROM RATINGS WHERE RATINGS.rt_mv_id = mv_id;
        RETURN(number_of_reviews);
    END$$
    DELIMITER ;

    -- b. En esta base de datos se desea que no existan valores nulos a pesar que existen 
   	--    campos en las tablas movie y rating que aceptan nulos: release_date y review 
	--    respectivamente. Implemente un procedimiento almacenado llamado “defaults” 
	--    que reciba el nombre de la tabla a la que desea aplicar valores por default y de 
 	--    esta forma eliminar los nulos.

    DROP PROCEDURE IF EXISTS  defaults;
    DELIMITER $$
    CREATE PROCEDURE defaults(
        IN nombre VARCHAR(50)
    )
    BEGIN
        CASE nombre
        WHEN 'MOVIES' THEN UPDATE MOVIES SET mv_release_date = NOW() WHERE mv_release_date IS NULL;
        WHEN 'RATINGS'THEN UPDATE RATINGS SET rt_review = '' WHERE rt_review IS NULL;
        ELSE SELECT '' AS 'No se encontro la tabla';
        END CASE;
    END $$
    DELIMITER ;
    CALL defaults('CATEGORIES');

    -- c. Implemente un procedimiento almacenado o una función llamada movie_rating_avg que retorne 
    --    el promedio de las calificaciones de una película.
    DROP FUNCTION IF EXISTS movie_rating_avg;
    DELIMITER $$
    CREATE FUNCTION movie_rating_avg(mv_id INT) RETURNS INT READS SQL DATA
    BEGIN
        DECLARE cantidad_reviews INT;
        DECLARE sumatoria INT;
        DECLARE promedio INT;

        SELECT  number_of_ratings(mv_id) INTO cantidad_reviews;
        SELECT SUM(RATINGS.rt_score) INTO sumatoria FROM RATINGS WHERE RATINGS.rt_mv_id = mv_id;

        SET promedio = sumatoria/cantidad_reviews;
        RETURN promedio;
    END $$
    DELIMITER ;


-- PARTE 2:

--  Consultas: utilice INNER JOIN, RIGHT JOIN, LEFT JOIN en donde sea necesario.

    -- a. Seleccione todas las categorías (id, category_name) que NO tienen asignadas películas.

    SELECT CATEGORIES.* FROM CATEGORIES LEFT JOIN MOVIES
     ON CATEGORIES.ctgr_id = MOVIES.mv_ctgr_id 
     WHERE MOVIES.mv_ctgr_id IS NULL;

    -- b. Seleccione la cantidad de calificaciones (reviews) que se hayan hecho en las categorías.

    SELECT CATEGORIES.*, COUNT(rt_review) FROM RATINGS LEFT JOIN MOVIES
     ON RATINGS.rt_mv_id = MOVIES.mv_id LEFT JOIN CATEGORIES 
     ON CATEGORIES.ctgr_id = MOVIES.mv_ctgr_id 
     GROUP BY rt_mv_id;

    -- c. Seleccione únicamente los nombres de las categorías en donde el usuario con ID = 1 ha puesto calificaciones (ratings).
    SELECT CATEGORIES.* FROM RATINGS LEFT JOIN MOVIES
     ON RATINGS.rt_mv_id = MOVIES.mv_id LEFT JOIN CATEGORIES 
     ON CATEGORIES.ctgr_id = MOVIES.mv_ctgr_id
     WHERE RATINGS.rt_usr_id = 1;

    -- d. Seleccione las películas que NO tienen calificaciones.
    SELECT MOVIES.* FROM RATINGS RIGHT JOIN MOVIES
     ON RATINGS.rt_mv_id = MOVIES.mv_id
     WHERE rt_mv_id IS NULL;

   
    -- Función que cuenta la cantidad de Ratings de una película según su ID.
    SELECT number_of_ratings(5);
    -- Función que hace un promedio de la calificación de Ratings de una película según su ID.
    SELECT movie_rating_avg(5);