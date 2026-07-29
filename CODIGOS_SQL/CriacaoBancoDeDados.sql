CREATE DATABASE IF NOT EXISTS coma_bem;

USE coma_bem;

CREATE TABLE usuario (
    usu_id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    usu_nm_usuario VARCHAR(100) NOT NULL,
    usu_tx_email VARCHAR(100) NOT NULL UNIQUE,
    usu_tx_senha VARCHAR(255) NOT NULL
);

CREATE TABLE restaurante (
    res_id_restaurante INT AUTO_INCREMENT PRIMARY KEY,
    res_nm_restaurante VARCHAR(100) NOT NULL,
    res_nu_latitude VARCHAR(20) NOT NULL,
    res_nu_longitude VARCHAR(20) NOT NULL,
    res_ds_tipo_culinaria VARCHAR(50) NOT NULL
);

CREATE TABLE prato (
    pra_id_prato INT AUTO_INCREMENT PRIMARY KEY,
    pra_nm_prato VARCHAR(100) NOT NULL,
    pra_im_foto VARCHAR(255) NULL,
    pra_id_restaurante INT NOT NULL,

    FOREIGN KEY (pra_id_restaurante)
        REFERENCES restaurante(res_id_restaurante)
);

CREATE TABLE avaliacao (
    avl_id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    avl_nu_ranking INT NOT NULL,
    avl_tx_recomendacao TEXT NOT NULL,
    avl_id_prato INT NOT NULL,
    avl_id_usuario INT NOT NULL,

    CHECK (avl_nu_ranking >= 1 AND avl_nu_ranking <= 5),

    FOREIGN KEY (avl_id_prato)
        REFERENCES prato(pra_id_prato),

    FOREIGN KEY (avl_id_usuario)
        REFERENCES usuario(usu_id_usuario)
);