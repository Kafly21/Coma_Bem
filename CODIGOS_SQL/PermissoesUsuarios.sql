USE DB_COMA_BEM;

CREATE USER 'dev_comabem'@'localhost' IDENTIFIED BY 'SenhaForteDev123!';
CREATE USER 'suporte_comabem'@'localhost' IDENTIFIED BY 'SenhaForteSup456!';

GRANT SELECT, INSERT, UPDATE, DELETE
ON DB_COMA_BEM.* 
TO 'dev_comabem'@'localhost';

GRANT SELECT
ON DB_COMA_BEM.* 
TO 'suporte_comabem'@'localhost';

FLUSH PRIVILEGES;