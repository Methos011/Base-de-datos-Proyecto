from conexion import conectar

def mostrar_prod_refrigerador():
    bd = conectar()
    cursor = bd.cursor()

    consulta = "SELECT idProducto, idRefrigerador, cantidad FROM productoRefrigerador"
    cursor.execute(consulta)
    registros = cursor.fetchall()

    print("\n===============================================")
    print("         PRODUCTOS EN REFRIGERADORES           ")
    print("===============================================")
    print(f"{'ID PRODUCTO':<15}{'ID REFRIGERADOR':<18}{'CANTIDAD':<10}")
    print("-" * 45)

    for reg in registros:
        print(
            f"{str(reg[0]):<15}"
            f"{str(reg[1]):<18}"
            f"{str(reg[2]):<10}"
        ) 

    cursor.close()
    bd.close()

def agregar_prod_refrigerador():
    bd = conectar()
    cursor = bd.cursor()
    
    idProducto = int(input("Ingrese el ID del producto: "))
    idRefrigerador = int(input("Ingrese el ID del refrigerador: "))
    cantidad = int(input("Ingrese la cantidad en este refrigerador: "))
    
    sql = """INSERT INTO productoRefrigerador (idProducto, idRefrigerador, cantidad) 
             VALUES (%s, %s, %s)"""
    values = (idProducto, idRefrigerador, cantidad)
    
    try:
        cursor.execute(sql, values)
        bd.commit()
        print("¡Producto asignado al refrigerador con éxito!")
    except Exception as e:
        print(f"Error al registrar: {e}")
        bd.rollback()
    
    cursor.close()
    bd.close()

def actualizar_prod_refrigerador():
    bd = conectar()
    cursor = bd.cursor()
    
    idProducto = int(input("Ingrese el ID del producto: "))
    idRefrigerador = int(input("Ingrese el ID del refrigerador: "))
    nuevaCantidad = int(input("Ingrese la nueva cantidad: "))
    
    sql = "UPDATE productoRefrigerador SET cantidad = %s WHERE idProducto = %s AND idRefrigerador = %s"
    cursor.execute(sql, (nuevaCantidad, idProducto, idRefrigerador))
    
    bd.commit()
    print("¡Cantidad actualizada con éxito!")
    
    cursor.close()
    bd.close()

def eliminar_prod_refrigerador():
    bd = conectar()
    cursor = bd.cursor()
    
    idProducto = int(input("Ingrese el ID del producto a retirar: "))
    idRefrigerador = int(input("Ingrese el ID del refrigerador: "))
    
    sql = "DELETE FROM productoRefrigerador WHERE idProducto = %s AND idRefrigerador = %s"
    cursor.execute(sql, (idProducto, idRefrigerador))
    
    bd.commit()
    print("¡Registro eliminado del refrigerador con éxito!")
    
    cursor.close()
    bd.close()