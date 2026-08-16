-- 1. INSERTAR PRODUCTO REFRIGERADOR
DELIMITER $$
CREATE PROCEDURE insertarProductoRefrigerador(
    IN p_idRefrigerador INT,
    IN p_idProducto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM Refrigerador WHERE IdRefrigerador = p_idRefrigerador) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El refrigerador no existe';
    ELSEIF NOT EXISTS(SELECT 1 FROM Producto WHERE IdProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El producto no existe';
    ELSEIF EXISTS(SELECT 1 FROM ProdcutoRefrigerador WHERE IdRefrigerador = p_idRefrigerador AND IdProducto = p_idProducto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La asociación producto-refrigerador ya existe';
    ELSE
        INSERT INTO ProdcutoRefrigerador(IdRefrigerador, IdProducto, Cantidad)
        VALUES(p_idRefrigerador, p_idProducto, p_cantidad);
        COMMIT;
    END IF;
END $$
DELIMITER ;

-- 2. ACTUALIZAR PRODUCTO REFRIGERADOR
DELIMITER $$
CREATE PROCEDURE actualizarProductoRefrigerador(
    IN p_idRefrigerador INT,
    IN p_idProducto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF EXISTS(SELECT 1 FROM ProdcutoRefrigerador WHERE IdRefrigerador = p_idRefrigerador AND IdProducto = p_idProducto) THEN
        UPDATE ProdcutoRefrigerador
        SET Cantidad = p_cantidad
        WHERE IdRefrigerador = p_idRefrigerador AND IdProducto = p_idProducto;
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Registro no encontrado en el refrigerador';
    END IF;
END $$
DELIMITER ;

-- 3. ELIMINAR PRODUCTO REFRIGERADOR
DELIMITER $$
CREATE PROCEDURE eliminarProductoRefrigerador(
    IN p_idRefrigerador INT,
    IN p_idProducto INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    IF EXISTS(SELECT 1 FROM ProdcutoRefrigerador WHERE IdRefrigerador = p_idRefrigerador AND IdProducto = p_idProducto) THEN
        DELETE FROM ProdcutoRefrigerador 
        WHERE IdRefrigerador = p_idRefrigerador AND IdProducto = p_idProducto;
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Registro no encontrado en el refrigerador';
    END IF;
END $$
DELIMITER ;