import mysql.connector

def conectar():
    conexao = mysql.connector.connect(
        host="localhost",  
        user="root",            
        password="root",    
        database="db_gptrio"     
    )
    return conexao
