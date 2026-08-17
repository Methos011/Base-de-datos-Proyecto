DELIMITER //

-- Procedimiento: Insertar Producto
CREATE PROCEDURE insertarProducto(
    IN idProv INT, 
    IN prodMarca VARCHAR(45),
    IN prodTipo ENUM('Botella', 'Lata'), 
    IN prodPresen ENUM('Jaba', 'Sixpack', 'Caja', 'Unidad'), 
    IN prodCant INT, 
    IN prodRetor BOOLEAN,
    IN prodPrecio FLOAT, 
    IN prodGarantia FLOAT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT 1 FROM proveedor WHERE idProveedor = idProv) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El proveedor no existe';
    ELSEIF prodTipo NOT IN ('Botella', 'Lata') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Tipo de producto incorrecto';
    ELSEIF prodPresen NOT IN ('Jaba', 'Sixpack', 'Caja', 'Unidad') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Tipo de presentacion incorrecta';
    ELSEIF prodPrecio <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El precio debe ser mayor a 0';
    ELSEIF prodCant <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cantidad debe ser mayor a 0';
    ELSEIF prodGarantia < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El valor de garantia no puede ser negativo';
    ELSE
        INSERT INTO producto(idProveedor, marca, tipoProducto, presentacion, cantidad, retornable, precio, valorGarantia)
        VALUES (idProv, prodMarca, prodTipo, prodPresen, prodCant, prodRetor, prodPrecio, prodGarantia);
        COMMIT;
    END IF;
END //

-- Procedimiento: Eliminar Producto
CREATE PROCEDURE eliminarProducto(
    IN prodId INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM producto WHERE idProducto = prodId) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El producto a eliminar no existe';
    ELSE
        DELETE FROM producto WHERE idProducto = prodId;
        COMMIT;
    END IF;
END //

-- Procedimiento: Actualizar Producto
CREATE PROCEDURE actualizarProducto(
    IN prodId INT,
    IN idProv INT, 
    IN prodMarca VARCHAR(45),
    IN prodTipo ENUM('Botella', 'Lata'), 
    IN prodPresen ENUM('Jaba', 'Sixpack', 'Caja', 'Unidad'), 
    IN prodCantidad INT,
    IN prodRetor BOOLEAN,
    IN prodPrecio FLOAT, 
    IN prodGarantia FLOAT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM producto WHERE idProducto = prodId) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El producto a actualizar no existe';
    ELSEIF NOT EXISTS(SELECT 1 FROM proveedor WHERE idProveedor = idProv) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El proveedor no existe';
    ELSEIF prodTipo NOT IN ('Botella', 'Lata') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Tipo de producto incorrecto';
    ELSEIF prodPresen NOT IN ('Jaba', 'Sixpack', 'Caja', 'Unidad') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Tipo de presentacion incorrecta';
    ELSEIF prodPrecio <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El precio debe ser mayor a 0';
    ELSEIF prodCantidad <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cantidad debe ser mayor a 0';
    ELSEIF prodGarantia < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El valor de garantia no puede ser negativo';
    ELSE
        UPDATE producto 
        SET 
            idProveedor = idProv, 
            marca = prodMarca, 
            tipoProducto = prodTipo, 
            presentacion = prodPresen, 
            cantidad = prodCantidad, 
            retornable = prodRetor,
            precio = prodPrecio, 
            valorGarantia = prodGarantia
        WHERE idProducto = prodId;
        COMMIT;
    END IF;
END //

DELIMITER ;
