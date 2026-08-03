
-- create e insert

CREATE TABLE responsable(
    cedula int not null,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    PRIMARY KEY (cedula)
);

INSERT INTO responsable (cedula, nombre, apellido)
VALUES (1912345678, 'Carlos', 'Mendoza');

INSERT INTO responsable (cedula, nombre, apellido)
VALUES (1987654321, 'Ana', 'Torres');


-- READ/consultas
SELECT * FROM responsable;

SELECT * FROM responsable
WHERE apellido = 'Mendoza';


-- update
UPDATE responsable
SET apellido = 'Mendoza Vera'
WHERE cedula = 1912345678;

UPDATE responsable
SET nombre = 'Ana Maria'
WHERE cedula = 1987654321;


-- delete/ borrar
DELETE FROM responsable
WHERE cedula = 1987654321;
