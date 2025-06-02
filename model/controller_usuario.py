from data.conexao import conectar

def autenticar_usuario(email, senha):
    conexao = conectar()
    cursor = conexao.cursor()

    sql = "SELECT cod_usuario, nome FROM tb_usuario WHERE email = %s AND senha = %s"
    cursor.execute(sql, (email, senha))
    usuario = cursor.fetchone()

    cursor.close()
    conexao.close()

    return usuario


def cadastrar_usuario(nome, email, senha, endereco, telefone):
    conexao = conectar()
    cursor = conexao.cursor()

    sql = "INSERT INTO tb_usuario (nome, email, senha, endereco, telefone) VALUES (%s, %s, %s, %s, %s)"
    cursor.execute(sql, (nome, email, senha, endereco, telefone))
    conexao.commit()

    cursor.close()
    conexao.close()
