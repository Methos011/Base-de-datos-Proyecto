from conexion import conectar
from Responsable.crudResponsable import *

def menuResponsable():
    while True:
        print("=========================")
        print("   GESTION RESPONSABLES  ")
        print("=========================")

        print("0. Salir del menu de responsables")
        print("1. Mostrar responsables")
        print("2. Agregar responsable")
        print("3. Eliminar responsable")
        print("4. Actualizar numero telefonico del responsable")

        opcion = int(input("Seleccione una opcion del menu: "))

        if opcion == 1:
            mostrar_responsables()
        elif opcion == 2:
            agregar_responsable()
        elif opcion == 3:
            eliminar_responsable()
        elif opcion == 4:
            actualizar_telefono_responsable()
        elif opcion == 0:
            print("Regresando al menu principal")
            break
        else:
            print("Opcion incorrecta")
