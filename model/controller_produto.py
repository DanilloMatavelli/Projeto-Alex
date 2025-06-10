from data.conexao import conectar

def obter_produtos_por_categoria(cod_categoria):
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)
    
    if cod_categoria == 5:
        query = """
            SELECT p.cod_produto, p.nome, p.descricao, p.preco, f.url AS imagem_principal,
                d.url_foto1, d.url_foto2, d.url_foto3
            FROM tb_produto p
            LEFT JOIN tb_foto_produto f ON p.cod_produto = f.cod_produto
            LEFT JOIN tb_produto_detalhado d ON p.cod_produto = d.cod_produto
        """
        cursor.execute(query)
    else: 
        query = """
            SELECT p.cod_produto, p.nome, p.descricao, p.preco, f.url AS imagem_principal,
                d.url_foto1, d.url_foto2, d.url_foto3
            FROM tb_produto p
            LEFT JOIN tb_foto_produto f ON p.cod_produto = f.cod_produto
            LEFT JOIN tb_produto_detalhado d ON p.cod_produto = d.cod_produto
            WHERE p.cod_categoria = %s;
        """
        cursor.execute(query, (cod_categoria,))
        
        
    produtos = cursor.fetchall()

    cursor.close()
    conexao.close()

    return produtos
