-- criar banco de dados
CREATE DATABASE GREENHOUSE;
-- definir bd como padrão/utilizavel
USE GREENHOUSE;
-- criar tabela
CREATE TABLE `PLANTS`(
	`PLANT_NAME`CHAR(30) NOT NULL,
    `SENSOR_VALUE` FLOAT default NULL,
    `SENSOR_EVENT` TIMESTAMP NOT NULL DEFAULT current_timestamp ON update current_timestamp,
    primary key `pk_plants`(`PLANT_NAME`)
    );
-- visualizar todas as orrencias em plants
-- listar todos os registro de dados
SELECT * FROM PLANTS;
-- seleciona colunas especificas
select PLANT_NAME, SENSOR_VALUE, SENSOR_EVENT FROM PLANTS;
-- inserir dados
INSERT INTO `PLANTS`(PLANT_NAME, SENSOR_VALUE)
VALUES('Rosa', 0.2319);
-- inserir multiplos 
INSERT INTO `PLANTS`(PLANT_NAME, SENSOR_VALUE)
VALUES  ('Cactus', 0.3451),
		('Margarida', 0.845),
	    ('Tulipa', 0.7485),
	    ('Samambaia', 0.1236);
        
-- consulta aplicando filtros
SELECT * FROM PLANTS WHERE PLANT_NAME = 'Rosa';
-- filtros compostos operadores and or xor ect
select * from PLANTS WHERE PLANT_NAME <> 'Lirio'
AND SENSOR_VALUE  < 0.5268
AND SENSOR_VALUE > 0.984;


