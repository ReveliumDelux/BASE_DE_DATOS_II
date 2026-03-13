from flask import Flask, jsonify, request
from DotosApi import get_connection
app = Flask(__name__)

@app.route('/')
def inicio():
    return "API funcionando"


@app.route('/usuarios', methods=['GET'])
def usuarios():

    connection = get_connection()
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM usuarios")

    resultados = cursor.fetchall()

    return jsonify(resultados)


@app.route('/expedientes', methods=['GET'])
def expedientes():

    connection = get_connection()
    cursor = connection.cursor()

    cursor.execute("SELECT * FROM expedientes")

    resultados = cursor.fetchall()

    return jsonify(resultados)

@app.route('/login', methods=['POST'])
def login():

    data = request.json

    usuario = data['usuario']
    clave = data['clave']

    connection = get_connection()
    cursor = connection.cursor()

    query = "SELECT * FROM usuarios WHERE usuario=%s AND clave=%s"
    cursor.execute(query, (usuario, clave))

    resultado = cursor.fetchone()

    if resultado:
        return jsonify({"mensaje": "Login correcto"})
    else:
        return jsonify({"mensaje": "Credenciales incorrectas"})


@app.route('/usuarios', methods=['POST'])
def crear_usuario():

    data = request.json

    nombre = data['nombre']
    usuario = data['usuario']
    clave = data['clave']

    connection = get_connection()
    cursor = connection.cursor()

    query = "INSERT INTO usuarios (nombre, usuario, clave) VALUES (%s,%s,%s)"
    cursor.execute(query, (nombre, usuario, clave))

    connection.commit()

    return jsonify({"mensaje": "Usuario creado"})

if __name__ == '__main__':
    app.run(debug=True)