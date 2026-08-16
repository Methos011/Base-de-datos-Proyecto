-- TRIGGER DE CALCULAR SUBTOTAL EN LA TABLA DETALLE
DELIMITER //
CREATE TRIGGER trg_Calcular_subtotal BEFORE INSERT
on detalle
FOR EACH ROW
BEGIN 
	SET new.Subtotal = new.Cantidad * new.PrecioUnitario;
END //
DELIMITER ;


-- trigger para verificar la venta de hacer una venta
DELIMITER $$
CREATE TRIGGER trg_verificar_stock BEFORE INSERT
ON detalle
for each row
BEGIN
	declare stock_actual int;
    select cantidad into stock_actual
    from producto where idProducto = New.idProducto;
    IF stock_actual - new.Cantidad < 0 then
		Signal sqlstate '45000' set message_text = 'El stock no puede ser negativo';
	END IF;
END $$
DELIMITER ;


-- trigger para descontar el inventario
DELIMITER $$
CREATE TRIGGER trg_descontar_inventario BEFORE INSERT on detalle
FOR EACH ROW
BEGIN
	UPDATE producto set cantidad = cantidad - new.Cantidad
    where idProducto = new.idProducto;
END;
DELIMITER ;

-- trigger para añadir producto al refrigerador
DELIMITER $$
CREATE TRIGGER trg_añadirProd_refrigerador AFTER INSERT ON refrigerador
for each row
BEGIN 
		declare capacidad_max int;
        declare capacidad_actual int;

        select capacidad into capacidad_max from refrigerador where idRefrigerador = NEW.idRefrigerador;
        select cantidad into capacidad_actual from productorefrigerador where idRefrigerador = New.idRefrigerador;
        
        IF cantidad_actual + NEW.cantidad > capacidad_max then
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede rebasar la cantidad maxima';
		ELSE 
			UPDATE productoRefrigerador set cantidad_actual = cantidad_actual + new.cantidad 
            where idRefrigerador = new.idRefrigerador;		
		END IF;
END $$
Delimiter ;
