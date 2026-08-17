
DELIMITER $$
CREATE PROCEDURE insertarDetalle(
    IN p_idProducto INT,
    IN p_idVenta INT,
    IN p_esHelado BOOLEAN,
    IN p_cantidad INT,
    IN p_precioUnitario DECIMAL(10,2)
)
BEGIN
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM Producto WHERE IdProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El producto no existe';
    ELSEIF NOT EXISTS(SELECT 1 FROM Venta WHERE idVenta = p_idVenta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La venta no existe';
    ELSEIF EXISTS(SELECT 1 FROM Detalle WHERE IdProducto = p_idProducto AND IdVenta = p_idVenta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El detalle ya se encuentra registrado';
    ELSE
        INSERT INTO Detalle(IdProducto, IdVenta, EsHelado, Cantidad, PrecioUnitario, Subtotal)
        VALUES(p_idProducto, p_idVenta, p_esHelado, p_cantidad, p_precioUnitario, v_subtotal);
        COMMIT;
    END IF;
END $$
DELIMITER ;

-- 2. ACTUALIZAR DETALLE
DELIMITER $$
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
    END;

    START TRANSACTION;

    IF EXISTS(SELECT 1 FROM Detalle WHERE IdProducto = p_idProducto AND IdVenta = p_idVenta) THEN
        UPDATE Detalle
        SET esHelado = p_esHelado,
            cantidad = p_cantidad,
            precioUnitario = p_precioUnitario,
            subtotal = v_subtotal
        WHERE IdProducto = p_idProducto AND IdVenta = p_idVenta;
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Registro de detalle no encontrado';
    END IF;
END $$
DELIMITER ;

-- 3. ELIMINAR DETALLE
DELIMITER $$
CREATE PROCEDURE eliminarDetalle(
    IN p_idProducto INT,
    IN p_idVenta INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF EXISTS(SELECT 1 FROM Detalle WHERE IdProducto = p_idProducto AND IdVenta = p_idVenta) THEN
        DELETE FROM Detalle 
        WHERE IdProducto = p_idProducto AND IdVenta = p_idVenta;
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Registro de detalle no encontrado';
    END IF;
END $$
DELIMITER ;
