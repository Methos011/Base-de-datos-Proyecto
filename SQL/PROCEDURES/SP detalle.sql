DELIMITER //

-- 1. INSERTAR DETALLE
CREATE PROCEDURE insertarDetalle(
    IN p_idProducto INT,
    IN p_idVenta INT,
    IN p_esHelado BOOLEAN,
    IN p_cantidad INT,
    IN p_precioUnitario FLOAT
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
    ELSEIF p_precioUnitario <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El precio unitario debe ser mayor a 0';
    ELSEIF NOT EXISTS(SELECT 1 FROM producto WHERE idProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El producto no existe';
    ELSEIF NOT EXISTS(SELECT 1 FROM venta WHERE idVenta = p_idVenta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La venta no existe';
    ELSEIF EXISTS(SELECT 1 FROM detalle WHERE idProducto = p_idProducto AND idVenta = p_idVenta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El detalle ya se encuentra registrado';
    ELSE
        INSERT INTO detalle(idProducto, idVenta, esHelado, cantidad, precioUnitario, subtotal)
        VALUES(p_idProducto, p_idVenta, p_esHelado, p_cantidad, p_precioUnitario, v_subtotal);
        COMMIT;
    END IF;
END //

-- 2. ACTUALIZAR DETALLE
CREATE PROCEDURE actualizarDetalle(
    IN p_idProducto INT,
    IN p_idVenta INT,
    IN p_esHelado BOOLEAN,
    IN p_cantidad INT,
    IN p_precioUnitario FLOAT
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM detalle WHERE idProducto = p_idProducto AND idVenta = p_idVenta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Registro de detalle no encontrado';
    ELSEIF p_cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La cantidad debe ser mayor a 0';
    ELSEIF p_precioUnitario <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El precio unitario debe ser mayor a 0';
    ELSE

        UPDATE detalle
        SET esHelado = p_esHelado,
            cantidad = p_cantidad,
            precioUnitario = p_precioUnitario,
            subtotal = v_subtotal
        WHERE idProducto = p_idProducto AND idVenta = p_idVenta;
        COMMIT;
    END IF;
END //

-- 3. ELIMINAR DETALLE
CREATE PROCEDURE eliminarDetalle(
    IN p_idProducto INT,
    IN p_idVenta INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM detalle WHERE idProducto = p_idProducto AND idVenta = p_idVenta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Registro de detalle no encontrado';
    ELSE
        DELETE FROM detalle 
        WHERE idProducto = p_idProducto AND idVenta = p_idVenta;
        COMMIT;
    END IF;
END //

DELIMITER ;
