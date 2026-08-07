-- CRUD tabla proveedor
-- create e insert

CREATE TABLE proveedor(
    idProveedor INT AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    RUC CHAR(13) UNIQUE NOT NULL,
    telefono CHAR(10) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    ciudad VARCHAR(20) NOT NULL,
    PRIMARY KEY(idProveedor)
);

INSERT INTO proveedor (nombre, RUC, telefono, correo, direccion, ciudad)
VALUES ('Distribuidora Alfa', '0999999999001', '0991234567', 'contacto@alfa.com', 'Av. Central 123', 'Guayaquil');

INSERT INTO proveedor (nombre, RUC, telefono, correo, direccion, ciudad)
VALUES ('Comercial Beta', '1799999999001', '0987654321', 'ventas@beta.com', 'Calle Principal 456', 'Quito');


-- READ/consultas
SELECT * FROM proveedor;

SELECT * FROM proveedor
WHERE ciudad = 'Guayaquil';


-- update
UPDATE proveedor
SET telefono = '0990000000', direccion = 'Av. Segunda 789'
WHERE idProveedor = 1;

UPDATE proveedor
SET correo = 'soporte@beta.com'
WHERE idProveedor = 2;


-- delete/ borrar
DELETE FROM proveedor
WHERE idProveedor = 2;
