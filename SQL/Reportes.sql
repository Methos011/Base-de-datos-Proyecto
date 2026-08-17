-- REPORTE 1: Historial Detallado de Ventas (5 Tablas)
CREATE VIEW detalleVentas as
SELECT 
    v.idVenta AS 'ID Venta',
    v.fecha AS 'Fecha',
    CONCAT(c.nombre, ' ', c.apellido) AS 'Cliente',
    CONCAT(r.nombre, ' ', r.apellido) AS 'Atendido Por (Responsable)',
    p.marca AS 'Producto / Marca',
    p.tipoProducto AS 'Tipo',
    d.Cantidad AS 'Cantidad',
    d.PrecioUnitario AS 'Precio Unitario ($)',
    d.Subtotal AS 'Subtotal ($)',
    IF(v.esFiado = 1, 'Si', 'No') AS 'Es Fiado'
FROM Venta v
INNER JOIN cliente c ON v.cedulaCliente = c.cedula
INNER JOIN responsable r ON v.cedulaResponsable = r.cedula
INNER JOIN Detalle d ON v.idVenta = d.idVenta
INNER JOIN producto p ON d.idProducto = p.idProducto
ORDER BY v.fecha DESC;

-- REPORTE 2: Inventario de Productos por Proveedor y Refrigerador (4 Tablas)
CREATE VIEW inventarioProducto as
SELECT 
    p.idProducto AS 'ID Producto',
    p.marca AS 'Marca / Producto',
    p.tipoProducto AS 'Presentacion',
    prov.nombre AS 'Proveedor',
    prov.telefono AS 'Telefono Proveedor',
    ref.nombre AS 'Ubicacion Refrigerador',
    pr.cantidad AS 'Stock en Refrigerador'
FROM producto p
INNER JOIN proveedor prov ON p.idProveedor = prov.idProveedor
INNER JOIN productoRefrigerador pr ON p.idProducto = pr.idProducto
INNER JOIN refrigerador ref ON pr.idRefrigerador = ref.idRefrigerador
ORDER BY prov.nombre ASC, p.marca ASC;

-- REPORTE 3: Resumen de Compras por Cliente y Responsable (4 Tablas)
CREATE VIEW resumenCompras as
SELECT 
    c.cedula AS 'Cedula Cliente',
    CONCAT(c.nombre, ' ', c.apellido) AS 'Nombre Cliente',
    c.Telefono AS 'Telefono Cliente',
    CONCAT(r.nombre, ' ', r.apellido) AS 'Responsable Frecuente',
    COUNT(DISTINCT v.idVenta) AS 'Total Transacciones',
    SUM(d.Cantidad) AS 'Total Unidades Compradas',
    SUM(d.Subtotal) AS 'Monto Total Gastado ($)'
FROM cliente c
INNER JOIN Venta v ON c.cedula = v.cedulaCliente
INNER JOIN responsable r ON v.cedulaResponsable = r.cedula
INNER JOIN Detalle d ON v.idVenta = d.idVenta
GROUP BY c.cedula, c.nombre, c.apellido, c.Telefono, r.nombre, r.apellido
ORDER BY `Monto Total Gastado ($)` DESC;

-- REPORTE 4: Desglose de Ventas por Producto y Proveedor (5 Tablas)
CREATE VIEW detalleVentasProducto as
SELECT 
    prov.nombre AS 'Proveedor',
    p.marca AS 'Marca Producto',
    p.tipoProducto AS 'Tipo',
    CONCAT(r.nombre, ' ', r.apellido) AS 'Vendido por (Responsable)',
    SUM(d.Cantidad) AS 'Unidades Vendidas',
    SUM(d.Subtotal) AS 'Ingreso Generado ($)'
FROM proveedor prov
INNER JOIN producto p ON prov.idProveedor = p.idProveedor
INNER JOIN Detalle d ON p.idProducto = d.idProducto
INNER JOIN Venta v ON d.idVenta = v.idVenta
INNER JOIN responsable r ON v.cedulaResponsable = r.cedula
GROUP BY prov.nombre, p.marca, p.tipoProducto, r.nombre, r.apellido
ORDER BY `Ingreso Generado ($)` DESC;
