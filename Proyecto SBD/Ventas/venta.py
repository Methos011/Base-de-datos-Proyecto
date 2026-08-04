from conexion import conectar
from Ventas.crudVenta import *

def menuVenta():
    while True:
            print("=====================")
            print("    GESTION VENTAS   ")
            print("=====================")

            print("0. Salir del menu de clientes")
            print("1. Mostrar ventas realizadas")
            print("2. Registrar venta")
            
            opcion = int(input("Seleccione una opcion del menu: "))

            if opcion == 1:
                mostrar_ventas()
            elif opcion == 2:
                registrar_venta()
            
            elif opcion == 0:
                print("Regresando al menu principal")
                break;
            else:
                print("Opcion incorrecta")