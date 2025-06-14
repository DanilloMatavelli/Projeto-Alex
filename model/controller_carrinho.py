from data.conexao import conectar 

def adicionar_ao_carrinho(cod_usuario, cod_produto):
    conexao = conectar()
    cursor = conexao.cursor()

    # Verifica se o produto já está no carrinho
    sql_carrinho = "SELECT quantidade FROM tb_carrinho WHERE cod_usuario = %s AND cod_produto = %s"
    cursor.execute(sql_carrinho, (cod_usuario, cod_produto))
    item = cursor.fetchone()

    if item:
        # Se já existe, apenas incrementa a quantidade
        sql_update = "UPDATE tb_carrinho SET quantidade = quantidade + 1 WHERE cod_usuario = %s AND cod_produto = %s"
        cursor.execute(sql_update, (cod_usuario, cod_produto))
    else:
        # Caso contrário, insere o produto com quantidade inicial 1
        sql_insert = "INSERT INTO tb_carrinho (cod_usuario, cod_produto, quantidade) VALUES (%s, %s, 1)"
        cursor.execute(sql_insert, (cod_usuario, cod_produto))

    conexao.commit()
    cursor.close()
    conexao.close()




def listar_itens_carrinho(cod_usuario): 
    conexao = conectar() 
    cursor = conexao.cursor(dictionary=True) 
    sql = """ 
        SELECT 
            p.nome, 
            p.preco, 
            c.quantidade,
            f.url AS imagem_url,
            cat.descricao AS categoria,
            (SELECT SUM(p2.preco * c2.quantidade) 
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