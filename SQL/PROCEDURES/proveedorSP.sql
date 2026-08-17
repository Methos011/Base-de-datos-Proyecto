DELIMITER //

-- Procedimiento: Agregar Proveedor
CREATE PROCEDURE agregarProveedor(
    IN provNombre VARCHAR(60), 
    IN provRuc CHAR(13),
    IN provTef CHAR(10), 
    IN provCorreo VARCHAR(50), 
    IN provDireccion VARCHAR(50), 
    IN provCiudad VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF LENGTH(provRuc) != 13 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El RUC debe tener exactamente 13 caracteres';
    ELSEIF LENGTH(provTef) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El teléfono debe tener exactamente 10 dígitos';
    ELSEIF EXISTS(SELECT 1 FROM proveedor WHERE RUC = provRuc) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El proveedor con este RUC ya existe';		
    ELSE 
        INSERT INTO proveedor(nombre, RUC, telefono, correo, direccion, ciudad)
        VALUES (provNombre, provRuc, provTef, provCorreo, provDireccion, provCiudad);
        COMMIT;
    END IF;
END //

-- Procedimiento: Eliminar Proveedor
CREATE PROCEDURE eliminarProveedor(
    IN provID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    IF NOT EXISTS(SELECT 1 FROM proveedor WHERE idProveedor = provID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El proveedor a eliminar no existe';
    ELSE 
        DELETE FROM proveedor 
        WHERE idProveedor = provID;
        COMMIT;
    END IF;
END //

-- Procedimiento: Actualizar Proveedor
CREATE PROCEDURE actualizarProveedor(
    IN provID INT,
    IN provNombre VARCHAR(60),
    IN provRuc CHAR(13),
    IN provTef CHAR(10), 
    IN provCorreo VARCHAR(50), 
    IN provDireccion VARCHAR(50), 
    IN provCiudad VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    IF NOT EXISTS(SELECT 1 FROM proveedor WHERE idProveedor = provID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El proveedor no existe';
    ELSEIF LENGTH(provRuc) != 13 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El RUC debe tener exactamente 13 caracteres';
    ELSEIF LENGTH(provTef) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El teléfono debe tener exactamente 10 dígitos';
    ELSEIF EXISTS(SELECT 1 FROM proveedor WHERE RUC = provRuc AND idProveedor != provID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El RUC ya pertenece a otro proveedor distinto';
    ELSE 
        UPDATE proveedor
        SET 
            nombre = provNombre, 
            RUC = provRuc, 
            telefono = provTef, 
            correo = provCorreo, 
            direccion = provDireccion, 
            ciudad = provCiudad
        WHERE idProveedor = provID;
        COMMIT;
    END IF;
END //

DELIMITER ;
