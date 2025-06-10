from data.conexao import conectar

def obter_produto_detalhado(cod_produto):
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)

    sql_produto = """
        SELECT p.cod_produto, p.nome, p.descricao, p.preco,
               f1.url AS imagem_url,
               d.url_foto1, d.url_foto2, d.url_foto3
        FROM tb_produto p
        LEFT JOIN tb_foto_produto f1 ON p.cod_produto = f1.cod_produto
        LEFT JOIN tb_produto_detalhado d ON p.cod_produto = d.cod_produto
        WHERE p.cod_produto = %s
        LIMIT 1
    """
    cursor.execute(sql_produto, (cod_produto,))
    produto = cursor.fetchone()

    cursor.close()
    conexao.close()

    return produto
