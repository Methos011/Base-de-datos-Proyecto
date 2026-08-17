DELIMITER //

-- Procedimiento: Insertar Venta
CREATE PROCEDURE insertarVenta(
    IN cedClie CHAR(10), 
    IN cedResp CHAR(10), 
    IN venCantidad INT, 
    IN venPrecioTotal FLOAT, 
    IN venFecha DATETIME, 
    IN venFiado BOOLEAN
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF LENGTH(cedClie) != 10 OR LENGTH(cedResp) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cedula del cliente o del responsable debe tener 10 caracteres';
    ELSEIF venCantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cantidad debe ser mayor a 0';
    ELSEIF venPrecioTotal <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El precio total debe ser mayor a 0';
    ELSEIF NOT EXISTS(SELECT 1 FROM cliente WHERE cedula = cedClie) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al insertar: El cliente no existe';
    ELSEIF NOT EXISTS(SELECT 1 FROM responsable WHERE cedula = cedResp) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al insertar: El responsable no existe';
    ELSE
        INSERT INTO venta(cedulaCliente, cedulaResponsable, cantidad, precioTotal, fecha, esFiado)
        VALUES(cedClie, cedResp, venCantidad, venPrecioTotal, venFecha, venFiado);
        COMMIT;
    END IF;
END //

-- Procedimiento: Eliminar Venta
CREATE PROCEDURE eliminarVenta(
    IN ventaID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM venta WHERE idVenta = ventaID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La venta a eliminar no existe';
    ELSE
        DELETE FROM venta WHERE idVenta = ventaID;
        COMMIT;
    END IF;
END //

-- Procedimiento: Actualizar Venta
CREATE PROCEDURE actualizarVenta(
    IN ventaID INT, 
    IN cedClie CHAR(10), 
    IN cedResp CHAR(10), 
    IN venCantidad INT, 
    IN venPrecioTotal FLOAT, 
    IN venFecha DATETIME, 
    IN venFiado BOOLEAN
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM venta WHERE idVenta = ventaID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La venta a actualizar no existe';
    ELSEIF LENGTH(cedClie) != 10 OR LENGTH(cedResp) != 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cedula del cliente o del responsable debe tener 10 caracteres';
    ELSEIF venCantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cantidad debe ser mayor a 0';
    ELSEIF venPrecioTotal <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El precio total debe ser mayor a 0';
    ELSEIF NOT EXISTS(SELECT 1 FROM cliente WHERE cedula = cedClie) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al actualizar: El cliente no existe';
    ELSEIF NOT EXISTS(SELECT 1 FROM responsable WHERE cedula = cedResp) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error al actualizar: El responsable no existe';
    ELSE
        UPDATE venta 
        SET 
            cedulaCliente = cedClie, 
            cedulaResponsable = cedResp, 
            cantidad = venCantidad, 
            precioTotal = venPrecioTotal, 
            fecha = venFecha, 
            esFiado = venFiado
        WHERE idVenta = ventaID;
        COMMIT;
    END IF;
END //

DELIMITER ;
