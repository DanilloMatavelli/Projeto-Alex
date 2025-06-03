from data.conexao import conectar


def obter_imagens():
    conexao = conectar()
    cursor = conexao.cursor()
    cursor.execute("SELECT url FROM tb_foto_produto LIMIT 3")
    resultados = cursor.fetchall()
    cursor.close()
    conexao.close()
    return [row[0] for row in resultados]  

