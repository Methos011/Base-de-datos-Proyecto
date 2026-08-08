from conexion import conectar

def mostrar_proveedores():
    bd = conectar()
    cursor = bd.cursor()

    cursor.execute("SELECT * FROM proveedor")
    proveedores = cursor.fetchall()

    print("\n========== PROVEEDORES ==========")
    print(f"{'ID':<5}{'NOMBRE':<25}{'RUC':<15}{'CORREO':<25}{'CIUDAD':<15}")
    print("-" * 80)

    for prov in proveedores:
        # prov[0]=idProveedor, prov[1]=nombre, prov[2]=RUC, prov[4]=correo, prov[6]=ciudad
        print(f"{prov[0]:<5}{prov[1]:<25}{prov[2]:<15}{prov[4]:<25}{prov[6]:<15}")

    bd.commit()
    cursor.close()
    bd.close()

def agregar_proveedor():
    bd = conectar()
    cursor = bd.cursor()

    # Entradas de datos
    nombre = input("Ingrese el nombre del proveedor: ")
    ruc = input("Ingrese el RUC: ")
    telefono = input("Ingrese el telefono: ")
    correo = input("Ingrese el correo: ")
    direccion = input("Ingrese la direccion: ")
    ciudad = input("Ingrese la ciudad: ")

    sql = "INSERT INTO proveedor (nombre, RUC, telefono, correo, direccion, ciudad) VALUES (%s,%s,%s,%s,%s,%s)"
    valores = (nombre, ruc, telefono, correo, direccion, ciudad)
    cursor.execute(sql, valores)

    bd.commit()
    cursor.close()
    bd.close()
    print("Proveedor agregado con exito.")

def eliminar_proveedor():
    bd = conectar()
    cursor = bd.cursor()
    
    id_prov = int(input("ID del proveedor a eliminar: "))
    sql = f"DELETE FROM proveedor WHERE idProveedor = {id_prov}"
    cursor.execute(sql)

    bd.commit()
    cursor.close()
    bd.close()
    print("Proveedor eliminado.")

def actualizar_correo_proveedor():
    bd = conectar()
    cursor = bd.cursor()

    id_prov = int(input("Ingrese el ID del proveedor: "))
    nuevo_correo = input("Ingrese el nuevo correo electronico: ")
    
    sql = f"UPDATE proveedor SET correo = '{nuevo_correo}' WHERE idProveedor = {id_prov}"
    cursor.execute(sql)

    bd.commit()
    cursor.close()
    bd.close()
    print("Correo actualizado con exito.")
