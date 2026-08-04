from conexion import conectar
from Productos.enumPresentacion import Presentacion
from Productos.enumProducto import Producto

def mostrar_producto():
    bd = conectar()
    cursor = bd.cursor()
    
    cursor.execute("SELECT * FROM producto")
    productos = cursor.fetchall()

    for producto in productos:
        print(producto)
    
    cursor.close()
    bd.close()
    
def agregar_producto(producto: Producto, presentacion: Presentacion):
    bd = conectar()
    cursor = bd.cursor()
    #Entradas de texto
    
    marca = input("Ingrese la marca del producto: ")
    
    tipoProducto = input("Ingrese el tipo de producto: ")
    
    if tipoProducto != "L":
        presentacion = input("Ingrese la presentacion del producto: ")
    else:
        presentacion = None

    cantidad = int(input("Ingrese la cantidad de productos a añadir: "))
    
    print("1. para si es retornable, 0. si no es retornbale")
    retornable = int(input("Ingrese si es retornable o no: "))
    
    if retornable == 0:
        retornable = False
    elif retornable == 1:
        retornable = True
    else:
        print("Numero incorrecto")
        return    
    
    precio = float(input("Ingrese el precio del producto"))

    if presentacion == Presentacion.JABA:
        valor_garantia = float(input("Ingrese el valor de garantia"))
    else:
        valor_garantia = None
    
    sql = "INSERT INTO producto (marca, tipoProducto, presentacion, cantidad, retornable, precio, ValorGarantia VALUES (%s,%s,%s,%s,%s)"
    valores = (marca,tipoProducto,presentacion, cantidad, retornable, precio, valor_garantia)
    
    try:
        cursor.execute(sql, valores)
        bd.commit()
    except Exception as e:
        bd.rollback()
        print("Error:", e)
    finally:
        cursor.close()
        bd.close()

def eliminar_Producto():
    bd = conectar()
    cursor = bd.cursor()
