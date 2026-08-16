DELIMITER //
CREATE PROCEDURE agregarCliente(in ced char(10), in nombre char(50), in apellido char(50), in edad int, in telefono char(10))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;
    
	START TRANSACTION;
	IF (length(ced) = 10 and edad > 18) and ((SELECT COUNT(*) FROM cliente WHERE cedula = ced) = 0) then
		INSERT INTO cliente(cedula,nombre,apellido,edad,telefono)
        VALUES(ced,nombre,apellido,edad,telefono);
        COMMIT;
	ELSE
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'se originó un error';
	END IF;
END //
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE eliminarCliente(in ced char(10))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
    START TRANSACTION;
	IF (SELECT COUNT(*) FROM cliente WHERE cedula = ced) > 0 then
		DELETE FROM cliente
        WHERE cedula = ced;
        COMMIT;
	ELSE 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'error al eliminar el cliente';
	END IF;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE actualizarCliente(in ced char(10),in telf char(10))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;
        
	START TRANSACTION;
	IF LENGTH(telf) = 10 and LENGTH(ced) = 10 then
		UPDATE cliente set Telefono = telf where cedula = ced;
        COMMIT;
	ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al actualizar el numero del cliente';
	END IF;
END $$
DELIMITER ;
