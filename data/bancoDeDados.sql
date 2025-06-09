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

-- Fotos dos produtos calçados
-- Produto 1: Tênis Corrida X1
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (1, 'https://cdn.vnda.com.br/1000x800/velocita/2024/11/12/14_58_04_933_14_11_1_169_1147910fstc1.jpg?v=1731434322');
-- Produto 2: Chinelo Conforto Max
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (1, 'https://m.media-amazon.com/images/I/81gCNdzb8fL._AC_SY695_.jpg');
-- Produto 3: Bota Adventure Pro
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (3, 'https://a-static.mlcdn.com.br/800x560/bota-coturno-masculina-motoqueiro-adventure-pro-force-150-proforce/scaf/16239594/4ff1149e429c2d988ffe18ea7bae90a1.jpeg');
-- Produto 4: Sapato Social Clássico
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (4, 'https://example.com/imagens/sapato_social_classico.jpg');
-- Produto 5: Tênis Casual Urbano
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (5, 'https://static.zattini.com.br/produtos/sapato-masculino-democrata-oliver-social-classico-cadarco-couro-conforto-273202/06/D83-4415-006/D83-4415-006_zoom1.jpg?ts=1705309530&ims=1088x');
-- Produto 6: Sapatênis Versátil
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (6, 'https://pegada.vtexassets.com/arquivos/ids/190228-1200-1200?v=638821448799000000&width=1200&height=1200&aspect=true');
-- Produto 7: Sandália Masculina Couro
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (7, 'https://static.netshoes.com.br/produtos/sandalia-couro-pegada-nordeste-amortech-masculina/38/E21-1621-138/E21-1621-138_zoom1.jpg?ts=1695716647&ims=1088x');
-- Produto 8: Chuteira Society
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (8, 'https://static.netshoes.com.br/produtos/chuteira-society-adidas-deportivo-ii-unissex-exclusiva/70/FB9-4074-070/FB9-4074-070_zoom1.jpg?ts=1710336224&ims=1088x');
-- Produto 9: Tênis Infantil Light
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (9, 'https://example.com/imagens/tenis_infantil_light.jpg');

-- Fotos dos produtos camisas
-- Produto 19: Camisa Polo Clássica
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (19, 'https://d1zvfmhlebc91g.cloudfront.net/fit-in/0x0/filters:fill(ffffff)/filters:quality(98)/n49shopv2_spazziojeans/images/products/80512_polo-piquet-classica-054-pr-1615-0067587_z2_638122377654539294.jpg');

-- Produto 20: Camisa Social Slim
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (20, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmISaXBZdSO4LaeBFlhHzwBP1pjKeIphhDEQ&s');

-- Produto 21: Camisa Xadrez Masculina
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (21, 'https://http2.mlstatic.com/D_NQ_NP_2X_841044-MLB80018016887_102024-F-camisa-xadrez-masculina-manga-longa-lenhador-coleco-vero.webp');

-- Produto 22: Camisa Manga Longa Linho
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (22, 'https://cdn.awsli.com.br/2500x2500/1300/1300343/produto/131296244/myr-23-0924818-01jlks41ds.jpg');

-- Produto 23: Camisa Estampada Tropical
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (23, 'https://images.tcdn.com.br/img/img_prod/970725/camisa_manga_curta_estampa_tropical_14521_7_56a4b56ee92ab2d6b17c2ddcc7b66057.jpg');

-- Produto 24: Camisa Jeans Masculina
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (24, 'https://lojasfirenzo.com/cdn/shop/files/S52c4bdec23fb4f43aa0e1d86e6694800U_800x.webp?v=1741104556');

-- Produto 25: Camisa Básica Algodão
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (25, 'https://www.insiderstore.com.br/cdn/shop/files/Foto-01_5.png?v=1748540783&width=1206');

-- Produto 26: Camisa Oversized Unissex
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (26, 'https://acdn-us.mitiendanube.com/stores/417/579/products/aot2-534d96be503c736f2b17302525621006-1024-1024.png');

-- Produto 27: Camisa Esportiva Dry
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (27, 'https://www.lojamirante.com.br/uploads/dirImage/16/524x520_acf3fde08c45a2cf47a75b8c1a3c652a.webp');

-- Fotos dos produtos Bermudas
-- Produto 10: Bermuda Jeans Tradicional
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (10, 'https://img.ltwebstatic.com/images3_spmp/2023/09/15/c3/169472886264322ad34c6a0f5f2e8fbfed6680c59e_thumbnail_405x.webp');

-- Produto 11: Bermuda Moletom Basic
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (11, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyDmSKGwyIXKRbkZxa3YGszqXJMfMlkcw9PA&s');

-- Produto 12: Bermuda Sarja Slim
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (12, 'https://img.lojasrenner.com.br/item/563990870/original/13.jpg');

-- Produto 13: Bermuda Tática Militar
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (13, 'https://www.camagli.com.br/cdn/shop/products/5df9b61093ca13a7b9e5ba88fd2d749d_c65df500-b45c-4e19-af85-9040befa6c19_600x.jpg?v=1677986929');

-- Produto 14: Bermuda Surf Estampada
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (14, 'https://osklenbr.vteximg.com.br/arquivos/ids/582584/6837148828_BERMUDA-SURF-WAIKIKI_1.jpg?v=638684018951300000?w=681');

-- Produto 15: Bermuda Ciclista
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (15, 'https://http2.mlstatic.com/D_NQ_NP_2X_927133-MLB50610093789_072022-F-02-bermudas-ciclismo-bike-acolchoadas-profissional-promoco.webp');

-- Produto 16: Bermuda Cargo Masculina
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (16, 'https://montevie.com/cdn/shop/files/Se612dab0d405464e980500d5fe940477S_800x.webp?v=1725980789');

-- Produto 17: Bermuda Infantil Super-Heróis
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (17, 'https://grupokyly.vteximg.com.br/arquivos/ids/259643-1000-1000/1000363_3449_B.jpg?v=638700442640630000');

-- Produto 18: Bermuda Fitness DryFit
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (18, 'https://www.gsuplementos.com.br/upload/produto/imagem/shorts-de-treino-growth-growth-supplements-1.webp');

-- Fotos dos produtos Moletons
-- Produto 28: Moletom Capuz Básico
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (28, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiCJ8FDMTrgVuU0MCgiGVYQRRcr4OldWrWGA&s');

-- Produto 29: Moletom Estampado Urbano
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (29, 'https://www.calitta.com/8336-large_default/moletom-masculino-com-capuz-moda-swag-urbano-estampa-nas-mangas.jpg');

-- Produto 30: Moletom Zíper Unissex
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (30, 'https://down-br.img.susercontent.com/file/br-11134207-7r98o-lqml29k1vmsf54');

-- Produto 31: Moletom Infantil Heróis
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (31, 'https://images2.marisa.com.br/medias/sys_master/images/images/h7f/h32/16596741652510/CONJ-MOL-CAPUZ-SPIDEY-MESCLA-MESC-2-10057345314-C1.jpg');

-- Produto 32: Moletom Flanelado
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (32, 'https://m.media-amazon.com/images/I/61acfoZWEoL._AC_SX569_.jpg');

-- Produto 33: Moletom Canguru Estilizado
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (33, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx-Eqcg-SjCwKiDbM1l5ipO1M4az_XzdMc6g&s');

-- Produto 34: Moletom College Style
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (34, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFrUfmBfwCrbFzXl9dYNoYK5z7FqPS2q-7zA&s');

-- Produto 35: Moletom Sem Capuz Slim
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (35, 'https://santogato.com/161-large_default/jaqueta-social-de-moletom-masculino-slim-sem-capuz-estilo-elegante.jpg');

-- Produto 36: Moletom Gamer
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (36, 'https://bemvestir.cdn.magazord.com.br/img/2023/03/produto/9551/16-0597-01.jpg?ims=fit-in/630x945/filters:fill(white)');

-- Fotos dos produtos Moletons, só mostrar todos os produtos 
SELECT * FROM tb_produto;

CREATE TABLE tb_produto_detalhado (
    cod_produto INT,
    url_foto1 VARCHAR(255) NOT NULL,
    url_foto2 VARCHAR(255) NOT NULL,
    url_foto3 VARCHAR(255) NOT NULL,
    FOREIGN KEY (cod_produto) REFERENCES tb_produto(cod_produto)
);

-- Script SQL atualizado com as imagens correspondentes aos produtos

-- Produto 1: Tênis Corrida X1
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (1, 
'https://cdn.vnda.com.br/1000x800/velocita/2024/11/12/14_58_04_933_14_11_1_169_1147910fstc1.jpg?v=1731434322',
'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/8b6e61a848534a7184014c70e8ad838a_9366/ADIZERO_DRIVE_RC_M_Verde_JR4890_01_00_standard.jpg', 
'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/24872dab7d6448efbeb2cc3b6fdce414_9366/ADIZERO_DRIVE_RC_M_Verde_JR4890_04_standard.jpg');

-- Produto 2: Chinelo Conforto Max
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (2, 
'https://havaianas.com.br/cdn/shop/files/4148608-top-max-comfort-0090-0.jpg?v=1734128580&width=493', 
'https://havaianas.com.br/cdn/shop/files/4148608-top-max-comfort-0090-1.jpg?v=1734128581&width=493', 
'https://havaianas.com.br/cdn/shop/files/4148608-top-max-comfort-0090-3.jpg?v=1734128581&width=493');

-- Produto 3: Bota Adventure Pro
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (3, 
'https://img.irroba.com.br/fit-in/500x500/filters:format(webp):fill(transparent):quality(80)/vntboeee/catalog/3101bbrown4.png', 
'https://img.irroba.com.br/fit-in/500x500/filters:format(webp):fill(transparent):quality(80)/vntboeee/catalog/3101bbrown1.png', 
'https://img.irroba.com.br/fit-in/500x500/filters:format(webp):fill(transparent):quality(80)/vntboeee/catalog/3101bbrown6.png');

-- Produto 4: Sapato Social Clássico
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (4, 
'https://img.irroba.com.br/fit-in/600x600/filters:format(webp):fill(fff):quality(80)/bernaton/catalog/produtos/3098-laser-cafe-120191008093157.JPG', 
'https://img.irroba.com.br/fit-in/600x600/filters:format(webp):fill(fff):quality(80)/bernaton/catalog/produtos/3098-laser-cafe-220191008093157.JPG', 
'https://img.irroba.com.br/fit-in/600x600/filters:format(webp):fill(fff):quality(80)/bernaton/catalog/produtos/3098-laser-cafe-320191008093157.JPG');

-- Produto 5: Tênis Casual Urbano
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (5, 
'https://cdn.shoppub.io/cdn-cgi/image/w=1000,h=1000,q=80,f=auto/soundshoes/media/uploads/produtos/foto/eutlldtw/1.png', 
'https://cdn.shoppub.io/cdn-cgi/image/w=1000,h=1000,q=80,f=auto/soundshoes/media/uploads/produtos/foto/haueoyfp/2.png', 
'https://cdn.shoppub.io/cdn-cgi/image/w=1000,h=1000,q=80,f=auto/soundshoes/media/uploads/produtos/foto/zhlamjze/3.png');

-- Produto 6: Sapatênis Versátil
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (6, 
'https://lojasfirenzo.com/cdn/shop/files/Sef8aaf5d2d174b89944925b3c4805c962-600x600_1_600x.jpg?v=1740757445', 
'https://lojasfirenzo.com/cdn/shop/files/sapatnis-masculino-em-couro-off-ekien-2_1_800x.jpg?v=1740757445', 
'https://lojasfirenzo.com/cdn/shop/files/Sapatenis-Off-Ekien-2023-1-3_1_d8438163-d52b-4418-a55c-367067e63643_500x.jpg?v=1740757445');

-- Produto 7: Sandália Masculina Couro
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (7, 
'https://premierman.com.br/cdn/shop/files/2_b2f02b07-ec4f-467e-9321-2c7bcb3dad08.jpg?v=1717559231&width=1000', 
'https://premierman.com.br/cdn/shop/files/Sandalia_de_Couro_Masculina_Confortavel_Papete_Verde_Lado.jpg?v=1720068578&width=1000', 
'https://premierman.com.br/cdn/shop/files/Sandalia_de_Couro_Masculina_Confortavel_Papete_Frente_Verde.jpg?v=1720068578&width=1000');

-- Produto 8: Chuteira Society
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (8, 
'https://static.netshoes.com.br/produtos/chuteira-society-umbro-orbit-unissex/06/2IA-8331-006/2IA-8331-006_zoom1.jpg?ts=1744127960&ims=1088x', 
'https://static.netshoes.com.br/produtos/chuteira-society-umbro-orbit-unissex/06/2IA-8331-006/2IA-8331-006_zoom2.jpg?ts=1744127960&ims=1088x', 
'https://static.netshoes.com.br/produtos/chuteira-society-umbro-orbit-unissex/06/2IA-8331-006/2IA-8331-006_zoom3.jpg?ts=1744127960&ims=1088x');

-- Produto 9: Tênis Infantil Light
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (9, 
'https://static.netshoes.com.br/produtos/tenis-infantil-skechers-meteor-lights-krendo-menino/18/SEM-0035-118/SEM-0035-118_zoom1.jpg?ts=1743183652&ims=1088x', 
'https://static.netshoes.com.br/produtos/tenis-infantil-skechers-meteor-lights-krendo-menino/18/SEM-0035-118/SEM-0035-118_zoom3.jpg?ts=1743183652&ims=1088x', 
'https://static.netshoes.com.br/produtos/tenis-infantil-skechers-meteor-lights-krendo-menino/18/SEM-0035-118/SEM-0035-118_zoom4.jpg?ts=1743183652&ims=1088x');

-- Produto 10: Bermuda Jeans Tradicional
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (10, 
'https://http2.mlstatic.com/D_NQ_NP_2X_988197-MLB31117217678_062019-F-bermuda-jeans-desconto-envio-imediato-24-horas.webp', 
'https://img.lojasrenner.com.br/item/929322148/original/13.jpg', 
'https://img.lojasrenner.com.br/item/929322148/original/14.jpg');

-- Produto 11: Bermuda Moletom Basic
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (11, 
'https://www.knulu.com.br/media/catalog/product/cache/1/thumbnail/717x900/9df78eab33525d08d6e5fb8d27136e95/k/n/knulu-moda-masculina-2022-270.jpg', 
'https://www.knulu.com.br/media/catalog/product/cache/1/thumbnail/717x900/9df78eab33525d08d6e5fb8d27136e95/k/n/knulu-moda-masculina-2022-272.jpg', 
'https://www.knulu.com.br/media/catalog/product/cache/1/thumbnail/717x900/9df78eab33525d08d6e5fb8d27136e95/k/n/knulu-moda-masculina-2022-273.jpg');

-- Produto 12: Bermuda Sarja Slim
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (12, 
'https://storetng.vteximg.com.br/arquivos/ids/471055-0-0/BNMBCH01_504_1-BERMUDA-CHINO-SLIM-COLOR.jpg?v=638350740080870000', 
'https://storetng.vteximg.com.br/arquivos/ids/471061-0-0/BNMBCH01_504_2-BERMUDA-CHINO-SLIM-COLOR.jpg?v=638350740210070000', 
'https://storetng.vteximg.com.br/arquivos/ids/471067-0-0/BNMBCH01_504_3-BERMUDA-CHINO-SLIM-COLOR.jpg?v=638350740318600000');

-- Produto 13: Bermuda Tática Militar
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (13, 
'https://produtgy.com.br/cdn/shop/products/5df9b61093ca13a7b9e5ba88fd2d749d_c65df500-b45c-4e19-af85-9040befa6c19_600x.jpg?v=1656427625', 
'https://produtgy.com.br/cdn/shop/products/9_e75c7275_df5a_46b2_32LCa_400x.jpg?v=1656427625', 
'https://produtgy.com.br/cdn/shop/products/h172c6d5143824b94835_bHaGa_600x.jpg?v=1656427625');

-- PAREI AQUI
-- Produto 14: Bermuda Surf Estampada
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (14, 
'https://osklenbr.vteximg.com.br/arquivos/ids/582584/6837148828_BERMUDA-SURF-WAIKIKI_1.jpg?v=638684018951300000?w=681', 
'https://images.unsplash.com/photo-1560769629-d641e25e4a5e?w=400', 
'https://images.unsplash.com/photo-1605733160314-4fc7dac4bb16?w=400');

-- Produto 15: Bermuda Ciclista
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (15, 
'https://http2.mlstatic.com/D_NQ_NP_2X_927133-MLB50610093789_072022-F-02-bermudas-ciclismo-bike-acolchoadas-profissional-promoco.webp', 
'https://images.unsplash.com/photo-1537832816519-689ad163238b?w=400', 
'https://images.unsplash.com/photo-1607522370275-f14206abe5d3?w=400');

-- Produto 16: Bermuda Cargo Masculina
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (16, 
'https://montevie.com/cdn/shop/files/Se612dab0d405464e980500d5fe940477S_800x.webp?v=1725980789', 
'https://images.unsplash.com/photo-1565814329452-e1efa11c5b89?w=400', 
'https://images.unsplash.com/photo-1588099768523-f4e6663fa9c8?w=400');

-- Produto 17: Bermuda Infantil Super-Heróis
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (17, 
'https://grupokyly.vteximg.com.br/arquivos/ids/259643-1000-1000/1000363_3449_B.jpg?v=638700442640630000', 
'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?w=400', 
'https://images.unsplash.com/photo-1574408891259-26e3a2de251d?w=400');

-- Produto 18: Bermuda Fitness DryFit
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (18, 
'https://www.gsuplementos.com.br/upload/produto/imagem/shorts-de-treino-growth-growth-supplements-1.webp', 
'https://images.unsplash.com/photo-1558618666-cbd2305aef45?w=400', 
'https://images.unsplash.com/photo-1560243563-062d244a51b1?w=400');

-- Produto 19: Camisa Polo Clássica
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (19, 
'https://d1zvfmhlebc91g.cloudfront.net/fit-in/0x0/filters:fill(ffffff)/filters:quality(98)/n49shopv2_spazziojeans/images/products/80512_polo-piquet-classica-054-pr-1615-0067587_z2_638122377654539294.jpg', 
'https://images.unsplash.com/photo-1584735175315-9d5df23860e6?w=400', 
'https://images.unsplash.com/photo-1582588678413-dbf45f4823e9?w=400');

-- Produto 20: Camisa Social Slim
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (20, 
'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmISaXBZdSO4LaeBFlhHzwBP1pjKeIphhDEQ&s', 
'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400', 
'https://images.unsplash.com/photo-1555274175-6cbdc399fe8e?w=400');

-- Produto 21: Camisa Xadrez Masculina
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (21, 
'https://http2.mlstatic.com/D_NQ_NP_2X_841044-MLB80018016887_102024-F-camisa-xadrez-masculina-manga-longa-lenhador-coleco-vero.webp', 
'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 
'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?w=400');

-- Produto 22: Camisa Manga Longa Linho
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (22, 
'https://cdn.awsli.com.br/2500x2500/1300/1300343/produto/131296244/myr-23-0924818-01jlks41ds.jpg', 
'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=400', 
'https://images.unsplash.com/photo-1600721391689-dd22fe5c8d52?w=400');

-- Produto 23: Camisa Estampada Tropical
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (23, 
'https://images.tcdn.com.br/img/img_prod/970725/camisa_manga_curta_estampa_tropical_14521_7_56a4b56ee92ab2d6b17c2ddcc7b66057.jpg', 
'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=400', 
'https://images.unsplash.com/photo-1573158268424-e3d4a3ba3e47?w=400');

-- Produto 24: Camisa Jeans Masculina
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (24, 
'https://lojasfirenzo.com/cdn/shop/files/S52c4bdec23fb4f43aa0e1d86e6694800U_800x.webp?v=1741104556', 
'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400', 
'https://images.unsplash.com/photo-1556906781-9a412961c28c?w=400');

-- Produto 25: Camisa Básica Algodão
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (25, 
'https://www.insiderstore.com.br/cdn/shop/files/Foto-01_5.png?v=1748540783&width=1206', 
'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=400', 
'https://images.unsplash.com/photo-1574408891259-26e3a2de251d?w=400');

-- Produto 26: Camisa Oversized Unissex
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (26, 
'https://acdn-us.mitiendanube.com/stores/417/579/products/aot2-534d96be503c736f2b17302525621006-1024-1024.png', 
'https://images.unsplash.com/photo-1586790170083-2f9ceadc732d?w=400', 
'https://images.unsplash.com/photo-1605733160314-4fc7dac4bb16?w=400');

-- Produto 27: Camisa Esportiva Dry
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (27, 
'https://www.lojamirante.com.br/uploads/dirImage/16/524x520_acf3fde08c45a2cf47a75b8c1a3c652a.webp', 
'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400', 
'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400');

-- Produto 28: Moletom Capuz Básico
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (28, 
'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiCJ8FDMTrgVuU0MCgiGVYQRRcr4OldWrWGA&s', 
'https://images.unsplash.com/photo-1556906781-9a412961c28c?w=400', 
'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=400');

-- Produto 29: Moletom Estampado Urbano
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (29, 
'https://www.calitta.com/8336-large_default/moletom-masculino-com-capuz-moda-swag-urbano-estampa-nas-mangas.jpg', 
'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=400', 
'https://images.unsplash.com/photo-1590736969955-71cc94901144?w=400');

-- Produto 30: Moletom Zíper Unissex
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (30, 
'https://down-br.img.susercontent.com/file/br-11134207-7r98o-lqml29k1vmsf54', 
'https://images.unsplash.com/photo-1573158268424-e3d4a3ba3e47?w=400', 
'https://images.unsplash.com/photo-1562157873-818bc0726f68?w=400');

-- Produto 31: Moletom Infantil Heróis
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (31, 
'https://images2.marisa.com.br/medias/sys_master/images/images/h7f/h32/16596741652510/CONJ-MOL-CAPUZ-SPIDEY-MESCLA-MESC-2-10057345314-C1.jpg', 
'https://images.unsplash.com/photo-1555274175-6cbdc399fe8e?w=400', 
'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400');

-- Produto 32: Moletom Flanelado
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (32, 
'https://m.media-amazon.com/images/I/61acfoZWEoL._AC_SX569_.jpg', 
'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400', 
'https://images.unsplash.com/photo-1467043237213-65f2da53396f?w=400');

-- Produto 33: Moletom Canguru Estilizado
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (33, 
'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx-Eqcg-SjCwKiDbM1l5ipO1M4az_XzdMc6g&s', 
'https://images.unsplash.com/photo-1605812830455-250e8ba25629?w=400', 
'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=400');

-- Produto 34: Moletom College Style
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (34, 
'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFrUfmBfwCrbFzXl9dYNoYK5z7FqPS2q-7zA&s', 
'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?w=400', 
'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?w=400');

-- Produto 35: Moletom Sem Capuz Slim
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (35, 
'https://santogato.com/161-large_default/jaqueta-social-de-moletom-masculino-slim-sem-capuz-estilo-elegante.jpg', 
'https://images.unsplash.com/photo-1588099768523-f4e6663fa9c8?w=400', 
'https://images.unsplash.com/photo-1537832816519-689ad163238b?w=400');

-- Produto 36: Moletom Gamer
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (36, 
'https://bemvestir.cdn.magazord.com.br/img/2023/03/produto/9551/16-0597-01.jpg?ims=fit-in/630x945/filters:fill(white)', 
'https://images.unsplash.com/photo-1607522370275-f14206abe5d3?w=400', 
'https://images.unsplash.com/photo-1560769629-d641e25e4a5e?w=400');

CREATE TABLE tb_comentario (
    cod_comentario INT PRIMARY KEY AUTO_INCREMENT,
    cod_produto INT NOT NULL,
    cod_usuario INT NOT NULL,
    texto_comentario TEXT NOT NULL,
    avaliacao INT CHECK (avaliacao BETWEEN 1 AND 5),
    data_comentario DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cod_produto) REFERENCES tb_produto(cod_produto),
    FOREIGN KEY (cod_usuario) REFERENCES tb_usuario(cod_usuario)
);