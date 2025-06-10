from data.conexao import conectar

def inserir_comentario(produto_id, cod_usuario, texto_comentario, avaliacao):
    """Insere um comentário no banco de dados."""
    conexao = conectar()
    cursor = conexao.cursor()

    sql = """INSERT INTO tb_comentario (cod_produto, cod_usuario, texto_comentario, avaliacao, data_comentario)
             VALUES (%s, %s, %s, %s, NOW())"""
             
    cursor.execute(sql, (produto_id, cod_usuario, texto_comentario, avaliacao))
    conexao.commit()
    
    cursor.close()
    conexao.close()


def listar_comentarios(produto_id):
    """Retorna todos os comentários de um produto específico."""
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)

    sql = """SELECT u.nome AS nome_usuario, c.texto_comentario, c.avaliacao, c.data_comentario
             FROM tb_comentario c
             INNER JOIN tb_usuario u ON c.cod_usuario = u.cod_usuario
             WHERE c.cod_produto = %s
             ORDER BY c.data_comentario DESC"""

    cursor.execute(sql, (produto_id,))
    comentarios = cursor.fetchall()

    cursor.close()
    conexao.close()
    return comentarios
