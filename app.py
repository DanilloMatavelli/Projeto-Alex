from flask import Flask, flash, render_template, request, redirect, url_for, session
from model.controller_usuario import autenticar_usuario, cadastrar_usuario
from model.controller_imagem import obter_imagens
from model.controller_produto import obter_produtos_por_categoria
from model.controller_produto_detalhado import obter_produto_detalhado
from model.controller_produto_detalhado import obter_imagens_do_produto
from model.controller_produto_detalhado import salvar_comentario
from model.controller_produto_detalhado import listar_comentarios
from model.controller_carrinho import adicionar_ao_carrinho, listar_itens_carrinho

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
@app.route('/cadastro', methods=['GET', 'POST'])
def pagina_cadastro():
    if request.method == 'POST':
        nome = request.form['nome']
        email = request.form['email']
        senha = request.form['senha']
        endereco = request.form['endereco']
        telefone = request.form['telefone']

        cadastrar_usuario(nome, email, senha, endereco, telefone)
        return redirect(url_for('pagina_login'))
    
    return render_template('pagina_cadastro.html')  # Página com o formulário de cadastro

# Logout
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('principal'))

@app.route("/carrinho")
def ver_carrinho():
    cod_usuario = session.get("cod_usuario")
    if not cod_usuario:
        return redirect(url_for('pagina_login'))

    # Listando os itens do carrinho
    itens = listar_itens_carrinho(cod_usuario)
    
    # Certifique-se de que a página de carrinho é renderizada corretamente
    return render_template("pagina_carrinho.html", itens=itens)

@app.route('/produto_detalhado/<int:cod_produto>')
def produto_detalhado(cod_produto):
    produto = obter_produto_detalhado(cod_produto)
    imagens = obter_imagens_do_produto(cod_produto)
    comentarios = listar_comentarios(cod_produto)
    return render_template('pagina_detalhado.html', produto=produto, imagens=imagens, comentarios=comentarios)



# rota para enviar um comentario
@app.route("/enviar-comentario", methods=["POST"])
def enviar_comentario():
    cod_usuario = session.get("cod_usuario")
    if not cod_usuario:
        return redirect(url_for('pagina_login'))
    cod_produto = request.form.get("cod_produto")
    comentario = request.form.get("comentario")

    if not cod_usuario or not comentario:
        flash("Você precisa estar logado e preencher o comentário.", "warning")
        return redirect(request.referrer)

    salvar_comentario(cod_usuario, cod_produto, comentario)
    flash("Comentário enviado com sucesso!", "success")
    return redirect(url_for("produto_detalhado", cod_produto=cod_produto))


@app.route("/adicionar-carrinho", methods=["POST"]) 
def rota_adicionar_carrinho(): 
    cod_usuario = session.get("cod_usuario") 
    cod_produto = request.form["cod_produto"] 

    if cod_usuario is None: 
        return redirect(url_for('pagina_login')) 
    adicionar_ao_carrinho(cod_usuario, cod_produto) 
    return redirect(url_for("ver_carrinho")) # Redireciona para a página do carrinho

# @app.route("/adicionar-carrinho", methods=["POST"]) 
# def rota_adicionar_carrinho(): 
#     cod_usuario = session.get("cod_usuario")
#     if cod_usuario is None:
#         return redirect(url_for("pagina_login"))

#     itens = listar_itens_carrinho(cod_usuario)
#     total = sum(item["preco"] * item["quantidade"] for item in itens) if itens else 0.0

#     return render_template("pagina_carrinho.html", itens=itens, total=total)










if __name__ == '__main__':
    app.run(debug=True)
