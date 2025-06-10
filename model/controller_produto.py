from data.conexao import conectar

def obter_produtos_por_categoria(cod_categoria):
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)

    if cod_categoria == 5:
        query = """
            SELECT 
                p.cod_produto,
                p.nome,
                p.descricao,
                p.preco,
                MIN(f.url) AS imagem_principal
            FROM tb_produto p
            LEFT JOIN tb_foto_produto f ON p.cod_produto = f.cod_produto
            GROUP BY p.cod_produto, p.nome, p.descricao, p.preco
        """
        cursor.execute(query)
    else:
        query = """
            SELECT 
                p.cod_produto,
                p.nome,
                p.descricao,
                p.preco,
                MIN(f.url) AS imagem_principal
            FROM tb_produto p
            LEFT JOIN tb_foto_produto f ON p.cod_produto = f.cod_produto
            WHERE p.cod_categoria = %s
            GROUP BY p.cod_produto, p.nome, p.descricao, p.preco
        """
        cursor.execute(query, (cod_categoria,))
    
    produtos = cursor.fetchall()
    cursor.close()
    conexao.close()

    return produtos
