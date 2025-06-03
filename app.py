from flask import Flask, render_template, request, redirect, url_for, session
from model.controller_usuario import autenticar_usuario, cadastrar_usuario

app = Flask(__name__)
app.secret_key = 'chave_super_secreta'  # Necessário para usar sessão


# Página principal
@app.route('/')
def principal():
    nome = session.get('nome')
    return render_template('pagina_principal.html', nome=nome)


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

# Rota Carrinho
@app.route('/comando/carrinho')
def comando_carrinho():
    cod_usuario = session.get('cod_usuario')

    if not cod_usuario:
        return redirect(url_for('pagina_login'))

    from model.controller_carrinho import Carrinho
    produtos = Carrinho.recuperar_produtos_do_carrinho(cod_usuario)

    return render_template('pagina_carrinho.html', produtos=produtos)


if __name__ == '__main__':
    app.run(debug=True)
