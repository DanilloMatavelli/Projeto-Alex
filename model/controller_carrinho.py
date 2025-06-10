from data.conexao import conectar


class Carrinho:
    def recuperar_informacoes_produto():
        # Criar conexão
        conexao = conectar.criar_conexao()
        
        # O cursor será responsavel por manipular o banco de dados 
        cursor = conexao.cursor(dictionary = True)
        
        # Define a consulta SQL
        sql = """SELECT cod_produto,
                        nome, 
                        data_hora,
                        curtidas,
                        comentario as mensagem
                 FROM tb_produto"""
                 
        # Executando o comando SQL
        cursor.execute(sql)