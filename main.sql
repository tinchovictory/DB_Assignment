/*- main.sql -*/

--/
DO $$
BEGIN

    /* Vaciar todas las tablas */
    --PERFORM vaciarTodas();

    /* Definir una secuencia */
    DROP SEQUENCE IF EXISTS actorID;
    CREATE SEQUENCE actorID;
	
	/* Primera importacion de los datos */
	PERFORM importarPais();
	PERFORM importarDirector();
	PERFORM importarFilm();

	/* Normalizar datos de la tabla film */
	PERFORM insertaDatos();

	/* Agregar mas films */
	PERFORM importarFilm2();

	/* Normalizar los nuevos datos de la tabla film */
	--PERFORM insertaDatos();

END;
$$; 
/