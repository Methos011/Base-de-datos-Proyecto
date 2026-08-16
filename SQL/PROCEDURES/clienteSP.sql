DELIMITER //
CREATE PROCEDURE agregarCliente(in clieCed char(10), in clieNombre char(50), in clieApellido char(50),
 in clieEdad int, in clieTelef char(10))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;
    
	START TRANSACTION;
	IF length(clieCed) != 10 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La longitd de la cedula no es la esperada';
    ELSEIF clieEdad < 18 THEN    
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Es mejor de edad';
	ELSEIF EXISTS(SELECT 1 FROM cliente WHERE cedula = clieCed) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: el cliente ya existe';
    ELSE
		INSERT INTO cliente(cedula,nombre,apellido,edad,telefono)
        VALUES(clieCed,clieNombre,clieApellido,clieEdad,clieTelef);
        COMMIT;
	END IF;
END //
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE eliminarCliente(in clieCed char(10))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
    START TRANSACTION;
	IF EXISTS(SELECT 1 FROM cliente WHERE cedula = clieCed) > 0 then
		DELETE FROM cliente
        WHERE cedula = clieCed;
        COMMIT;
	ELSE 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'error al eliminar el cliente';
	END IF;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE actualizarCliente(in clieCed char(10), in clieNombre char(50), in clieApellido char(50),
 in clieEdad int, in clieTelef char(10))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;
	START TRANSACTION;
	IF LENGTH(clieTelef) = 10 and LENGTH(clieCed) = 10 then
		UPDATE cliente 
        SET 
			nombre = clieNombre,
            apellido = clieApellido,
            edad = clieEdad,
            Telefono = clieTelef
		WHERE cedula = clieCed;
        COMMIT;
	ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al actualizar el numero del cliente';
	END IF;
END $$
DELIMITER ;
