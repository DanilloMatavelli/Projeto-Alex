import mysql.connector

def conectar():
    conexao = mysql.connector.connect(
        host="db-gptrio-gptrio.c.aivencloud.com",  
        user="avnadmin",            
        password="AVNS_k7-exgoO4kambzp3PPU",    
        database="db_gptrio"    
    )
    return conexao