/*- importaciones.sql -*/

--/
CREATE OR REPLACE FUNCTION vaciarTodas()
RETURNS VOID AS $$
BEGIN
	TRUNCATE film, dirige, pertenece, actua, actor, director, pais, pelicula RESTART IDENTITY;
END
$$ LANGUAGE plpgsql;
/

--/
CREATE OR REPLACE FUNCTION importarPais()
RETURNS VOID AS $$
BEGIN
        DELETE FROM pais;
	copy pais from '/Users/martin/Downloads/DataTP/bafici13-paises.csv' (FORMAT csv, HEADER, DELIMITER ',');
END
$$ LANGUAGE plpgsql;
/

--/
CREATE OR REPLACE FUNCTION importarDirector()
RETURNS VOID AS $$
BEGIN
	DELETE FROM director;
	copy director from '/Users/martin/Downloads/DataTP/bafici13-directores.csv' (FORMAT csv, HEADER, DELIMITER ';');
END
$$ LANGUAGE plpgsql;
/

--/
CREATE OR REPLACE FUNCTION importarFilm()
RETURNS VOID AS $$
BEGIN
	DELETE FROM film;
	copy film from '/Users/martin/Downloads/DataTP/bafici13-filmsPRUEBA.csv' (FORMAT csv, HEADER, DELIMITER ',');
END
$$ LANGUAGE plpgsql;
/

--/
CREATE OR REPLACE FUNCTION importarFilm2()
RETURNS VOID AS $$
BEGIN
	DELETE FROM film;
	copy film from '/Users/martin/Downloads/DataTP/bafici13-filmsTEST.csv' (FORMAT csv, HEADER, DELIMITER ',', ENCODING 'latin1');
END
$$ LANGUAGE plpgsql;
/
