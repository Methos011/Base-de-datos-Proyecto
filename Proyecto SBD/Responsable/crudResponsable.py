from conexion import conectar

def mostrar_responsables():
    bd = conectar()
    cursor = bd.cursor()

    cursor.execute("SELECT * FROM responsable")
    responsables = cursor.fetchall()

    print("\n========================= LISTA DE RESPONSABLES =========================")
    print(f"{'CEDULA':<15}{'NOMBRE':<20}{'APELLIDO':<20}{'TELEFONO':<15}")
    print("-" * 70)

    for resp in responsables:
        # resp[0]=cedula, resp[1]=nombre, resp[2]=apellido, resp[3]=telefono
        print(f"{resp[0]:<15}{resp[1]:<20}{resp[2]:<20}{resp[3]:<15}")

    bd.commit()
    cursor.close()
    bd.close()

def agregar_responsable():
    bd = conectar()
    cursor = bd.cursor()

    cedula = int(input("Ingrese la cedula del responsable: "))
    nombre = input("Ingrese el nombre: ")
    apellido = input("Ingrese el apellido: ")
    telefono = input("Ingrese el numero de telefono: ")

    sql = "INSERT INTO responsable (cedula, nombre, apellido, telefono) VALUES (%s,%s,%s,%s)"
    valores = (cedula, nombre, apellido, telefono)
    cursor.execute(sql, valores)

    bd.commit()
    cursor.close()
    bd.close()
    print("Responsable agregado con exito.")

def eliminar_responsable():
    bd = conectar()
    cursor = bd.cursor()
    
    cedula = int(input("Cedula del responsable a eliminar: "))
    sql = f"DELETE FROM responsable WHERE cedula = {cedula}"
    cursor.execute(sql)

    bd.commit()
    cursor.close()
    bd.close()
    print("Responsable eliminado.")

def actualizar_telefono_responsable():
    bd = conectar()
    cursor = bd.cursor()

    cedula = int(input("Ingrese la cedula del responsable: "))
    nuevo_telefono = input("Ingrese el nuevo numero telefonico: ")
    
    sql = f"UPDATE responsable SET telefono = '{nuevo_telefono}' WHERE cedula = {cedula}"
    cursor.execute(sql)

    bd.commit()
    cursor.close()
    bd.close()
    print("Telefono actualizado con exito.")
