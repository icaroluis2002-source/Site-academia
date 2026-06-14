from flask import Blueprint, request, jsonify
from database import conectar


login = Blueprint("login",__name__)


@login.route("/login", methods=["POST"])
def fazer_login():

    dados = request.json

    email = dados["email"]
    senha = dados["senha"]


    banco = conectar()

    cursor = banco.cursor(dictionary=True)


    cursor.execute(
        """
        SELECT * FROM usuarios
        WHERE email=%s AND senha=%s
        """,
        (email, senha)
    )


    usuario = cursor.fetchone()


    if usuario:
        return jsonify(usuario)

    else:
        return jsonify({
            "mensagem":"Login inválido"
        })