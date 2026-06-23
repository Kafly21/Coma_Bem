USE DB_COMA_BEM;

INSERT INTO TB_RESTAURANTES
(
  ID_RESTAURANTE
, RES_NOME
, RES_TIPO
, RES_LONGITUDE
, RES_LATITUDE
, RES_RANKING
)
VALUES
(1, 'Pizzaria Napoli', 'Italiana', '-46.6333', '-23.5505', 4.5),
(2, 'Sushi House', 'Japonesa', '-46.6388', '-23.5489', 4.7),
(3, 'Burger Kingo', 'Fast Food', '-46.6400', '-23.5510', 4.0),
(4, 'Churrascaria Fogo Vivo', 'Churrascaria', '-46.6350', '-23.5520', 4.8),
(5, 'Café Central', 'Cafeteria', '-46.6370', '-23.5490', 4.3);


INSERT INTO TB_AVALIACOES
(
  ID_AVALIACAO
, RES_ID
, RES_NOME
, RES_TIPO
, RES_RANKING
, AV_PRATO
, AV_PRATO_FOTO
, AV_RANKING
, AV_RECOMENDACAO
)
VALUES
(1, 1, 'Pizzaria Napoli', 'Italiana', 4.5, 'Pizza Margherita', NULL, 4.8, 'Muito boa, massa leve'),
(2, 2, 'Sushi House', 'Japonesa', 4.7, 'Rodízio Sushi', NULL, 4.9, 'Peixe fresco demais'),
(3, 3, 'Burger Kingo', 'Fast Food', 4.0, 'X-Burgão', NULL, 4.2, 'Bom e barato'),
(4, 4, 'Churrascaria Fogo Vivo', 'Churrascaria', 4.8, 'Picanha', NULL, 5.0, 'Carne perfeita'),
(5, 5, 'Café Central', 'Cafeteria', 4.3, 'Cappuccino', NULL, 4.6, 'Ótimo pra relaxar');

UPDATE TB_AVALIACOES
SET AV_RANKING = 4.7,
    AV_RECOMENDACAO = 'Melhorou muito, voltaria fácil'
WHERE ID_AVALIACAO = 3;

DELETE FROM TB_AVALIACOES
WHERE ID_AVALIACAO = 2;