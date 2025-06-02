CREATE DATABASE db_gptrio;

USE db_gptrio;

-- Tabela de Categorias
CREATE TABLE tb_categoria (
    cod_categoria INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL
);

INSERT INTO tb_categoria (descricao) VALUES ('Calçados');

INSERT INTO tb_categoria (descricao) VALUES ('Camisas');

INSERT INTO tb_categoria (descricao) VALUES ('Bermudas');

INSERT INTO tb_categoria (descricao) VALUES ('Moletons');

INSERT INTO tb_categoria (descricao) VALUES ('Todos');


-- Tabela de Produtos
CREATE TABLE tb_produto (
    cod_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco float NOT NULL,
    cod_categoria INT,
    FOREIGN KEY (cod_categoria) REFERENCES tb_categoria(cod_categoria)
);

-- Produtos da categoria Calçados 
INSERT INTO tb_produto (nome, descricao, preco, cod_categoria) VALUES
('Tênis Corrida X1', 'Tênis leve com sola em EVA e amortecimento.', 199.90, 1),
('Chinelo Conforto Max', 'Chinelo com palmilha anatômica.', 39.90, 1),
('Bota Adventure Pro', 'Bota resistente para trilhas e aventuras.', 289.00, 1),
('Sapato Social Clássico', 'Sapato em couro legítimo para ocasiões formais.', 249.99, 1),
('Tênis Casual Urbano', 'Tênis ideal para o dia a dia.', 179.50, 1),
('Sapatênis Versátil', 'Combina conforto e elegância.', 199.00, 1),
('Sandália Masculina Couro', 'Sandália confortável com ajuste em velcro.', 119.90, 1),
('Chuteira Society', 'Chuteira para gramado sintético.', 149.99, 1),
('Tênis Infantil Light', 'Tênis leve com luzes de LED.', 99.90, 1);

-- Produtos da categoria Camisas 
INSERT INTO tb_produto (nome, descricao, preco, cod_categoria) VALUES
('Camisa Polo Clássica', 'Polo lisa em diversas cores.', 109.90, 2),
('Camisa Social Slim', 'Corte moderno e elegante.', 129.00, 2),
('Camisa Xadrez Masculina', 'Estilo casual com estampa xadrez.', 99.99, 2),
('Camisa Manga Longa Linho', 'Ideal para climas quentes.', 149.90, 2),
('Camisa Estampada Tropical', 'Estampa descontraída para o verão.', 89.90, 2),
('Camisa Jeans Masculina', 'Estilo urbano em jeans.', 119.00, 2),
('Camisa Básica Algodão', 'Modelo simples e confortável.', 59.90, 2),
('Camisa Oversized Unissex', 'Corte amplo e moderno.', 74.50, 2),
('Camisa Esportiva Dry', 'Tecido respirável para esportes.', 69.90, 2);

-- Produtos da categoria Bermudas
INSERT INTO tb_produto (nome, descricao, preco, cod_categoria) VALUES
('Bermuda Jeans Tradicional', 'Jeans azul com corte reto.', 89.90, 3),
('Bermuda Moletom Basic', 'Modelo casual em moletom leve.', 59.90, 3),
('Bermuda Sarja Slim', 'Bermuda de sarja com elastano.', 79.99, 3),
('Bermuda Tática Militar', 'Modelo com bolsos múltiplos e tecido reforçado.', 129.90, 3),
('Bermuda Surf Estampada', 'Ideal para praia ou piscina.', 69.90, 3),
('Bermuda Ciclista', 'Modelo justo e confortável para pedalar.', 59.50, 3),
('Bermuda Cargo Masculina', 'Com bolsos laterais e tecido resistente.', 99.90, 3),
('Bermuda Infantil Super-Heróis', 'Estampa divertida para crianças.', 49.90, 3),
('Bermuda Fitness DryFit', 'Tecido respirável para atividades físicas.', 64.99, 3); 

-- Produtos da categoria Moletons
INSERT INTO tb_produto (nome, descricao, preco, cod_categoria) VALUES
('Moletom Capuz Básico', 'Com bolso frontal e cordão ajustável.', 139.90, 4),
('Moletom Estampado Urbano', 'Estampa moderna para looks casuais.', 149.00, 4),
('Moletom Zíper Unissex', 'Abertura frontal com zíper.', 159.90, 4),
('Moletom Infantil Heróis', 'Modelos temáticos para crianças.', 109.90, 4),
('Moletom Flanelado', 'Interior flanelado para dias frios.', 179.90, 4),
('Moletom Canguru Estilizado', 'Estampa frontal criativa.', 129.99, 4),
('Moletom College Style', 'Estilo universitário americano.', 149.50, 4),
('Moletom Sem Capuz Slim', 'Corte ajustado, discreto e leve.', 119.00, 4),
('Moletom Gamer', 'Com estampa de jogos e cultura geek.', 134.90, 4);

-- Produtos da categoria todos
INSERT INTO tb_produto (nome, descricao, preco, cod_categoria)
SELECT nome, descricao, preco, 5
FROM tb_produto
WHERE cod_categoria IN (1, 2, 3, 4);

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
select * from tb_categoria;
select * from tb_produto;

-- Fotos dos produtos calçados
-- Produto 1: Tênis Corrida X1
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (1, 'https://example.com/imagens/tenis_corrida_x1.jpg');
-- Produto 2: Chinelo Conforto Max
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (1, 'https://example.com/imagens/chinelo_conforto_max.jpg');
-- Produto 3: Bota Adventure Pro
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (3, 'https://example.com/imagens/bota_adventure_pro.jpg');
-- Produto 4: Sapato Social Clássico
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (4, 'https://example.com/imagens/sapato_social_classico.jpg');
-- Produto 5: Tênis Casual Urbano
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (5, 'https://example.com/imagens/tenis_casual_urbano.jpg');
-- Produto 6: Sapatênis Versátil
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (6, 'https://example.com/imagens/sapatenis_versatil.jpg');
-- Produto 7: Sandália Masculina Couro
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (7, 'https://example.com/imagens/sandalia_masculina_couro.jpg');
-- Produto 8: Chuteira Society
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (8, 'https://example.com/imagens/chuteira_society.jpg');
-- Produto 9: Tênis Infantil Light
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (9, 'https://example.com/imagens/tenis_infantil_light.jpg');

-- Fotos dos produtos camisas
-- Produto 19: Camisa Polo Clássica
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (19, 'https://example.com/imagens/camisa_polo_classica.jpg');

-- Produto 20: Camisa Social Slim
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (20, 'https://example.com/imagens/camisa_social_slim.jpg');

-- Produto 21: Camisa Xadrez Masculina
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (21, 'https://example.com/imagens/camisa_xadrez_masculina.jpg');

-- Produto 22: Camisa Manga Longa Linho
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (22, 'https://example.com/imagens/camisa_manga_longa_linho.jpg');

-- Produto 23: Camisa Estampada Tropical
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (23, 'https://example.com/imagens/camisa_estampada_tropical.jpg');

-- Produto 24: Camisa Jeans Masculina
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (24, 'https://example.com/imagens/camisa_jeans_masculina.jpg');

-- Produto 25: Camisa Básica Algodão
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (25, 'https://example.com/imagens/camisa_basica_algodao.jpg');

-- Produto 26: Camisa Oversized Unissex
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (26, 'https://example.com/imagens/camisa_oversized_unissex.jpg');

-- Produto 27: Camisa Esportiva Dry
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (27, 'https://example.com/imagens/camisa_esportiva_dry.jpg');

-- Fotos dos produtos Bermudas
-- Produto 10: Bermuda Jeans Tradicional
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (10, 'https://example.com/imagens/bermuda_jeans_tradicional.jpg');

-- Produto 11: Bermuda Moletom Basic
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (11, 'https://example.com/imagens/bermuda_moletom_basic.jpg');

-- Produto 12: Bermuda Sarja Slim
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (12, 'https://example.com/imagens/bermuda_sarja_slim.jpg');

-- Produto 13: Bermuda Tática Militar
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (13, 'https://example.com/imagens/bermuda_tatica_militar.jpg');

-- Produto 14: Bermuda Surf Estampada
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (14, 'https://example.com/imagens/bermuda_surf_estampada.jpg');

-- Produto 15: Bermuda Ciclista
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (15, 'https://example.com/imagens/bermuda_ciclista.jpg');

-- Produto 16: Bermuda Cargo Masculina
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (16, 'https://example.com/imagens/bermuda_cargo_masculina.jpg');

-- Produto 17: Bermuda Infantil Super-Heróis
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (17, 'https://example.com/imagens/bermuda_infantil_super_herois.jpg');

-- Produto 18: Bermuda Fitness DryFit
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (18, 'https://example.com/imagens/bermuda_fitness_dryfit.jpg');

-- Fotos dos produtos Moletons
-- Produto 28: Moletom Capuz Básico
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (28, 'https://example.com/imagens/moletom_capuz_basico.jpg');

-- Produto 29: Moletom Estampado Urbano
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (29, 'https://example.com/imagens/moletom_estampado_urbano.jpg');

-- Produto 30: Moletom Zíper Unissex
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (30, 'https://example.com/imagens/moletom_zipe_unissex.jpg');

-- Produto 31: Moletom Infantil Heróis
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (31, 'https://example.com/imagens/moletom_infantil_herois.jpg');

-- Produto 32: Moletom Flanelado
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (32, 'https://example.com/imagens/moletom_flanelado.jpg');

-- Produto 33: Moletom Canguru Estilizado
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (33, 'https://example.com/imagens/moletom_canguru_estilizado.jpg');

-- Produto 34: Moletom College Style
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (34, 'https://example.com/imagens/moletom_college_style.jpg');

-- Produto 35: Moletom Sem Capuz Slim
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (35, 'https://example.com/imagens/moletom_sem_capuz_slim.jpg');

-- Produto 36: Moletom Gamer
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (36, 'https://example.com/imagens/moletom_sem_capuz_slim.jpg');

-- Fotos dos produtos Moletons, só mostrar todos os produtos 
SELECT * FROM tb_produto;
