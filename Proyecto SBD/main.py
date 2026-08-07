from conexion import conectar
from Clientes.cliente import *
from Ventas.venta import *
from Detalles.detalleVenta import menuDetalle

def menu():
    while True:
        print("\n====== DEPÓSITO 4 HERMANOS ======")
        print("1. Mostrar menu Clientes")
        print("2. Mostrar menu Responsable")
        print("3. Mostrar menu ventas")
        print("4. Mostrar menú Detalles de Venta")

        print("0. Salir")

        opcion = int(input("Seleccione una opción: "))
        
        if opcion == 1:
            menuCliente()
        elif opcion == 2:
            print("aqui va el menu responsables")
        elif opcion == 3:
           menuVenta()
        elif opcion == 4:
            menuDetalle()
        

        elif opcion == 0:
            print("Saliendo...")
            break


        


menu()