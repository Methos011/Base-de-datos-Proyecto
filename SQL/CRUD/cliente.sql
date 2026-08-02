-- CRUD tabla cliente
--create e insert

CREATE TABLE cliente(
cedula int not null,
nombre char(50) not null,
apellido char(50) not null,
edad int,
Telefono char(10),
primary key (cedula),
check(edad >18)
);

INSERT INTO cliente (cedula, nombre, apellido, edad, Telefono)
VALUES (1723456789, 'Juan', 'Perez', 25, '0991234567');

INSERT INTO cliente (cedula, nombre, apellido, edad, Telefono)
VALUES (1712345678, 'Maria', 'Gómez', 30, '0987654321');

-- READ/consultas
SELECT * FROM cliente;

SELECT * FROM cliente
WHERE apellido = 'Perez';

-- update
UPDATE cliente
SET Telefono = '0999999999', edad = 26
WHERE cedula = 1723456789;

UPDATE cliente
SET nombre = 'Maria Jose'
WHERE cedula = 1712345678;

-- delete/ borrar
DELETE FROM cliente
WHERE cedula = 1712345678;
