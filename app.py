from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def principal():
    return render_template('pagina_principal.html')

@app.route('/login')
def pagina_login():
    return render_template('pagina_login.html')


if __name__ == '__main__':
    app.run(debug=True)
