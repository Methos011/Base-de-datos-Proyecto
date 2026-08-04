from conexion import conectar
from datetime import date

def mostrar_ventas():
    bd = conectar()
    cursor = bd.cursor()

    consulta = "SELECT * FROM VENTA"

    cursor.execute(consulta)

    ventas = cursor.fetchall()

    print("\n======================================= VENTAS ==============================")
    print(f"{'ID':<5}{'CLIENTE':<20}{'PRODUCTO':<15}{'CANT.':<8}{'TOTAL':<10}{'FECHA':<12}")
    print("-" * 70)

    for venta in ventas:
        print(
            f"{venta[0]:<5}"
            f"{venta[1]:<20}"
            f"{venta[2]:<15}"
            f"{venta[3]:<8}"
            f"${venta[4]:<10}"
            f"{venta[5]:<12}"
        ) 

    cursor.close()
    bd.close()
    

def registrar_venta():
    bd = conectar()
    cursor = bd.cursor()
    
    # Entrada de datos
    idVenta = 0
    idProducto = int(input("Ingrese la id del producto: "))
    
    cedulaCliente = int(input("ingrese la cedula del cliente: "))
    cedulaResponsable = int(input("Ingrese la cedula del encargado: "))
    cantidad = int(input("Ingrese la cantidad de la compra: "))
    precioTotal = 10
    fecha = date.today()
    
    print("Presione 1 si es fiado, presione 0 si fue pagado")
    opcion_fiado = int(input("Indique si es fiado o no: "))
    
    if opcion_fiado == 1:
        esFiado = True
    elif opcion_fiado == 0:
        esFiado = False
    else:
        print("Opción incorrecta.")
        cursor.close()
        bd.close()
        return
    
    
    sql = """INSERT INTO VENTA(idVenta,idProducto, cedulaCliente, cedulaResponsable, cantidad, precioTotal, fecha, esFiado) 
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""
    values = (idVenta,idProducto,cedulaCliente,cedulaResponsable,cantidad,precioTotal,fecha,opcion_fiado)
    
    cursor.execute(sql,values)
    
    
    bd.commit()
    bd.close()
    cursor.close()
    


