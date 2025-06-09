from flask import Flask, render_template, request, redirect, url_for, session
from model.controller_usuario import autenticar_usuario, cadastrar_usuario
from model.controller_comentario import inserir_comentario, listar_comentarios
from model.controller_imagem import obter_imagens


app = Flask(__name__)
app.secret_key = 'chave_super_secreta' 


from model.controller_imagem import obter_imagens

@app.route('/')
def principal():
    nome = session.get('nome')
    imagens = obter_imagens()
    return render_template('pagina_principal.html', nome=nome, imagens=imagens)


# Login
@app.route('/login', methods=['GET', 'POST'])
def pagina_login():
    if request.method == 'POST':
        email = request.form['email']
        senha = request.form['senha']

        usuario = autenticar_usuario(email, senha)

        if usuario:
            session['cod_usuario'] = usuario[0]
            session['nome'] = usuario[1]
            return redirect(url_for('principal'))
        else:
            return render_template('pagina_login.html', erro="Email ou senha incorretos")

    return render_template('pagina_login.html')


# Cadastro
@app.route('/cadastro', methods=['POST'])
def pagina_cadastro():
    nome = request.form['nome']
    email = request.form['email']
    senha = request.form['senha']
    endereco = request.form['endereco']
    telefone = request.form['telefone']

    cadastrar_usuario(nome, email, senha, endereco, telefone)

    return redirect(url_for('pagina_login'))


# Logout
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('principal'))


# Rota Carrinho
@app.route('/carrinho')
def pagina_carrinho():
    return render_template('pagina_carrinho.html')


# Página de produto com comentários (adicionado a lógica de atualização)
@app.route('/produto/<int:produto_id>', methods=['GET', 'POST'])
def pagina_detalhado(produto_id):
    nome = session.get('nome')
    cod_usuario = session.get('cod_usuario')

    if request.method == 'POST':
        if cod_usuario:
            texto_comentario = request.form['comentario']
            avaliacao = request.form['avaliacao']
            inserir_comentario(produto_id, cod_usuario, texto_comentario, avaliacao)
            return redirect(url_for('pagina_detalhado', produto_id=produto_id))  # Atualiza a página após comentar
        else:
            return redirect(url_for('pagina_login'))  # Redireciona para login caso não esteja logado

    comentarios = listar_comentarios(produto_id)
    return render_template('pagina_detalhado.html', produto_id=produto_id, nome=nome, comentarios=comentarios)


if __name__ == '__main__':
    app.run(debug=True)
