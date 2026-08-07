import mysql.connector

def conectar():
    conexion = mysql.connector.connect(
        host="localhost",
        user="root",
        password="javidici",#root
        database="test"
    )

    return conexion