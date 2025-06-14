

from data.conexao import conectar

def adicionar_ao_carrinho(cod_usuario, cod_produto):
    conexao = conectar()
    cursor = conexao.cursor()


    sql = """
        SELECT * FROM tb_carrinho 
        WHERE cod_usuario = %s AND cod_produto = %s
    """
    cursor.execute(sql, (cod_usuario, cod_produto))
    item = cursor.fetchone()

    if not item:

        sql = """
            INSERT INTO tb_carrinho (cod_usuario, cod_produto)
            VALUES (%s, %s)
        """
        cursor.execute(sql, (cod_usuario, cod_produto))
        conexao.commit()

    cursor.close()
    conexao.close()




def listar_itens_carrinho(cod_usuario):
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)

    sql = """
        SELECT 
            p.nome, 
            p.preco AS preco, 
            f.url AS imagem_url,
            cat.descricao AS categoria,
            (SELECT SUM(p2.preco) 
             FROM tb_carrinho c2 
             JOIN tb_produto p2 ON c2.cod_produto = p2.cod_produto 
             WHERE c2.cod_usuario = %s) AS total
        FROM tb_carrinho c
        JOIN tb_produto p ON c.cod_produto = p.cod_produto
        LEFT JOIN tb_foto_produto f ON p.cod_produto = f.cod_produto
        LEFT JOIN tb_categoria cat ON p.cod_categoria = cat.cod_categoria
        WHERE c.cod_usuario = %s
    """
    cursor.execute(sql, (cod_usuario, cod_usuario))
    itens = cursor.fetchall()

    cursor.close()
    conexao.close()

    return itens
