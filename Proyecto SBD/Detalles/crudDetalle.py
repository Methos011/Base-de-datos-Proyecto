from conexion import conectar

def mostrar_detalles():
    bd = conectar()
    cursor = bd.cursor()

    consulta = "SELECT idProducto, idVenta, esHelado, Cantidad, PrecioUnitario, Subtotal FROM detalle"
    cursor.execute(consulta)
    detalles = cursor.fetchall()

    print("=====================")
    print("   DETALLES DE VENTAS   ")
    print("=====================")
    print(f"{'ID PROD':<10}{'ID VENTA':<10}{'ES HELADO':<10}{'CANT':<8}{'P.UNIT':<10}{'SUBTOTAL':<12}")
    print("-" * 65)

    for det in detalles:
        # det[2] es esHelado
        es_helado_txt = "Sí" if det[2] else "No"
        print(
            f"{det[0]:<10}" 
            f"{det[1]:<10}"  
            f"{es_helado_txt:<10}" 
            f"{det[3]:<8}"   
            f"${det[4]:<9.2f}"
            f"${det[5]:<11.2f}"
        ) 

    cursor.close()
    bd.close()

def agregar_detalle():
    bd = conectar()
    cursor = bd.cursor()
    
    idVenta = int(input("Ingrese el ID de la venta existente: "))
    idProducto = int(input("Ingrese el ID del producto: "))
    cantidad = int(input("Ingrese la cantidad: "))
    precioUnitario = float(input("Ingrese el precio unitario del producto: "))
    
    # Cálculo automático del subtotal
    precioSubtotal = cantidad * precioUnitario
    
    opcion_helado = input("¿El producto es helado? (Sí / No): ").strip().lower()
    esHelado = True if opcion_helado in ['1', 'si', 's', 'sí'] else False
    
    sql = """INSERT INTO detalle (idVenta, idProducto, Cantidad, PrecioUnitario, Subtotal, esHelado) 
             VALUES (%s, %s, %s, %s, %s, %s)"""
    values = (idVenta, idProducto, cantidad, precioUnitario, precioSubtotal, esHelado)
    
    try:
        cursor.execute(sql, values)
        bd.commit()
        print("¡Detalle agregado con éxito y subtotal calculado!")
    except Exception as e:
        print(f"Error al registrar el detalle: {e}")
        bd.rollback()
    
    cursor.close()
    bd.close()

def eliminar_detalle():
    bd = conectar()
    cursor = bd.cursor()
    
    idVenta = int(input("Ingrese el ID de la venta: "))
    idProducto = int(input("Ingrese el ID del producto a quitar de la venta: "))
    
    sql = "DELETE FROM detalle WHERE idVenta = %s AND idProducto = %s"
    cursor.execute(sql, (idVenta, idProducto))
    
    bd.commit()
    print("¡Detalle eliminado con éxito!")
    
    cursor.close()
    bd.close()