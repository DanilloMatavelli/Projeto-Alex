from data.conexao import conectar

def obter_produtos_por_categoria(cod_categoria):
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)
    
    query = "SELECT nome, descricao, preco FROM tb_produto WHERE cod_categoria = %s"
    cursor.execute(query, (cod_categoria,))
    produtos = cursor.fetchall()

    cursor.close()
    conexao.close()
    
    return produtos
