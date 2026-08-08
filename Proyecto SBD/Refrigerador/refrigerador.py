from conexion import conectar
from Refrigeradores.crudRefrigerador import *

def menuRefrigerador():
    while True:
        print("========================")
        print("  GESTION REFRIGERADORES ")
        print("========================")

        print("0. Salir del menu de refrigeradores")
        print("1. Mostrar refrigeradores")
        print("2. Agregar refrigerador")
        print("3. Eliminar refrigerador")
        print("4. Actualizar refrigerador")

        opcion = int(input("Seleccione una opcion del menu: "))

        if opcion == 1:
            mostrar_refrigeradores()
        elif opcion == 2:
            agregar_refrigerador()
        elif opcion == 3:
            eliminar_refrigerador()
        elif opcion == 4:
            actualizar_refrigerador()
        elif opcion == 0:
            print("Regresando al menu principal")
            break
        else:
            print("Opcion incorrecta")
