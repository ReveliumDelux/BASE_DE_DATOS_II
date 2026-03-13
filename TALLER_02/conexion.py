import mysql.connector


def get_connection():
    connection = mysql.connector.connect(
        host="localhost",
        port=3306,
        user="root",
        password="PaNaMa1234",
        database="sistema_expedientes"
    )
    return connection
