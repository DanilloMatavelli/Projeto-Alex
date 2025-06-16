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

def obter_imagens_do_produto(cod_produto):
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)

    cursor.execute("""
        SELECT url_foto1, url_foto2, url_foto3
        FROM tb_produto_detalhado
        WHERE cod_produto = %s
    """, (cod_produto,))

    row = cursor.fetchone()
    cursor.close()
    conexao.close()

    if row:
        return [row["url_foto1"], row["url_foto2"], row["url_foto3"]]
    else:
        return []

def salvar_comentario(cod_usuario, cod_produto, comentario):
    conexao = conectar()
    cursor = conexao.cursor()
    sql = """
        INSERT INTO tb_avaliacao (cod_usuario, cod_produto, comentario)
        VALUES (%s, %s, %s)
    """
    cursor.execute(sql, (cod_usuario, cod_produto, comentario))
    conexao.commit()
    cursor.close()
    conexao.close()

# Listar os comentarios

def listar_comentarios(cod_produto):
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)
    sql = """
        SELECT u.nome, a.comentario, a.data_comentario
        FROM tb_avaliacao a
        JOIN tb_usuario u ON a.cod_usuario = u.cod_usuario
        WHERE a.cod_produto = %s
        ORDER BY a.data_comentario DESC
    """
    cursor.execute(sql, (cod_produto,))
    comentarios = cursor.fetchall()
    cursor.close()
    conexao.close()
    return comentarios


