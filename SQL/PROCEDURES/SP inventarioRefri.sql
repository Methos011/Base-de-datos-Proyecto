DELIMITER //

-- 1. INSERTAR PRODUCTO EN REFRIGERADOR
CREATE PROCEDURE insertarProductoRefrigerador(
    IN p_idRefrigerador INT,
    IN p_idProducto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF p_cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La cantidad debe ser mayor a 0';
    ELSEIF NOT EXISTS(SELECT 1 FROM refrigerador WHERE idRefrigerador = p_idRefrigerador) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El refrigerador no existe';
    ELSEIF NOT EXISTS(SELECT 1 FROM producto WHERE idProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El producto no existe';
    ELSEIF EXISTS(SELECT 1 FROM productoRefrigerador WHERE idRefrigerador = p_idRefrigerador AND idProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La asociacion producto-refrigerador ya existe';
    ELSE
        INSERT INTO productoRefrigerador(idRefrigerador, idProducto, cantidad)
        VALUES(p_idRefrigerador, p_idProducto, p_cantidad);
        COMMIT;
    END IF;
END //

-- 2. ACTUALIZAR PRODUCTO EN REFRIGERADOR
CREATE PROCEDURE actualizarProductoRefrigerador(
    IN p_idRefrigerador INT,
    IN p_idProducto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF p_cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La cantidad debe ser mayor a 0';
    ELSEIF NOT EXISTS(SELECT 1 FROM productoRefrigerador WHERE idRefrigerador = p_idRefrigerador AND idProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Registro no encontrado en el refrigerador';
    ELSE
        UPDATE productoRefrigerador
        SET cantidad = p_cantidad
        WHERE idRefrigerador = p_idRefrigerador AND idProducto = p_idProducto;
        COMMIT;
    END IF;
END //

-- 3. ELIMINAR PRODUCTO DE REFRIGERADOR
CREATE PROCEDURE eliminarProductoRefrigerador(
    IN p_idRefrigerador INT,
    IN p_idProducto INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM productoRefrigerador WHERE idRefrigerador = p_idRefrigerador AND idProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Registro no encontrado en el refrigerador';
    ELSE
        DELETE FROM productoRefrigerador 
        WHERE idRefrigerador = p_idRefrigerador AND idProducto = p_idProducto;
        COMMIT;
    END IF;
END //

DELIMITER ;
