DELIMITER $
CREATE PROCEDURE insertarProducto(in idProv int, in prodMarca varchar(45),
 in prodTipo enum('Botella','Lata'), in prodPresen enum('Jaba','Sixpack','Caja','Unidad'), in prodCant int, in prodRetor bool,
 in prodPrecio float, in prodGarantia float)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
    
    START TRANSACTION;
    IF NOT EXISTS(SELECT 1 FROM proveedor WHERE idProveedor = idProv) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El proveedor no existe';
	ELSEIF prodTipo != 'Botella' OR prodTipo != 'Lata' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Tipo de producto incorrecto';
	ELSEIF prodPresen != 'Jaba' or prodPresen != 'Sixpack' or prodPresen != 'Caja' or prodPresen != 'Unidad' THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Tipo de presentacion incorrecta';
	ELSEIF prodPrecio <= 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: El precio no puede ser menor que 0';
	ELSEIF prodCant <= 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La cantidad no puede ser negativa';
	ELSE
		INSERT INTO producto(idProveedor,marca,tipoProducto,presentacion,cantidad,retornable,precio,valorGarantia)
        VALUES(idProv, prodMarca,prodTipo,prodPresen,prodCant,prodRetor,prodPrecio,prodGarantia);
        COMMIT;
	END IF;
END $
DELIMITER ; 

DELIMITER $
CREATE PROCEDURE eliminarProducto(in prodId int)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
	END;
	
    START TRANSACTION;
	IF NOT EXISTS (SELECT 1 FROM producto WHERE idProducto = prodId) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: el producto no existe';
	ELSE
		DELETE FROM producto WHERE idProducto = prodId;
        COMMIT;
	END IF;
END $
DELIMITER ;

DELIMITER $
CREATE PROCEDURE actualizarProducto(in prodId int,in idProv int, in prodMarca varchar(45),
 in prodTipo enum('Botella','Lata'), in prodPresen enum('Jaba','Sixpack','Caja','Unidad'), in prodCantidad int,
 in prodRetor bool,in prodPrecio float, in prodGarantia float)
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
		END;
        START TRANSACTION;
        IF NOT EXISTS (SELECT 1 FROM producto WHERE idProducto = prodId) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: el producto no existe';
		ELSEIF NOT EXISTS(SELECT 1 FROM proveedor WHERE idProveedor = idProv) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: El proveedor no existe';
		ELSEIF prodTipo != 'Botella' OR prodTipo != 'Lata' THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: Tipo de producto incorrecto';
		ELSEIF prodPresen != 'Jaba' or prodPresen != 'Sixpack' or prodPresen != 'Caja' or prodPresen != 'Unidad' THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: Tipo de presentacion incorrecta';
		ELSEIF prodPrecio <= 0 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: el precio no puede ser menor que 0';
		ELSEIF prodCant <= 0 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: La cantidad no puede ser negativa';
		ELSEIF prodGarantia <= 0 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error: El precio de garantia no puede ser negativo';
		ELSE
			UPDATE producto 
            SET idProducto = prodId, idProveedor = idProv, marca = prodMarca, 
            tipoProducto = prodTipo, presentacion = prodPresen, cantidad = prodCantidad, retornable = prodRetor,
            precio = prodPrecio, valorGarantia = prodGarantia
            WHERE idProducto = prodId;
            COMMIT;
		END IF;
    END $
DELIMITER ;