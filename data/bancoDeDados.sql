CREATE DATABASE db_gptrio;

USE db_gptrio;

-- Tabela de Categorias
CREATE TABLE tb_categoria (
    cod_categoria INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL
);

-- Tabela de Produtos
CREATE TABLE tb_produto (
    cod_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco float NOT NULL,
    cod_categoria INT,
    FOREIGN KEY (cod_categoria) REFERENCES tb_categoria(cod_categoria)
);

-- Tabela de Usuários 
CREATE TABLE tb_usuario (
    cod_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    endereco VARCHAR(200) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

-- Tabela de Carrinho (Produtos no Carrinho)
CREATE TABLE tb_carrinho (
    cod_carrinho INT PRIMARY KEY AUTO_INCREMENT,
    cod_usuario INT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cod_usuario) REFERENCES tb_usuario(cod_usuario)
);

-- Tabela Itens do Carrinho (Produtos que estão no carrinho)
CREATE TABLE tb_item_carrinho (
    cod_item INT PRIMARY KEY AUTO_INCREMENT,
    cod_carrinho INT,
    cod_produto INT,
    quantidade INT DEFAULT 1,
    FOREIGN KEY (cod_carrinho) REFERENCES tb_carrinho(cod_carrinho),
    FOREIGN KEY (cod_produto) REFERENCES tb_produto(cod_produto)
);

-- Tabela de Fotos dos Produtos
CREATE TABLE tb_foto_produto (
    cod_foto INT PRIMARY KEY AUTO_INCREMENT,
    cod_produto INT,
    url VARCHAR(255) NOT NULL,
    FOREIGN KEY (cod_produto) REFERENCES tb_produto(cod_produto)
);
