from conexion import conectar

from Detalles.crudDetalle import *

def menuDetalle():
    while True:
        print("==========================")
        print("   GESTION DETALLE VENTA  ")
        print("==========================")
        print("0. Salir del menú de detalles")
        print("1. Mostrar detalles de ventas")
        print("2. Agregar producto a una venta")
        print("3. Eliminar detalle de venta")

        opcion = int(input("Seleccione una opción del menú: "))

        if opcion == 1:
            mostrar_detalles()
        elif opcion == 2:
            agregar_detalle()
        elif opcion == 3:
            eliminar_detalle()
        elif opcion == 0:
            print("Regresando al menú principal...")
            break
        else:
            print("Opción incorrecta, intente de nuevo.")



