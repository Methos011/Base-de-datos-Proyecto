from conexion import conectar
from Productos.crudProducto import *

print("======================")
print("   GESTION PRODUCTOS  ")
print("======================")

print("1. Mostrar productos")
print("2. Agregar producto")
print("3. Eliminar prodducto")
print("4. Actualizar precio del producto")
opcion = int(input("Selecciona una opcion: " ))

if opcion == 1:
    mostrar_producto()
elif opcion == 2:
    agregar_producto()
''' elif opcion == 3:
     '''