from flask import Flask, render_template, request, redirect, url_for, session
from model.controller_usuario import autenticar_usuario, cadastrar_usuario
from model.controller_comentario import inserir_comentario, listar_comentarios
from model.controller_imagem import obter_imagens
from model.controller_produto import obter_produtos_por_categoria
<<<<<<< HEAD
=======
from model.controller_produto_detalhado import ProdutoDetalhado

>>>>>>> 2d592f3bb1a18253282edf10ee8a3f8558171810


app = Flask(__name__)
app.secret_key = 'chave_super_secreta'

@app.route('/')
def principal():
    nome = session.get('nome')
    imagens = obter_imagens()
    return render_template('pagina_principal.html', nome=nome, imagens=imagens)


@app.route('/produtos/<int:cod_categoria>')
def produtos(cod_categoria):
    produtos = obter_produtos_por_categoria(cod_categoria)  # Certifique-se de que essa função retorna dados válidos
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


# Rota Carrinho

# Carrinho

@app.route('/carrinho')
def pagina_carrinho():
    return render_template('pagina_carrinho.html')

# Rota produto detalhado

@app.route('/vizualizaro/<int:cod_produto>')
def produto_detalhado(cod_produto):
    produto = ProdutoDetalhado.obter_produto_detalhado(cod_produto)

    return render_template('pagina_detalhado.html', produto=produto)

# Página de produto com comentários (adicionado a lógica de atualização)
@app.route('/produto_detalhado/<int:produto_id>')
def pagina_detalhado(produto_id):
    nome = session.get('nome')
    cod_usuario = session.get('cod_usuario')

    produto = ProdutoDetalhado.obter_produto_detalhado(produto_id) 
    comentarios = listar_comentarios(produto_id)

    if not produto: 
        return "Erro: Produto não encontrado!", 404

    return render_template('pagina_detalhado.html', produto=produto, nome=nome, comentarios=comentarios)




if __name__ == '__main__':
    app.run(debug=True)
