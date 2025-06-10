# controller_carrinho.py

from data.conexao import conectar

def adicionar_ao_carrinho(cod_usuario, cod_produto):
    conexao = conectar()
    cursor = conexao.cursor()

    # Verificando se o produto já está no carrinho
    sql = """
        SELECT * FROM tb_carrinho 
        WHERE cod_usuario = %s AND cod_produto = %s
    """
    cursor.execute(sql, (cod_usuario, cod_produto))
    item = cursor.fetchone()

    if not item:
        # Produto não está no carrinho, então adicionamos
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

    # Consultando todos os itens do carrinho do usuário
    sql = """
        SELECT p.nome, p.preco, f.url AS imagem_principal
        FROM tb_carrinho c
        JOIN tb_produto p ON c.cod_produto = p.cod_produto
        LEFT JOIN tb_foto_produto f ON p.cod_produto = f.cod_produto
        WHERE c.cod_usuario = %s
    """
    cursor.execute(sql, (cod_usuario,))
    itens = cursor.fetchall()

    cursor.close()
    conexao.close()

    return itens
