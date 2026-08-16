DELIMITER $ 
	CREATE PROCEDURE insertarVenta(
    in cedClie char(10), 
    in cedResp char(10), 
    in venCantidad int, 
    in venPrecioTotal float, 
    in venFecha datetime, 
    in venFiado bool)
    BEGIN
		DECLARE EXIT HANDLER  FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
		END;
		START TRANSACTION;
		IF NOT EXISTS(select 1 from cliente where cedula = cedClie) then
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error al insertar: El cliente no existe';
		ELSEIF NOT EXISTS(SELECT 1 from responsable where cedula = cedResp) then
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error al insertar: El responsable no existe';
		ELSEIF Length(cedClie) != 10 or Length(cedRespo) != 10 then
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: la cedula del cliente o del responsable no cumple con la longitud esperada';
		ELSEIF venPrecioTotal <= 0 then
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: el precio no puede ser menor que 0';
		ELSE
			INSERT INTO venta(cedulaCliente,cedulaResponsable,cantidad,precioTotal,fecha,esFiado)
			VALUES(cedClie,cedResp,venCantidad,venPrecioTotal,venFecha,venFiado);
			COMMIT;
		END IF;
    END $
DELIMITER ;

DELIMITER $
CREATE PROCEDURE eliminarVenta(in ventaID int)
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
			ROLLBACK;
		END;
        
        START TRANSACTION;
		IF NOT EXISTS(SELECT 1 FROM venta WHERE idVenta = ventaID) then
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: La venta no existe';
		ELSE
			DELETE FROM venta WHERE idVenta = ventaID;
            COMMIT;
		END IF;
	END $	
DELIMITER ;

DELIMITER $
CREATE PROCEDURE actualizarVenta(
in ventaId int, in cedClie char(10), in cedResp char(10), in cantidad int, in venPrecioTotal int, in venFecha datetime, in venFiado bool)
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
			ROLLBACK;
		END;
        START TRANSACTION;
        IF NOT EXISTS(SELECT 1 FROM venta WHERE idVenta = ventaID) then
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: La venta no existe';
		ELSEIF NOT EXISTS(select 1 from cliente where cedula = cedClie) then
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error al insertar: El cliente no existe';
		ELSEIF NOT EXISTS(SELECT 1 from responsable where cedula = cedResp) then
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error al insertar: El responsable no existe';
		ELSEIF Length(cedClie) != 10 or Length(cedRespo) != 10 then
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: la cedula del cliente o del responsable no cumple con la longitud esperada';
		ELSEIF venPrecioTotal <= 0 then
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: el precio no puede ser menor que 0';
		ELSE
			UPDATE venta 
            SET cedulaCliente = cedClie, cedulaResponsable = cedResp, cantidad= venCantidad, 
            precioTotal = venPrecioTotal, fecha = venFecha, esFiado = venFiado
            where idVenta = ventaID;
            COMMIT;
		END IF;
	END $
DELIMITER ;