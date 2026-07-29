USE coma_bem;

INSERT INTO usuario (usu_nm_usuario, usu_tx_email, usu_tx_senha) VALUES
('Carlos Silva', 'carlos@email.com', 'senha123'),
('Mariana Souza', 'mariana@email.com', 'senha456'),
('João Pereira', 'joao@email.com', 'senha789'),
('Fernanda Lima', 'fernanda@email.com', 'senha101'),
('Rafael Costa', 'rafael@email.com', 'senha102');

INSERT INTO restaurante (
    res_nm_restaurante,
    res_nu_latitude,
    res_nu_longitude,
    res_ds_tipo_culinaria
) VALUES
('Sushi House', '-23.550520', '-46.633308', 'Japonesa'),
('Cantina Bella Itália', '-23.561684', '-46.655981', 'Italiana'),
('Le Petit Bistrô', '-23.570123', '-46.641234', 'Francesa'),
('Churrascaria Boi Bom', '-23.582345', '-46.671234', 'Brasileira'),
('Taco Loco', '-23.590987', '-46.680123', 'Mexicana');

INSERT INTO prato (pra_nm_prato, pra_im_foto, pra_id_restaurante) VALUES
('Combinado Salmão', 'img/salmao.jpg', 1),
('Lasanha à Bolonhesa', 'img/lasanha.jpg', 2),
('Filet Mignon au Poivre', 'img/filet.jpg', 3),
('Picanha na Brasa', 'img/picanha.jpg', 4),
('Nachos Supremos', 'img/nachos.jpg', 5);

INSERT INTO avaliacao (avl_nu_ranking, avl_tx_recomendacao, avl_id_prato, avl_id_usuario) VALUES
(5, 'O peixe estava extremamente fresco, maravilhoso!', 1, 1),
(4, 'Massa muito boa, mas o molho podia ter mais tempero.', 2, 2),
(5, 'Carne no ponto perfeito, ambiente agradável.', 3, 3),
(3, 'A picanha estava um pouco dura hoje.', 4, 4),
(5, 'Melhor guacamole da cidade, muito bem servido!', 5, 5);