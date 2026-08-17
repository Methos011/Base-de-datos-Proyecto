-- CREACIÓN DE USUARIOS

CREATE USER 'admin_deposito'@'localhost'
IDENTIFIED BY 'Admin123';

CREATE USER 'empleado_ventas'@'localhost'
IDENTIFIED BY 'Ventas123';

CREATE USER 'empleado_productos'@'localhost'
IDENTIFIED BY 'Productos123';

CREATE USER 'empleado_proveedores'@'localhost'
IDENTIFIED BY 'Proveedores123';

CREATE USER 'consultor'@'localhost'
IDENTIFIED BY 'Consultor123';

-- PERMISOS DEL USUARIO: admin_deposito

GRANT SELECT, INSERT, UPDATE, DELETE
ON test.cliente
TO 'admin_deposito'@'localhost';

GRANT EXECUTE
ON PROCEDURE test.agregarCliente      -- Stored Procedures.
TO 'admin_deposito'@'localhost';

-- PERMISOS DEL USUARIO: empleado_ventas
GRANT SELECT, INSERT
ON test.venta
TO 'empleado_ventas'@'localhost';

GRANT EXECUTE
ON PROCEDURE test.insertarVenta        -- Stored Procedures.
TO 'empleado_ventas'@'localhost';

-- PERMISOS DEL USUARIO: empleado_productos
GRANT SELECT, INSERT, UPDATE
ON test.producto
TO 'empleado_productos'@'localhost';

GRANT SELECT
ON test.inventarioProducto         -- Vista
TO 'empleado_productos'@'localhost';

-- PERMISOS DEL USUARIO: empleado_proveedores
GRANT SELECT, INSERT, UPDATE
ON test.proveedor
TO 'empleado_proveedores'@'localhost';

GRANT SELECT
ON test.detalleVentasProducto     -- Vista
TO 'empleado_proveedores'@'localhost';

-- PERMISOS DEL USUARIO: consultor
GRANT SELECT
ON test.detalleVentas            -- Vista
TO 'consultor'@'localhost';

GRANT SELECT
ON test.resumenCompras           -- VIsta
TO 'consultor'@'localhost';