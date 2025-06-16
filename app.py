from flask import Flask, flash, render_template, request, redirect, url_for, session
from model.controller_usuario import autenticar_usuario, cadastrar_usuario
from model.controller_imagem import obter_imagens
from model.controller_produto import obter_produtos_por_categoria
from model.controller_produto_detalhado import obter_produto_detalhado
from model.controller_produto_detalhado import obter_imagens_do_produto
from model.controller_produto_detalhado import salvar_comentario
from model.controller_produto_detalhado import listar_comentarios
from model.controller_carrinho import adicionar_ao_carrinho, listar_itens_carrinho, remover_do_carrinho  # <-- adicionado aqui

app = Flask(__name__)
app.secret_key = 'chave_super_secreta'


@app.route('/')
def principal():
    nome = session.get('nome')
    imagens = obter_imagens()
    return render_template('pagina_principal.html', nome=nome, imagens=imagens)


@app.route('/produtos/<int:cod_categoria>')
def produtos(cod_categoria):
    nome = session.get('nome')
    produtos = obter_produtos_por_categoria(cod_categoria)
    return render_template('pagina_produto.html', produtos=produtos, cod_categoria=cod_categoria, nome=nome)


@app.route('/login', methods=['GET', 'POST'])
def pagina_login():
    nome = session.get('nome')
    if request.method == 'POST':
        email = request.form['email']
        senha = request.form['senha']

        usuario = autenticar_usuario(email, senha)

        if usuario:
            session['cod_usuario'] = usuario[0]
            session['nome'] = usuario[1]
            return redirect(url_for('principal'))
        else:
            return render_template('pagina_login.html', erro="Email ou senha incorretos", nome=nome)

    return render_template('pagina_login.html', nome=nome)


@app.route('/cadastro', methods=['GET', 'POST'])
def pagina_cadastro():
    nome = session.get('nome')
    if request.method == 'POST':
        nome_cadastro = request.form['nome']
        email = request.form['email']
        senha = request.form['senha']
        endereco = request.form['endereco']
        telefone = request.form['telefone']

        cadastrar_usuario(nome_cadastro, email, senha, endereco, telefone)
        return redirect(url_for('pagina_login'))

    return render_template('pagina_cadastro.html', nome=nome)


@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('principal'))


@app.route("/carrinho")
def ver_carrinho():
    nome = session.get('nome')
    cod_usuario = session.get("cod_usuario")
    if not cod_usuario:
        return redirect(url_for('pagina_login'))

    itens = listar_itens_carrinho(cod_usuario)
    return render_template("pagina_carrinho.html", itens=itens, nome=nome)


@app.route('/produto_detalhado/<int:cod_produto>')
def produto_detalhado(cod_produto):
    nome = session.get('nome')
    produto = obter_produto_detalhado(cod_produto)
    imagens = obter_imagens_do_produto(cod_produto)
    comentarios = listar_comentarios(cod_produto)
    return render_template('pagina_detalhado.html', produto=produto, imagens=imagens, comentarios=comentarios, nome=nome)


@app.route("/enviar-comentario", methods=["POST"])
def enviar_comentario():
    nome = session.get('nome')
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
    nome = session.get('nome')
    cod_usuario = session.get("cod_usuario")
    cod_produto = request.form["cod_produto"]

    if cod_usuario is None:
        return redirect(url_for('pagina_login'))

    adicionar_ao_carrinho(cod_usuario, cod_produto)
    return redirect(url_for("ver_carrinho"))


@app.route('/remover-carrinho/<int:cod_produto>', methods=['POST'])
def remover_carrinho(cod_produto):
    cod_usuario = session.get('cod_usuario')
    if not cod_usuario:
        return redirect(url_for('pagina_login'))

    remover_do_carrinho(cod_usuario, cod_produto)
    return redirect(url_for('ver_carrinho'))


if __name__ == '__main__':
    app.run(debug=True)
