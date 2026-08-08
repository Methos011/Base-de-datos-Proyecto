from conexion import conectar
from Proveedor.crudProveedor import *

def menuProveedor():
    while True:
        print("=========================")
        print("   GESTION PROVEEDORES   ")
        print("=========================")

        print("0. Salir del menu de proveedores")
        print("1. Mostrar proveedores")
        print("2. Agregar proveedor")
        print("3. Eliminar proveedor")
        print("4. Actualizar correo electronico del proveedor")

        opcion = int(input("Seleccione una opcion del menu: "))

        if opcion == 1:
            mostrar_proveedores()
        elif opcion == 2:
            agregar_proveedor()
        elif opcion == 3:
            eliminar_proveedor()
        elif opcion == 4:
            actualizar_correo_proveedor()
        elif opcion == 0:
            print("Regresando al menu principal")
            break
        else:
            print("Opcion incorrecta")
