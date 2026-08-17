DELIMITER //

-- Procedimiento: Agregar Responsable
CREATE PROCEDURE agregarResponsable(
    IN respCed CHAR(10), 
    IN respNombre VARCHAR(50), 
    IN respApellido VARCHAR(50), 
    IN respTelef CHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF LENGTH(respCed) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La longitud de la cedula debe ser de 10 caracteres';
    ELSEIF LENGTH(respTelef) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La longitud del telefono debe ser de 10 digitos';
    ELSEIF EXISTS(SELECT 1 FROM responsable WHERE cedula = respCed) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El responsable ya existe';
    ELSE
        INSERT INTO responsable(cedula, nombre, apellido, telefono)
        VALUES (respCed, respNombre, respApellido, respTelef);
        COMMIT;
    END IF;
END //

-- Procedimiento: Eliminar Responsable
CREATE PROCEDURE eliminarResponsable(
    IN respCed CHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM responsable WHERE cedula = respCed) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El responsable a eliminar no existe';
    ELSE 
        DELETE FROM responsable 
        WHERE cedula = respCed;
        COMMIT;
    END IF;
END //

-- Procedimiento: Actualizar Responsable
CREATE PROCEDURE actualizarResponsable(
    IN respCed CHAR(10),
    IN respNombre VARCHAR(50), 
    IN respApellido VARCHAR(50), 
    IN respTelef CHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM responsable WHERE cedula = respCed) THEN
        SIGNAL SQLSTATE '45000';
        SET MESSAGE_TEXT = 'Error: El responsable a actualizar no existe';
    ELSEIF LENGTH(respCed) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La longitud de la cedula debe ser de 10 caracteres';
    ELSEIF LENGTH(respTelef) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La longitud del telefono debe ser de 10 digitos';
    ELSE
        UPDATE responsable 
        SET 
            nombre = respNombre,
            apellido = respApellido,
            telefono = respTelef
        WHERE cedula = respCed;
        COMMIT;
    END IF;
END //

DELIMITER ;

