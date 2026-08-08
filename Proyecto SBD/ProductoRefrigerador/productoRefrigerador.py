from conexion import conectar
from ProductoRefrigerador.crudProductoRefrigerador import *

def menuProductoRefrigerador():
    while True:
        print("=======================================")
        print("   GESTIÓN PRODUCTOS EN REFRIGERADOR   ")
        print("=======================================")
        print("0. Salir")
        print("1. Mostrar productos en refrigeradores")
        print("2. Asignar producto a refrigerador")
        print("3. Actualizar cantidad")
        print("4. Quitar producto de refrigerador")

        opcion = int(input("Seleccione una opción: "))

        if opcion == 1:
            mostrar_prod_refrigerador()
        elif opcion == 2:
            agregar_prod_refrigerador()
        elif opcion == 3:
            actualizar_prod_refrigerador()
        elif opcion == 4:
            eliminar_prod_refrigerador()
        elif opcion == 0:
            print("Regresando al menú principal...")
            break
        else:
            print("Opción incorrecta, intente de nuevo.")