 
create index nombrecompleto on cliente(nombre,apellido);

create index ind_telefono on cliente(telefono);

create index ind_fechaventa on venta(fecha);

create index ind_ventacliente on venta(cedula);

create index ind_marcatipo on producto(marca,tipoproducto);
