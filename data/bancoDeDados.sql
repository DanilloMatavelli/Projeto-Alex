CREATE TABLE Entity8 (
);


CREATE TABLE tb_categoria (
 cod_categorias CHAR(10) NOT NULL,
 descricao CHAR(10)
);

ALTER TABLE tb_categoria ADD CONSTRAINT PK_tb_categoria PRIMARY KEY (cod_categorias);


CREATE TABLE tb_categorias (
 cod_categoria CHAR(10) NOT NULL,
 descricao CHAR(10)
);

ALTER TABLE tb_categorias ADD CONSTRAINT PK_tb_categorias PRIMARY KEY (cod_categoria);


CREATE TABLE tb_produto (
 cod_produto INT NOT NULL,
 cod_categoria CHAR(10) NOT NULL,
 nome CHAR(10),
 descrição CHAR(10),
 foto CHAR(10),
 categoria CHAR(10)
);

ALTER TABLE tb_produto ADD CONSTRAINT PK_tb_produto PRIMARY KEY (cod_produto,cod_categoria);


CREATE TABLE tb_produtos (
 cod_produto CHAR(10) NOT NULL,
 nome CHAR(10),
 descricao CHAR(10),
 preco CHAR(10),
 cod_categorias CHAR(10)
);

ALTER TABLE tb_produtos ADD CONSTRAINT PK_tb_produtos PRIMARY KEY (cod_produto);


CREATE TABLE tb_usuarios (
 cod_usuario CHAR(10) NOT NULL,
 nome CHAR(10)
);

ALTER TABLE tb_usuarios ADD CONSTRAINT PK_tb_usuarios PRIMARY KEY (cod_usuario);


CREATE TABLE tb_carrinho (
 cod_carrinho CHAR(10) NOT NULL,
 cod_produto CHAR(10) NOT NULL,
 cod_usuario CHAR(10) NOT NULL
);

ALTER TABLE tb_carrinho ADD CONSTRAINT PK_tb_carrinho PRIMARY KEY (cod_carrinho,cod_produto,cod_usuario);


CREATE TABLE tb_carrinhos (
 cod_carrinho CHAR(10) NOT NULL,
 cod_produto INT NOT NULL,
 cod_usuario CHAR(10) NOT NULL,
 cod_categoria CHAR(10) NOT NULL
);

ALTER TABLE tb_carrinhos ADD CONSTRAINT PK_tb_carrinhos PRIMARY KEY (cod_carrinho,cod_produto,cod_usuario,cod_categoria);


CREATE TABLE tb_fotos_produto (
 cod_foto CHAR(10) NOT NULL,
 cod_produto CHAR(10) NOT NULL,
 url CHAR(10)
);

ALTER TABLE tb_fotos_produto ADD CONSTRAINT PK_tb_fotos_produto PRIMARY KEY (cod_foto,cod_produto);


ALTER TABLE tb_produto ADD CONSTRAINT FK_tb_produto_0 FOREIGN KEY (cod_categoria) REFERENCES tb_categorias (cod_categoria);


ALTER TABLE tb_produtos ADD CONSTRAINT FK_tb_produtos_0 FOREIGN KEY (cod_categorias) REFERENCES tb_categoria (cod_categorias);


ALTER TABLE tb_carrinho ADD CONSTRAINT FK_tb_carrinho_0 FOREIGN KEY (cod_produto) REFERENCES tb_produtos (cod_produto);
ALTER TABLE tb_carrinho ADD CONSTRAINT FK_tb_carrinho_1 FOREIGN KEY (cod_usuario) REFERENCES tb_usuarios (cod_usuario);


ALTER TABLE tb_carrinhos ADD CONSTRAINT FK_tb_carrinhos_0 FOREIGN KEY (cod_produto,cod_categoria) REFERENCES tb_produto (cod_produto,cod_categoria);
ALTER TABLE tb_carrinhos ADD CONSTRAINT FK_tb_carrinhos_1 FOREIGN KEY (cod_usuario) REFERENCES tb_usuarios (cod_usuario);


ALTER TABLE tb_fotos_produto ADD CONSTRAINT FK_tb_fotos_produto_0 FOREIGN KEY (cod_produto) REFERENCES tb_produtos (cod_produto);


