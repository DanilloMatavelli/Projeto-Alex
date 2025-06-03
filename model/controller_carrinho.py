from data.conexao import conectar


class Carrinho:
    def recuperar_produtos_do_carrinho(cod_usuario):
        conexao = conectar.criar_conexao()
        cursor = conexao.cursor(dictionary=True)

        sql = """
            SELECT 
                p.cod_produto,
                p.nome,
                p.descricao,
                p.preco,
                p.cod_categoria,
                c.descricao AS categoria, 
                f.url AS foto,
                i.quantidade
            FROM tb_carrinho c
            JOIN tb_item_carrinho i ON c.cod_carrinho = i.cod_carrinho
            JOIN tb_produto p ON i.cod_produto = p.cod_produto
            JOIN tb_categoria c ON p.cod_categoria = c.cod_categoria   -- JOIN com a categoria
            LEFT JOIN tb_foto_produto f ON p.cod_produto = f.cod_produto
            WHERE c.cod_usuario = ?
        """

        cursor.execute(sql, (cod_usuario,))
        produtos = cursor.fetchall()

        cursor.close()
        conexao.close()

        return produtos