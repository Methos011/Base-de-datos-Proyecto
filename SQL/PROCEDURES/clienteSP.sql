DELIMITER //

-- Procedimiento: Agregar Cliente
CREATE PROCEDURE agregarCliente(
    IN clieCed CHAR(10), 
    IN clieNombre VARCHAR(50), 
    IN clieApellido VARCHAR(50),
    IN clieEdad INT, 
    IN clieTelef CHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF LENGTH(clieCed) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La longitud de la cedula debe ser de 10 caracteres';
    ELSEIF clieEdad < 18 THEN    
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El cliente es menor de edad';
    ELSEIF EXISTS(SELECT 1 FROM cliente WHERE cedula = clieCed) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El cliente ya existe';
    ELSE
        INSERT INTO cliente(cedula, nombre, apellido, edad, telefono)
        VALUES (clieCed, clieNombre, clieApellido, clieEdad, clieTelef);
        COMMIT;
    END IF;
END //

-- Procedimiento: Eliminar Cliente
CREATE PROCEDURE eliminarCliente(
    IN clieCed CHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF EXISTS(SELECT 1 FROM cliente WHERE cedula = clieCed) THEN
        DELETE FROM cliente
        WHERE cedula = clieCed;
        COMMIT;
    ELSE 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El cliente a eliminar no existe';
    END IF;
END //

-- Procedimiento: Actualizar Cliente
CREATE PROCEDURE actualizarCliente(
    IN clieCed CHAR(10), 
    IN clieNombre VARCHAR(50), 
    IN clieApellido VARCHAR(50),
    IN clieEdad INT, 
    IN clieTelef CHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM cliente WHERE cedula = clieCed) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El cliente a actualizar no existe';
    ELSEIF LENGTH(clieCed) != 10 OR LENGTH(clieTelef) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La longitud de la cedula o telefono debe ser de 10 caracteres';
    ELSEIF clieEdad < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El cliente debe ser mayor de edad';
    ELSE
        UPDATE cliente 
        SET 
            nombre = clieNombre,
            apellido = clieApellido,
            edad = clieEdad,
            telefono = clieTelef
        WHERE cedula = clieCed;
        COMMIT;
    END IF;
END //

DELIMITER ; 
	END IF;
END $$
DELIMITER ;
