from flask import Flask, request, jsonify
from flask_cors import CORS
from database import conectar

print("APP CORRETO CARREGADO")

app = Flask(__name__)
CORS(app)

@app.route('/login', methods=['POST'])
def login():

    dados = request.json

    email = dados['email']
    senha = dados['senha']

    banco = conectar()
    cursor = banco.cursor(dictionary=True)

    cursor.execute(
        """
        SELECT *
        FROM usuarios
        WHERE email = %s
        AND senha = %s
        """,
        (email, senha)
    )

    usuario = cursor.fetchone()

    cursor.close()
    banco.close()

    if usuario:
        return jsonify({
            "sucesso": True,
            "id_usuario": usuario["id_usuario"],
            "nome": usuario["nome"],
            "tipo": usuario["tipo"]
        })

    return jsonify({
        "sucesso": False
    })
@app.route("/")
def home():
    return "API da Academia funcionando!"

@app.route("/alunos")
def listar_alunos():

    banco = conectar()
    cursor = banco.cursor(dictionary=True)

    cursor.execute("SELECT * FROM alunos")

    alunos = cursor.fetchall()

    cursor.close()
    banco.close()

    return jsonify(alunos)


@app.route("/perfil/<int:id_usuario>")
def perfil(id_usuario):

    banco = conectar()
    cursor = banco.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM usuarios WHERE id_usuario = %s",
        (id_usuario,)
    )

    usuario = cursor.fetchone()

    cursor.close()
    banco.close()

    return jsonify(usuario)

@app.route("/treinos")
def treinos():

    banco = conectar()
    cursor = banco.cursor(dictionary=True)

    cursor.execute("SELECT * FROM treinos")

    dados = cursor.fetchall()

    cursor.close()
    banco.close()

    return jsonify(dados)

@app.route("/pagamentos")
def pagamentos():

    banco = conectar()
    cursor = banco.cursor(dictionary=True)

    cursor.execute("SELECT * FROM pagamentos")

    dados = cursor.fetchall()

    cursor.close()
    banco.close()

    return jsonify(dados)




if __name__ == "__main__":
    app.run(debug=True)
