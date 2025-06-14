

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
    cod_produto INT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cod_usuario) REFERENCES tb_usuario(cod_usuario),
    FOREIGN KEY (cod_produto) REFERENCES tb_produto(cod_produto)
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
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (2, 'https://havaianas.com.br/cdn/shop/files/4148608-top-max-comfort-0090-0.jpg?v=1734128580&width=493');
-- Produto 3: Bota Adventure Pro
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (3, 'https://img.irroba.com.br/fit-in/500x500/filters:format(webp):fill(transparent):quality(80)/vntboeee/catalog/3101bbrown4.png');
-- Produto 4: Sapato Social Clássico
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (4, 'https://img.irroba.com.br/fit-in/600x600/filters:format(webp):fill(fff):quality(80)/bernaton/catalog/produtos/3098-laser-cafe-120191008093157.JPG');
-- Produto 5: Tênis Casual Urbano
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (5, 'https://static.zattini.com.br/produtos/sapato-masculino-democrata-oliver-social-classico-cadarco-couro-conforto-273202/06/D83-4415-006/D83-4415-006_zoom1.jpg?ts=1705309530&ims=1088x');
-- Produto 6: Sapatênis Versátil
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (6, 'https://pegada.vtexassets.com/arquivos/ids/190228-1200-1200?v=638821448799000000&width=1200&height=1200&aspect=true');
-- Produto 7: Sandália Masculina Couro
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (7, 'https://static.netshoes.com.br/produtos/sandalia-couro-pegada-nordeste-amortech-masculina/38/E21-1621-138/E21-1621-138_zoom1.jpg?ts=1695716647&ims=1088x');
-- Produto 8: Chuteira Society
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (8, 'https://static.netshoes.com.br/produtos/chuteira-society-adidas-deportivo-ii-unissex-exclusiva/70/FB9-4074-070/FB9-4074-070_zoom1.jpg?ts=1710336224&ims=1088x');
-- Produto 9: Tênis Infantil Light
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (9, 'https://static.netshoes.com.br/produtos/chuteira-society-adidas-deportivo-ii-unissex-exclusiva/70/FB9-4074-070/FB9-4074-070_zoom1.jpg?ts=1710336224&ims=1088x');

-- Fotos dos produtos camisas
-- Produto 19: Camisa Polo Clássica
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (10, 'https://d1zvfmhlebc91g.cloudfront.net/fit-in/0x0/filters:fill(ffffff)/filters:quality(98)/n49shopv2_spazziojeans/images/products/80512_polo-piquet-classica-054-pr-1615-0067587_z2_638122377654539294.jpg');

-- Produto 20: Camisa Social Slim
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (11, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmISaXBZdSO4LaeBFlhHzwBP1pjKeIphhDEQ&s');

-- Produto 21: Camisa Xadrez Masculina
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (12, 'https://http2.mlstatic.com/D_NQ_NP_2X_841044-MLB80018016887_102024-F-camisa-xadrez-masculina-manga-longa-lenhador-coleco-vero.webp');

-- Produto 22: Camisa Manga Longa Linho
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (13, 'https://cdn.awsli.com.br/2500x2500/1300/1300343/produto/131296244/myr-23-0924818-01jlks41ds.jpg');

-- Produto 23: Camisa Estampada Tropical
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (14, 'https://images.tcdn.com.br/img/img_prod/970725/camisa_manga_curta_estampa_tropical_14521_7_56a4b56ee92ab2d6b17c2ddcc7b66057.jpg');

-- Produto 24: Camisa Jeans Masculina
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (15, 'https://lojasfirenzo.com/cdn/shop/files/S52c4bdec23fb4f43aa0e1d86e6694800U_800x.webp?v=1741104556');

-- Produto 25: Camisa Básica Algodão
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (16, 'https://www.insiderstore.com.br/cdn/shop/files/Foto-01_5.png?v=1748540783&width=1206');

-- Produto 26: Camisa Oversized Unissex
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (17, 'https://acdn-us.mitiendanube.com/stores/417/579/products/aot2-534d96be503c736f2b17302525621006-1024-1024.png');

-- Produto 27: Camisa Esportiva Dry
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (18, 'https://www.lojamirante.com.br/uploads/dirImage/16/524x520_acf3fde08c45a2cf47a75b8c1a3c652a.webp');

-- Fotos dos produtos Bermudas
-- Produto 10: Bermuda Jeans Tradicional
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (19, 'https://img.ltwebstatic.com/images3_spmp/2023/09/15/c3/169472886264322ad34c6a0f5f2e8fbfed6680c59e_thumbnail_405x.webp');

-- Produto 11: Bermuda Moletom Basic
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (20, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyDmSKGwyIXKRbkZxa3YGszqXJMfMlkcw9PA&s');

-- Produto 12: Bermuda Sarja Slim
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (21, 'https://img.lojasrenner.com.br/item/563990870/original/13.jpg');

-- Produto 13: Bermuda Tática Militar
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (22, 'https://www.camagli.com.br/cdn/shop/products/5df9b61093ca13a7b9e5ba88fd2d749d_c65df500-b45c-4e19-af85-9040befa6c19_600x.jpg?v=1677986929');

-- Produto 14: Bermuda Surf Estampada
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (23, 'https://osklenbr.vteximg.com.br/arquivos/ids/582584/6837148828_BERMUDA-SURF-WAIKIKI_1.jpg?v=638684018951300000?w=681');

-- Produto 15: Bermuda Ciclista
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (24, 'https://http2.mlstatic.com/D_NQ_NP_2X_927133-MLB50610093789_072022-F-02-bermudas-ciclismo-bike-acolchoadas-profissional-promoco.webp');

-- Produto 16: Bermuda Cargo Masculina
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (25, 'https://montevie.com/cdn/shop/files/Se612dab0d405464e980500d5fe940477S_800x.webp?v=1725980789');

-- Produto 17: Bermuda Infantil Super-Heróis
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (26, 'https://grupokyly.vteximg.com.br/arquivos/ids/259643-1000-1000/1000363_3449_B.jpg?v=638700442640630000');

-- Produto 18: Bermuda Fitness DryFit
INSERT INTO tb_foto_produto (cod_produto, url) VALUES (27, 'https://www.gsuplementos.com.br/upload/produto/imagem/shorts-de-treino-growth-growth-supplements-1.webp');

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
'https://trackfield.vtexassets.com/arquivos/ids/254277-1200-1677?v=638052641501630000&width=1200&height=1677&aspect=true', 
'https://trackfield.vtexassets.com/arquivos/ids/254279-1200-1677?v=638052641803570000&width=1200&height=1677&aspect=true', 
'https://trackfield.vtexassets.com/arquivos/ids/254280-1200-1677?v=638052641898200000&width=1200&height=1677&aspect=true');

-- Produto 15: Bermuda Ciclista
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (15, 
'https://http2.mlstatic.com/D_NQ_NP_2X_775897-MLB74766388941_022024-F-bermuda-ciclismo-masculina-free-force-basic-preto.webp', 
'https://http2.mlstatic.com/D_NQ_NP_2X_743238-MLB74766388935_022024-F-bermuda-ciclismo-masculina-free-force-basic-preto.webp', 
'https://http2.mlstatic.com/D_NQ_NP_2X_628314-MLB74637267040_022024-F-bermuda-ciclismo-masculina-free-force-basic-preto.webp');

-- Produto 16: Bermuda Cargo Masculina
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (16, 
'https://montevie.com/cdn/shop/files/S623cc369829f4377b04df0cbbc81a842q_800x.webp?v=1725980792', 
'https://montevie.com/cdn/shop/files/Sd5ec47450dba485591ea8f46765add58r_800x.webp?v=1725980792', 
'https://montevie.com/cdn/shop/files/S857d499874384c15aa34067f9e94e253R_800x.webp?v=1725980789');

-- Produto 17: Bermuda Infantil Super-Heróis
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (17, 
'https://torratorra.vteximg.com.br/arquivos/ids/2253328-960-1200/352310001310938.jpg?v=638751963212330000', 
'https://torratorra.vteximg.com.br/arquivos/ids/2253330-960-1200/352310001310938.jpg?v=638751963249270000', 
'https://torratorra.vteximg.com.br/arquivos/ids/2253331-960-1200/352310001310938.jpg?v=638751963267670000');

-- Produto 18: Bermuda Fitness DryFit
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (18, 
'https://www.gsuplementos.com.br/upload/produto/imagem/shorts-de-treino-growth-growth-supplements-1.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/79/524x520_5d8d0a4306572d488c540caaca4b2e96.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/79/524x520_b7d52b94d17cb6090e8d1256f93a4ec7.webp');

-- Produto 19: Camisa Polo Clássica
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (19, 
'https://www.lojamirante.com.br/uploads/dirImage/72/524x520_eadef02a1ebe6e3ec549effb71d84405.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/72/524x520_7cdaa0141bad87d5b86a32822c4ad699.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/18/524x520_3608ba4ce30e1c8d56d8190daa05a821.webp');

-- Produto 20: Camisa Social Slim
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (20, 
'https://m.media-amazon.com/images/I/51hiHWUJyIL._AC_SX522_.jpg', 
'https://m.media-amazon.com/images/I/51bT9bazBLL._AC_SX522_.jpg', 
'https://m.media-amazon.com/images/I/51ar8SsnP3L._AC_SX522_.jpg');

-- Produto 21: Camisa Xadrez Masculina
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (21, 
'https://www.youcom.com.br/_next/image?url=https%3A%2F%2Fimg.youcom.com.br%2FCustom%2FContent%2FProducts%2F11%2F44%2F1144846_camisa-ml-over-xadrez-101225276_z5_638814527944883203.webp&w=1080&q=100', 
'https://www.youcom.com.br/_next/image?url=https%3A%2F%2Fimg.youcom.com.br%2FCustom%2FContent%2FProducts%2F11%2F44%2F1144846_camisa-ml-over-xadrez-101225276_z4_638814527919569955.webp&w=1080&q=100', 
'https://www.youcom.com.br/_next/image?url=https%3A%2F%2Fimg.youcom.com.br%2FCustom%2FContent%2FProducts%2F11%2F44%2F1144846_camisa-ml-over-xadrez-101225276_z1_638814527846356986.webp&w=1080&q=100');

-- Produto 22: Camisa Manga Longa Linho
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (22, 
'https://sergiok.vtexassets.com/arquivos/ids/160408/01.01.0119.070-CAMISA-LINHO-CASUAL-AMARELA-6289.jpg?v=638337730633530000', 
'https://sergiok.vtexassets.com/arquivos/ids/160409/01.01.0119.070-CAMISA-LINHO-CASUAL-AMARELA-6295.jpg?v=638337731018500000', 
'https://sergiok.vtexassets.com/arquivos/ids/160411/01.01.0119.070-CAMISA-LINHO-CASUAL-AMARELA-6287.jpg?v=638337731368100000');

-- Produto 23: Camisa Estampada Tropical
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (23, 
'https://lojausereserva.vtexassets.com/arquivos/ids/7212382-1200-auto?v=638042223161600000&width=1200&height=auto&aspect=true', 
'https://lojausereserva.vtexassets.com/arquivos/ids/7212380-1200-auto?v=638042223161300000&width=1200&height=auto&aspect=true', 
'https://lojausereserva.vtexassets.com/arquivos/ids/7212389-1200-auto?v=638042223162070000&width=1200&height=auto&aspect=true');

-- Produto 24: Camisa Jeans Masculina
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (24, 
'https://img.ltwebstatic.com/images3_spmp/2024/08/27/14/1724689424f9ad38123ba9cd96fe5a06b136c1196e_thumbnail_405x.webp', 
'https://img.ltwebstatic.com/images3_spmp/2024/08/27/14/17246894247cb1912ecf3627e1807f78b392174240_thumbnail_560x.webp', 
'https://img.ltwebstatic.com/images3_spmp/2024/08/27/14/172468942407a8ed4406c1f786a4818266fed89025_thumbnail_560x.webp');

-- Produto 25: Camisa Básica Algodão
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (25, 
'https://www.lojamirante.com.br/uploads/dirImage/14/524x520_8936500b9f0cd4f08502b834a013f80d.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/14/524x520_5e423dba7c7ee468524f7b1af9053910.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/115/524x520_dd0888f385b85653dcf1b518e81c2a5f.webp');

-- Produto 26: Camisa Oversized Unissex
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (26, 
'https://img.ltwebstatic.com/v4/j/spmp/2025/04/26/d2/174563308529471cef5ad13a91dc7ca33412ccf7cf_thumbnail_405x.webp', 
'https://img.ltwebstatic.com/v4/j/spmp/2025/04/26/0f/174563298203704983417d348fcc1616101f4ca66e_thumbnail_560x.webp', 
'https://img.ltwebstatic.com/v4/j/spmp/2025/04/26/a3/1745632982b2d0a7b68a47589e3d39599195b539bb_thumbnail_560x.webp');

-- Produto 27: Camisa Esportiva Dry
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (27, 
'https://www.lojamirante.com.br/uploads/dirImage/16/524x520_d96afacb3e538b5a29264afe14d0d401.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/16/524x520_ac001871013b5a6764f5b072267c8915.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/16/524x520_417b8972298388be68431e1517a835eb.webp');

-- Produto 28: Moletom Capuz Básico
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (28, 
'https://www.lojamirante.com.br/uploads/dirImage/24/524x520_f87bbc418045ad957040230177ece286.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/24/524x520_60a5354e9408e71b1b469f0f35b08511.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/24/524x520_5402f5ae80d15f2c706addf3d3995170.webp');

-- Produto 29: Moletom Estampado Urbano
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (29, 
'https://d3vnyi5j6ba1mc.cloudfront.net/Custom/Content/Products/17/01/1701035_blusao-moletom-estampado-410100693_z1_638344481028985241.webp', 
'https://d3vnyi5j6ba1mc.cloudfront.net/Custom/Content/Products/17/01/1701035_blusao-moletom-estampado-410100693_z2_638344481057528485.webp', 
'https://d3vnyi5j6ba1mc.cloudfront.net/Custom/Content/Products/17/01/1701035_blusao-moletom-estampado-410100693_z3_638344481085007438.webp');

-- Produto 30: Moletom Zíper Unissex
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (30, 
'https://m.media-amazon.com/images/I/61acfoZWEoL._AC_SX466_.jpg', 
'https://m.media-amazon.com/images/I/61XYL6agLgL._AC_SY606_.jpg', 
'https://m.media-amazon.com/images/I/61rEB5C4drL._AC_SY606_.jpg');

-- Produto 31: Moletom Infantil Heróis
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (31, 
'https://brandili.vtexassets.com/arquivos/ids/516016-1172-1570/55815_1623_0001.jpg?v=638823124563570000', 
'https://brandili.vtexassets.com/arquivos/ids/519647-1172-1570/55815_1623_0002.jpg?v=638823135834770000', 
'https://brandili.vtexassets.com/arquivos/ids/522139-1172-1570/55815_1623_0003.jpg?v=638823146428330000');

-- Produto 32: Moletom Flanelado
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (32, 
'https://basicamente.com/cdn/shop/files/100011877400237-L1.jpg?v=1713441203&width=1445', 
'https://basicamente.com/cdn/shop/files/100011877400237-L2.jpg?v=1713441203&width=1445', 
'https://basicamente.com/cdn/shop/files/100011877400237-L4.jpg?v=1713441203&width=1445');

-- Produto 33: Moletom Canguru Estilizado
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (33, 
'https://img.ltwebstatic.com/images3_spmp/2024/07/11/1b/17207114943af2e1de487ca3bc8d9b4db6f3487a4b_thumbnail_405x.webp', 
'https://img.ltwebstatic.com/images3_spmp/2024/07/11/b7/17207115457d65827a7653139d44a9d52ea148388b_thumbnail_560x.webp', 
'https://img.ltwebstatic.com/images3_spmp/2024/07/11/98/1720711666c427efe49f3efbdc128d321d7a166433_thumbnail_560x.webp');

-- Produto 34: Moletom College Style
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (34, 
'https://img.ltwebstatic.com/images3_pi/2023/10/11/99/16970125654f9ac03eca793ec40338ea0aa2ea6664_thumbnail_405x.webp', 
'https://img.ltwebstatic.com/images3_pi/2023/10/11/80/169701256758c6391542b7a3159b5ce86b3fd961ee_thumbnail_560x.webp', 
'https://img.ltwebstatic.com/images3_pi/2023/10/11/8a/169701256995faaaeab70bfd27190a169dd8f540e6_thumbnail_560x.webp');

-- Produto 35: Moletom Sem Capuz Slim
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (35, 
'https://www.lojamirante.com.br/uploads/dirImage/23/524x520_1950310633fc8170285e8ebc4722e86f.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/23/524x520_530570e18cb0d90055b514c2b91e108d.webp', 
'https://www.lojamirante.com.br/uploads/dirImage/23/524x520_df8354003457cb835e022fecc8c22447.webp');

-- Produto 36: Moletom Gamer
INSERT INTO tb_produto_detalhado (cod_produto, url_foto1, url_foto2, url_foto3)
VALUES (36, 
'https://img.ltwebstatic.com/images3_pi/2024/12/04/4e/17333043245fa2f4fdfe00c07295365bd25040e5f3_thumbnail_405x.webp', 
'https://img.ltwebstatic.com/images3_pi/2024/07/19/b6/1721360471dc94faeb872ede800d4d4ff77803c853_thumbnail_560x.webp', 
'https://img.ltwebstatic.com/images3_pi/2024/07/19/7f/17213604868d55fe7058b35c7731e280c10e28adf5_thumbnail_560x.webp');


-- Fotos dos produtos Moletons, só mostrar todos os produtos 
SELECT p.cod_produto, p.nome, p.descricao, p.preco, f.url AS imagem_principal,
                d.url_foto1, d.url_foto2, d.url_foto3
            FROM tb_produto p
            LEFT JOIN tb_foto_produto f ON p.cod_produto = f.cod_produto
            LEFT JOIN tb_produto_detalhado d ON p.cod_produto = d.cod_produto
            WHERE p.cod_categoria = 0;


