-- Com base no exemplo executado em laboratório para o Banco de Dados UNOESC BANK, com relacionamentos de cardinalidade 1:N monte um script de BD para o seguinte problema:
-- Uma empresa veterinária deseja criar um simples banco de dados para armazenar os registros dos TIPOS_ANIMAIS que atende, podendo ser CANINOS, FELINOS, SUÍNOS, CAPRINOS, EQUINOS, ETC onde cada TIPO_ANIMAL poderá ter vários ANIMAIS, para cada animal, você deve armazenar (ID, NOME, ID_TIPO_ANIMAL, DT_NASCIMENTO, COR, PESO, ALTURA).
-- Além disso, o BD deve armazenar um histórico de vacinação, onde ANIMAL pode ter 'N' VACINAS. Para a tabela vacina, armazene (ID, NOME, DATA_APLICACAO, ID_ANIMAL [FK])

CREATE DATABASE VET_PET;
USE VET_PET;

CREATE TABLE TIPO_ANIMAL (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL
);

CREATE TABLE ANIMAL (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    DT_NASCIMENTO DATE NOT NULL,
    COR VARCHAR(255) NOT NULL,
    PESO FLOAT NOT NULL,
    ALTURA FLOAT NOT NULL,
    ID_TIPO_ANIMAL INT NOT NULL,
    CONSTRAINT FK_ID_TIPO_ANIMAL
        FOREIGN KEY (ID_TIPO_ANIMAL) REFERENCES TIPO_ANIMAL(ID)
);

CREATE TABLE VACINA (
    ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    DT_APLICACAO DATE NOT NULL,
    ID_ANIMAL INT NOT NULL,
    CONSTRAINT FK_ID_ANIMAL
        FOREIGN KEY (ID_ANIMAL) REFERENCES ANIMAL(ID)
);

INSERT INTO TIPO_ANIMAL (NOME) VALUES 
('CANINOS'),
('FELINOS'),
('SUÍNOS'),
('CAPRINOS'),
('EQUINOS'),
('EXÓTICOS');

-- Inserindo os animais
INSERT INTO ANIMAL (NOME, DT_NASCIMENTO, COR, PESO, ALTURA, ID_TIPO_ANIMAL) VALUES 
('Rex', '2020-03-15', 'Marrom', 25.5, 0.75, 1),
('Mimi', '2019-08-10', 'Cinza', 4.2, 0.25, 2),
('Bacon', '2021-05-22', 'Rosa', 100.3, 0.8, 3),
('Billy', '2018-11-30', 'Branco', 60.0, 0.9, 4),
('Spirit', '2017-07-18', 'Preto', 450.0, 1.5, 5),
('Rocky', '2022-02-14', 'Amarelo', 12.0, 0.5, 6);

-- Inserindo as vacinas
INSERT INTO VACINA (NOME, DT_APLICACAO, ID_ANIMAL) VALUES 
('Antirrábica', '2023-01-15', 1),
('V10', '2023-02-10', 1),
('Leucemia Felina', '2023-03-05', 2),
('Gripe Suína', '2023-04-01', 3),
('Carbúnculo', '2023-05-20', 4),
('Tétano', '2023-06-15', 5),
('Clostridial', '2023-07-10', 6);

-- EXECUTAR OS COMANDOS DA AULA DE 18/03

SELECT * FROM ANIMAL;

UPDATE ANIMAL SET NOME = 'Terry'
WHERE ID = 1;

DELETE FROM Vacina WHERE ID = 4;

-- com base, elabore consultas sql para responder:
-- 1 - quantidade de animais registrados no sistema?
-- 2 - qual total de vacina aplicadas registras no sistema?
-- 3 - quantos animais temos registrados para cada categoria?
-- 4 - qual a categoria de animais que recebeu mais vacinas?
USE VET_PET;
-- 1
SELECT COUNT(*) FROM ANIMAL;

-- 2
SELECT COUNT(*) FROM VACINA;

-- 3
SELECT T.NOME AS CATEGORIA, COUNT(A.ID) AS TOTAL_ANIMAIS
FROM TIPO_ANIMAL T
LEFT JOIN ANIMAL A ON T.ID = A.ID_TIPO_ANIMAL
GROUP BY T.NOME;

-- 4
SELECT T.NOME AS categoria, COUNT(V.ID) AS total_vacinas
FROM TIPO_ANIMAL T
LEFT JOIN ANIMAL A ON T.ID = A.ID_TIPO_ANIMAL
LEFT JOIN VACINA V ON A.ID = V.ID_ANIMAL
GROUP BY T.NOME
ORDER BY total_vacinas DESC
LIMIT 1;