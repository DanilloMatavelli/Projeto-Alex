import mysql.connector

def conectar():
    conexao = mysql.connector.connect(
        host="localhost",        # ou seu host, exemplo: "127.0.0.1"
        user="root",             # seu usuário do MySQL
        password="root",    # sua senha do MySQL
        database="db_gptrio"     # nome do banco de dados
    )
    return conexao
