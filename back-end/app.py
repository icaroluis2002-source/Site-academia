@app.route("/test-db")
def test_db():
    try:
        conn = conectar()
        return "Banco conectou!"
    except Exception as e:
        return str(e)