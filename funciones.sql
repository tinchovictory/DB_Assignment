/*- Funciones.sql -*/


/* Trigger para mantener actualizado el valor de cantidad */

CREATE TRIGGER BeforeInsertForEachActua BEFORE INSERT ON actua
FOR EACH ROW
EXECUTE PROCEDURE updateCantidadFilms();

--/
CREATE OR REPLACE FUNCTION updateCantidadFilms()
RETURNS Trigger AS $$
BEGIN
        UPDATE actor SET cantidad_films = cantidad_films + 1 WHERE id_actor = new.id_actor;
        RETURN new;
END
$$ LANGUAGE plpgsql;
/


/* Funciones para normalizar datos al ejecutar la funcion inserta_datos */

--/
CREATE OR REPLACE FUNCTION agregarPeliculas()
RETURNS VOID AS $$
DECLARE
	aFilm pelicula%ROWTYPE;
	myCursor CURSOR FOR SELECT id_film,title,title_es,title_en,title_orig,year_,plot,synopsis_es,synopsis_en,tagline,duration,color,id_youtube,url_ticket FROM film;
BEGIN
	OPEN myCursor;
	LOOP
		FETCH myCursor INTO aFilm;
		EXIT WHEN NOT FOUND;
		INSERT INTO pelicula VALUES (aFilm.*);
	END LOOP;
	CLOSE myCursor;
END
$$ LANGUAGE plpgsql;
/


--/
CREATE OR REPLACE FUNCTION isDirector(IN idDirector INT)
RETURNS BOOLEAN AS $$      
BEGIN
	RETURN (1 = (SELECT COUNT(*) FROM director WHERE id_director = idDirector));
END
$$ LANGUAGE plpgsql;
/


--/
CREATE OR REPLACE FUNCTION agregarDirgidaPor()
RETURNS VOID AS $$
DECLARE
	directores RECORD;
	myCursor CURSOR FOR SELECT id_film,id_director1,
		id_director2,
		id_director3,
		id_director4,
		id_director5,
		id_director6,
		id_director7,
		id_director8,
		id_director9,
		id_director10,
		id_director11,
		id_director12,
		id_director13,
		id_director14 FROM film;

BEGIN
	OPEN myCursor;
	LOOP
		FETCH myCursor INTO directores;
		EXIT WHEN NOT FOUND;
		
		IF(isDirector(directores.id_director1)) THEN
			INSERT INTO dirige VALUES(directores.id_director1,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director2)) THEN
			INSERT INTO dirige VALUES(directores.id_director2,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director3)) THEN
			INSERT INTO dirige VALUES(directores.id_director3,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director4)) THEN
			INSERT INTO dirige VALUES(directores.id_director4,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director5)) THEN
			INSERT INTO dirige VALUES(directores.id_director5,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director6)) THEN
			INSERT INTO dirige VALUES(directores.id_director6,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director7)) THEN
			INSERT INTO dirige VALUES(directores.id_director7,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director8)) THEN
			INSERT INTO dirige VALUES(directores.id_director8,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director9)) THEN
			INSERT INTO dirige VALUES(directores.id_director9,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director10)) THEN
			INSERT INTO dirige VALUES(directores.id_director10,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director11)) THEN
			INSERT INTO dirige VALUES(directores.id_director11,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director12)) THEN
			INSERT INTO dirige VALUES(directores.id_director12,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director13)) THEN
			INSERT INTO dirige VALUES(directores.id_director13,directores.id_film);
		END IF;
		IF(isDirector(directores.id_director14)) THEN
			INSERT INTO dirige VALUES(directores.id_director14,directores.id_film);
		END IF;     
	END LOOP;
	CLOSE myCursor;
END
$$ LANGUAGE plpgsql;
/


--/
CREATE OR REPLACE FUNCTION isPais(IN idPais INT)
RETURNS BOOLEAN AS $$
BEGIN
	RETURN (1 = (SELECT COUNT(*) FROM pais WHERE id_country = idPais));
END
$$ LANGUAGE plpgsql;
/



--/
CREATE OR REPLACE FUNCTION agregarPertenece()
RETURNS VOID AS $$
DECLARE
	countries RECORD;
	myCursor CURSOR FOR SELECT id_film,
		id_country1,
		id_country2,
		id_country3,
		id_country4,
		id_country5,
		id_country6,
		id_country7,
		id_country8 FROM film;
        
BEGIN
	OPEN myCursor;
	LOOP
		FETCH myCursor INTO countries;
		EXIT WHEN NOT FOUND;
		
		IF(isPais(countries.id_country1)) THEN
			INSERT INTO pertenece VALUES(countries.id_film,countries.id_country1);
		END IF;
		IF(isPais(countries.id_country2)) THEN
			INSERT INTO pertenece VALUES(countries.id_film,countries.id_country2);
		END IF;
		IF(isPais(countries.id_country3)) THEN
			INSERT INTO pertenece VALUES(countries.id_film,countries.id_country3);
		END IF;
		IF(isPais(countries.id_country4)) THEN
			INSERT INTO pertenece VALUES(countries.id_film,countries.id_country4);
		END IF;
		IF(isPais(countries.id_country5)) THEN
			INSERT INTO pertenece VALUES(countries.id_film,countries.id_country5);
		END IF;
		IF(isPais(countries.id_country6)) THEN
			INSERT INTO pertenece VALUES(countries.id_film,countries.id_country6);
		END IF;
		IF(isPais(countries.id_country7)) THEN
			INSERT INTO pertenece VALUES(countries.id_film,countries.id_country7);
		END IF;
		IF(isPais(countries.id_country8)) THEN
			INSERT INTO pertenece VALUES(countries.id_film,countries.id_country8);
		END IF;      
	END LOOP;
	CLOSE myCursor;
END
$$ LANGUAGE plpgsql;
/


--/
CREATE OR REPLACE FUNCTION agregarActor(IN act VARCHAR)
RETURNS VOID
AS $$
BEGIN
	IF(act NOT IN (SELECT nombre FROM actor))
	THEN
		INSERT INTO actor VALUES(NEXTVAL('actorID'), act, 0);
	END IF;
END
$$ LANGUAGE plpgsql;
/

--/
CREATE OR REPLACE FUNCTION agregarActua(IN act VARCHAR, IN idFilm VARCHAR)
RETURNS VOID
AS $$
DECLARE
	id_act actor.id_actor%TYPE;
BEGIN
	SELECT id_actor INTO id_act FROM actor WHERE nombre = act;
	INSERT INTO actua values(id_act, idFilm);
END
$$ LANGUAGE plpgsql;
/


--/
CREATE OR REPLACE FUNCTION agregarActores()
RETURNS VOID AS $$
DECLARE
	actores RECORD;
	actor record;
	myCursor CURSOR FOR SELECT id_film, cast_ FROM film;
	otherCurso CURSOR FOR SELECT * FROM regexp_split_to_table(actores.cast_, ', ') AS nameact;
BEGIN
	OPEN myCursor;
	LOOP
		FETCH myCursor INTO actores;
		EXIT WHEN NOT FOUND;
		OPEN otherCurso;
		LOOP
			FETCH otherCurso INTO actor;
			EXIT WHEN NOT FOUND;
			
			PERFORM agregarActor(actor.nameact);
			PERFORM agregarActua(actor.nameact, actores.id_film);
		END LOOP;
		CLOSE otherCurso;
	END LOOP;
	CLOSE myCursor;
END
$$ LANGUAGE plpgsql;
/



--/
CREATE OR REPLACE FUNCTION inserta_datos()
RETURNS VOID AS $$
BEGIN
	PERFORM agregarPeliculas();
	PERFORM agregarDirgidaPor();
	PERFORM agregarPertenece();
	PERFORM agregarActores();
END
$$ LANGUAGE plpgsql;
/