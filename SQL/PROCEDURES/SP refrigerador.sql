DELIMITER $
CREATE PROCEDURE agregarRefrigerador(in refriNombre varchar(50), in refriCapacidadBotella int, in refriCapacidadLata int)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
    
    START TRANSACTION;
		INSERT INTO refrigerador(nombre,capacidadBotellas,capcidadLatas)
		VALUES(refriNombre,refriCapacidadBotella,refriCapacidadLata);
		COMMIT;    
END $
DELIMITER ;

DELIMITER $
CREATE PROCEDURE eliminarRefrigerador(in RefriId int)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
    
    START TRANSACTION;
    IF	(select count(*) from refrigerador where idRefrigerador = RefriId) = 0 then
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El refrigerador no existe';
    ELSE    
		DELETE FROM refrigerador where idRefrigerador = RefriId;
        COMMIT;
	END IF;
END $
DELIMITER ;

DELIMITER $
CREATE PROCEDURE actualizarRefrigerador(in refriId int ,in refriNombre varchar(50), 
in refriCapacidadBotella int, in refriCapacidadLata int)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
    
    START TRANSACTION;
    IF	(select count(*) from refrigerador where idRefrigerador = RefriId) = 0 then
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El refrigerador no existe';
	ELSE 
		UPDATE refrigerador set nombre = refriNombre, capacidadBotellas = refriCapacidadBotella,
        capacidadLata = refriCapacidadLata;
        COMMIT;
	END IF;
END $
DELIMITER ;