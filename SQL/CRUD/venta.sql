-- CRUD tabla Ventas
-- CREATE/INSERT
CREATE TABLE venta (
idVenta int not null auto_increment,
idProducto int not null,
cedulaCliente int not null,
cedulaResponsable int not null,
cantidad int check(cantidad > 0),
precioSubtotal float,
precioTotal float,
fecha date,
esFiado boolean,
estaHelado boolean,
primary key (idVenta),
foreign key(idProducto) references producto(idProducto),
foreign key(cedulaCliente) references cliente(cedula),
foreign key(cedulaResponsable) references responsable(cedula)
);


INSERT INTO venta(idProducto, cedulaCliente, cedulaResponsable, cantidad, precioSubtotal, precioTotal, fecha, esFiado, estaHelado)
VALUES(1,1723456789,1912345678,2,3.00,3.00,'2026-08-02',FALSE,FALSE);

INSERT INTO venta(idProducto, cedulaCliente, cedulaResponsable,cantidad, precioSubtotal, precioTotal,fecha, esFiado, estaHelado)
VALUES(2,1712345678,1987654321,5,10.00,10.00,'2026-08-03',TRUE,FALSE);

INSERT INTO venta(idProducto, cedulaCliente, cedulaResponsable,cantidad, precioSubtotal, precioTotal,fecha, esFiado, estaHelado)
VALUES(1,1723456789,1987654321,3,4.50,4.50,'2026-08-04',FALSE,TRUE);

-- READ/CONSULTAS
SELECT v.idVenta,c.nombre AS Cliente,p.marca AS Producto,r.nombre AS Responsable,v.cantidad,v.precioTotal,v.fecha
FROM venta v
    JOIN cliente c
    ON v.cedulaCliente = c.cedula
    JOIN producto p
    ON v.idProducto = p.idProducto
    JOIN responsable r
    ON v.cedulaResponsable = r.cedula;

SELECT *
FROM venta
WHERE cedulaCliente = 1723456789;

-- UPDATE
UPDATE venta
SET cantidad = 4, precioSubtotal = 6.00, precioTotal = 6.00
WHERE idVenta = 1;

UPDATE venta
SET esFiado = TRUE, fecha = '2026-08-05'
WHERE idVenta = 2;

-- DELETE/Borrar venta
DELETE FROM venta
WHERE idVenta = 2;
