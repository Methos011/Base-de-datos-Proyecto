-- CRUD para la tabla producto
-- CREATE/INSERT
CREATE TABLE producto(
idProducto int auto_increment,
marca Varchar(45) not null,
tipoProducto enum('Botella','Lata') not null,
presentacion enum('Jaba','Sixpack','Caja','Unidad') default null,
cantidad int not null check(cantidad > 0),
retornable boolean not null,
precio float not null check(precio > 0),
valorGarantia float default null check(valorGarantia > 0),
primary key (idProducto)
);

INSERT INTO producto(marca, tipoProducto,cantidad,retornable, precio)
VALUES('Heineken','Lata',12,FALSE,1.50);

INSERT INTO producto(marca, tipoProducto,presentacion,cantidad,retornable, precio)
VALUES('Corona','Botella','Unidad',20,FALSE,2.00);

INSERT INTO producto(marca, tipoProducto,presentacion,cantidad,retornable, precio,valorGarantia)
VALUES('Pilsener','Botella','JABA',10,TRUE,17.00,6.00);

-- READ/CONSULTAS
SELECT * 
FROM producto;

SELECT * 
FROM producto 
WHERE tipoProducto like 'Botella';

-- UPDATE
UPDATE producto
SET precio = 1.00, cantidad = 30
WHERE idProducto = 1;

UPDATE producto
SET precio = 2.00, cantidad = 15
WHERE idProducto = 2;

-- DELETE/Borrar productos
DELETE FROM producto
WHERE idProducto = 3;
