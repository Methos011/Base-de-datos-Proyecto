DELIMITER //

-- Procedimiento: Agregar Refrigerador
CREATE PROCEDURE agregarRefrigerador(
    IN refriNombre VARCHAR(50), 
    IN refriCapacidadBotella INT, 
    IN refriCapacidadLata INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF refriCapacidadBotella < 0 OR refriCapacidadLata < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Las capacidades deben ser mayores o iguales a 0';
    ELSE
        INSERT INTO refrigerador(nombre, capacidadBotellas, capacidadLatas)
        VALUES (refriNombre, refriCapacidadBotella, refriCapacidadLata);
        COMMIT;
    END IF;
END //

-- Procedimiento: Eliminar Refrigerador
CREATE PROCEDURE eliminarRefrigerador(
    IN refriId INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM refrigerador WHERE idRefrigerador = refriId) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El refrigerador a eliminar no existe';
    ELSE
        DELETE FROM refrigerador 
        WHERE idRefrigerador = refriId;
        COMMIT;
    END IF;
END //

-- Procedimiento: Actualizar Refrigerador
CREATE PROCEDURE actualizarRefrigerador(
    IN refriId INT, 
    IN refriNombre VARCHAR(50), 
    IN refriCapacidadBotella INT, 
    IN refriCapacidadLata INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM refrigerador WHERE idRefrigerador = refriId) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El refrigerador a actualizar no existe';
    ELSEIF refriCapacidadBotella < 0 OR refriCapacidadLata < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Las capacidades deben ser mayores o iguales a 0';
    ELSE
        UPDATE refrigerador 
        SET 
            nombre = refriNombre, 
            capacidadBotellas = refriCapacidadBotella, 
            capacidadLatas = refriCapacidadLata
        WHERE idRefrigerador = refriId;
        COMMIT;
    END IF;
END //

DELIMITER ;
