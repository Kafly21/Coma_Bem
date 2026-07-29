SELECT res_nm_restaurante, res_ds_tipo_culinaria
FROM restaurante
WHERE res_ds_tipo_culinaria = 'Italiana';

SELECT p.pra_nm_prato, a.avl_nu_ranking, a.avl_tx_recomendacao
FROM avaliacao a
INNER JOIN prato p ON a.avl_id_prato = p.pra_id_prato
WHERE a.avl_nu_ranking = 5;

UPDATE avaliacao
SET avl_nu_ranking = 4,
    avl_tx_recomendacao = 'A carne estava boa, erro meu na avaliação anterior.'
WHERE avl_id_avaliacao = 4;

DELETE FROM avaliacao
WHERE avl_id_avaliacao = 5;