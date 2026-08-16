DELIMITER $
CREATE PROCEDURE agregarReponsable(
in respCed char(10), in respoNombre varchar(50), in respApellido varchar(50), in respTelef char(10))
	BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
    START TRANSACTION;
		IF length(respCed) != 10 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: La longitd de la cedula no es la esperada';
		ELSEIF EXISTS(SELECT 1 FROM responsable WHERE cedula = respCed) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: el responsable ya existe';
		ELSE
			INSERT INTO responsable(cedula,nombre,apellido,telefono)
			VALUES(respCed,respNombre,respApellido,respTelef);
			COMMIT;
		END IF;
	END $
DELIMITER ;

DELIMITER $
	CREATE PROCEDURE eliminarResponsable(in respCed char(10))
    BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
			ROLLBACK;
		END;
        START TRANSACTION;
        IF NOT EXISTS(SELECT 1 FROM responsbale WHERE cedula = respCed) THEN
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'El responsable no existe';
		ELSE 
			DELETE FROM responsable 
            WHERE cedula = respCed;
            COMMIT;
		END IF;
    END $
DELIMITER ;

DELIMITER $
CREATE PROCEDURE actualizarResponsable(in respCed char(10),
 in respoNombre varchar(50), in respApellido varchar(50), in respTelef char(10))
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
			ROLLBACK;
		END;
        
        START TRANSACTION;
        IF NOT EXISTS(SELECT 1 FROM responsable WHERE cedula = respCed) THEN
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Error: El responsable no existe';
        ELSEIF LENGTH(respCed) != 10  then
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Error: La longitud de la cedula no es la esperada';
		ELSEIF LENGTH(respTelef) != 19 then
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Error: La longitud del numero telefonico no es el esperado';
        ELSE
            UPDATE responsable set telefono= tef where cedula = ced;
            COMMIT;
		END IF;
	END $
DELIMITER ;

drop procedure agregarReponsable;
drop procedure eliminarResponsable;
drop procedure actualizarResponsableTef;

