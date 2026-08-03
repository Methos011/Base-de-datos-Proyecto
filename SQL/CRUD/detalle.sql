  -- CRUD TABLA detalle
-- CREATE/INSERT
CREATE TABLE Detalle (
    idVenta INT ,
    idProducto INT,
    Cantidad INT NOT NULL,
    PrecioUnitario FLOAT NOT NULL,
    Subtotal FLOAT NOT NULL,

    PRIMARY KEY (idVenta, idProducto),
    FOREIGN KEY (idVenta)
	REFERENCES Venta(idVenta),

    FOREIGN KEY (idProducto)
	REFERENCES Producto(idProducto)
);

INSERT INTO Detalle (idVenta, idProducto, Cantidad, PrecioUnitario, Subtotal)
VALUES (1,5,3,1.50,4.50);

-- UPDATE
UPDATE Detalle
SET Cantidad = 5
WHERE idVenta = 1 AND idProducto = 5;

-- READ
SELECT * 
FROM Detalle;

SELECT * 
FROM Detalle 
WHERE idVenta = 1;

-- DELETE
DELETE FROM Detalle 
WHERE idVenta = 1 AND idProducto = 5;

DELETE FROM Detalle
WHERE idVenta = 1;
