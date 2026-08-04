from conexion import conectar
from Clientes.crudCliente import *

def menuCliente():
    while True:
        print("=====================")
        print("  GESTION CLIENTES   ")
        print("=====================")

        print("0. salir del menu de clientes")
        print("1. Mostrar clientes")
        print("2. Agregar cliente")
        print("3. Eliminar cliente")
        print("4. actualizar numero telefonico del cliente")

        opcion = int(input("Seleccione una opcion del menu: "))

        if opcion == 1:
            mostrar_clientes()
        elif opcion == 2:
            agregar_cliente()
        elif opcion == 3:
            eliminar_cliente()
        elif opcion == 4:
            actualizar_numero_cliente()
        elif opcion == 0:
            print("Regresando al menu principal")
            break;
        else:
            print("Opcion incorrecta")

