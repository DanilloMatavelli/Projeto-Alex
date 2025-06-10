from data.conexao import conectar

class ProdutoDetalhado:
    @staticmethod
    def obter_produto_detalhado(cod_produto):
        conexao = conectar.criar_conexao()
        cursor = conexao.cursor(dictionary=True)

        sql = """
        SELECT cod_produto, nome, descricao, preco, imagem_url
        FROM tb_produto
        WHERE cod_produto = %s
        """
        cursor.execute(sql, (cod_produto,))
        return cursor.fetchone()
