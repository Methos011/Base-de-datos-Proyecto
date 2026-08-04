from conexion import conectar

def mostrar_clientes():
    bd = conectar()
    cursor = bd.cursor()

    cursor.execute("SELECT * FROM cliente")

    clientes = cursor.fetchall()

    print("\n========== CLIENTES ==========")
    print(f"{'CEDULA':<15}{'NOMBRE':<25}{'TELEFONO':<15}")
    print("-" * 55)

    for cliente in clientes:
        print(f"{cliente[0]:<15}{cliente[1]:<25}{cliente[4]:<15}")
        
    bd.commit()
    cursor.close()
    bd.close()
    
def agregar_cliente():
    
    bd = conectar()
    cursor = bd.cursor()
    
    # Entradas de datos
    cedula = input("Ingrese la cedula: ")
    nombre = input("Ingrese el nombre: ")
    apellido = input("Ingrese el apellido: ")
    edad = int(input("Ingrese la edad: "))  
    telefono = input("Ingrese el numero telefonico: ")
    
    sql = "INSERT INTO cliente (cedula, nombre, apellido, edad, telefono) VALUES (%s,%s,%s,%s,%s)"
    valores = (cedula, nombre, apellido, edad, telefono)
    cursor.execute(sql,valores)
    
    bd.commit()
    cursor.close()
    bd.close()
        
    
def eliminar_cliente():
    
    bd = conectar()
    cursor = bd.cursor()
    cedula = int(input("Cedula del cliente a eliminar: "))
    sql = (f"DELETE FROM CLIENTE WHERE cedula = {cedula}")
    cursor.execute(sql)
    
    bd.commit()
    cursor.close()
    bd.close()
    
def actualizar_numero_cliente():
    bd = conectar()
    cursor = bd.cursor()
    cedula = int(input("Ingrese la cedula del cliente: "))
    numero = int(input("Ingrese el nuevo numero telefonico: "))
    sql = (f"UPDATE CLIENTE SET telefono = {numero} WHERE cedula = {cedula}")
    cursor.execute(sql)
    
    bd.commit()
    cursor.close()
    bd.close()
        
    
        