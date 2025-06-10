from flask import Flask, render_template, request, redirect, url_for, session
from model.controller_usuario import autenticar_usuario, cadastrar_usuario
from model.controller_imagem import obter_imagens
from model.controller_produto import obter_produtos_por_categoria


app = Flask(__name__)
app.secret_key = 'chave_super_secreta'

@app.route('/')
def principal():
    nome = session.get('nome')
    imagens = obter_imagens()
    return render_template('pagina_principal.html', nome=nome, imagens=imagens)

@app.route('/produtos/<int:cod_categoria>')
def produtos(cod_categoria):
    produtos = obter_produtos_por_categoria(cod_categoria)
    return render_template('pagina_produto.html', produtos=produtos, cod_categoria=cod_categoria)

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

# Carrinho
@app.route('/carrinho')
def pagina_carrinho():
    return render_template('pagina_carrinho.html')

# Rota produto detalhado

@app.route('/produto_detalhado/<int:cod_produto>')
def produto_detalhado(cod_produto):
    produto = obter_produto_detalhado(cod_produto)
    
    return render_template('pagina_detalhado.html', produto=produto)

if __name__ == '__main__':
    app.run(debug=True)
