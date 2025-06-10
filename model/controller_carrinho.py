from data.conexao import conectar

def inserir_comentario(produto_id, cod_usuario, comentario):
    conexao = conectar.criar_conexao()
    cursor = conexao.cursor()

    sql = """INSERT INTO tb_comentarios (cod_produto, cod_usuario, comentario)
             VALUES (%s, %s, %s)"""
             
    cursor.execute(sql, (produto_id, cod_usuario, comentario))
    conexao.commit()
    cursor.close()
    conexao.close()


def listar_comentarios(produto_id):
    conexao = conectar.criar_conexao()
    cursor = conexao.cursor(dictionary=True)

    sql = """SELECT u.nome AS nome_usuario, c.comentario
             FROM tb_comentarios c
             INNER JOIN tb_usuarios u ON c.cod_usuario = u.cod_usuario
             WHERE c.cod_produto = %s
             ORDER BY c.data_hora DESC"""

    cursor.execute(sql, (produto_id,))
    comentarios = cursor.fetchall()

    cursor.close()
    conexao.close()
    return comentarios



