from conexion import conectar 
def mostrar_refrigeradores(): 
  bd = conectar() 
  cursor = bd.cursor() 
  cursor.execute("SELECT * FROM refrigerador") 
  refrigeradores = cursor.fetchall() 
  print("\n========== REFRIGERADORES ==========") 
  print(f"{'ID':<10}{'NOMBRE':<30}{'BOTELLAS':<15}{'LATAS':<15}") 
  print("-" * 70) 
  for refrigerador in refrigeradores:
    print(f"{refrigerador[0]:<10}{refrigerador[1]:<30}{refrigerador[2]:<15}{refrigerador[3]:<15}")
  bd.commit() 
  cursor.close() 
  bd.close()

def agregar_refrigerador():
  bd = conectar()
  cursor = bd.cursor()
  nombre = input("Ingrese el nombre del refrigerador: ") 
  capacidadBotellas = int(input("Ingrese la capacidad de botellas: ")) 
  capacidadLatas = int(input("Ingrese la capacidad de latas: ")) 
  sql = """ INSERT INTO refrigerador (nombre, capacidadBotellas, capacidadLatas) VALUES (%s, %s, %s) """ 
  valores = (nombre, capacidadBotellas, capacidadLatas) 
  cursor.execute(sql, valores) 
  bd.commit() 
  cursor.close() 
  bd.close()

def eliminar_refrigerador():
  bd = conectar() 
  cursor = bd.cursor() 
  idRefrigerador = int(input("ID del refrigerador a eliminar: ")) 
  sql = f"DELETE FROM refrigerador WHERE idRefrigerador = {idRefrigerador}" 
  cursor.execute(sql) 
  bd.commit() 
  cursor.close() 
  bd.close()

def actualizar_refrigerador():
  bd = conectar() 
  cursor = bd.cursor()
  idRefrigerador = int(input("Ingrese el ID del refrigerador: ")) 
  nombre = input("Ingrese el nuevo nombre: ") 
  capacidadBotellas = int(input("Ingrese la nueva capacidad de botellas: ")) 
  capacidadLatas = int(input("Ingrese la nueva capacidad de latas: ")) 
  sql = f""" UPDATE refrigerador SET nombre = '{nombre}', capacidadBotellas = {capacidadBotellas}, capacidadLatas = {capacidadLatas} WHERE idRefrigerador = {idRefrigerador} """ 
  cursor.execute(sql)
  bd.commit()
  cursor.close()
  bd.close()
