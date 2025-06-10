from data.conexao import conectar

class ProdutoDetalhado:
    def obter_produto_detalhado(cod_produto):
        conexao = conectar() 

        cursor = conexao.cursor(dictionary=True)

        sql = """
SELECT p.cod_produto, p.nome, p.descricao, p.preco, 
       d.url_foto1, d.url_foto2, d.url_foto3
FROM tb_produto p
LEFT JOIN tb_produto_detalhado d ON p.cod_produto = d.cod_produto
WHERE p.cod_produto = %s
"""

        cursor.execute(sql, (cod_produto,))
        return cursor.fetchone()
