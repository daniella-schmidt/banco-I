INSERT INTO Funcionarios (matricula, nome, data_nascimento, nacionalidade, sexo, estado_civil, rg, cpf, data_admissao, id_endereco_atual)  
VALUES   
(1, 'Carlos Oliveira', '1990-07-15', 'Brasileira', 'Masculino', 'Casado', '12.345.678-9', '111.222.333-44', '2020-05-10', NULL),
(2, 'Fernanda Souza', '1985-09-22', 'Brasileira', 'Feminino', 'Solteiro', '98.765.432-1', '444.333.222-11', '2018-02-03', NULL),
(3, 'Roberto Silva', '1982-11-30', 'Brasileira', 'Masculino', 'Casado', '45.678.912-3', '555.666.777-88', '2015-06-15', NULL),
(4, 'Juliana Costa', '1993-03-25', 'Brasileira', 'Feminino', 'Solteiro', '32.165.498-7', '999.888.777-66', '2021-08-20', NULL);

INSERT INTO Enderecos (matricula, logradouro, numero, complemento, bairro, cidade, estado, cep)
VALUES 
(1, 'Rua das Palmeiras', '120', 'Apto 301', 'Centro', 'São Paulo', 'SP', '01010-000'),
(1, 'Avenida Paulista', '1000', 'Apto 1500', 'Bela Vista', 'São Paulo', 'SP', '01310-000'),

(2, 'Avenida Brasil', '456', NULL, 'Jardim América', 'Rio de Janeiro', 'RJ', '22030-001'),

(3, 'Rua dos Coqueiros', '789', 'Casa 2', 'Praia do Sol', 'Salvador', 'BA', '40000-000'),
(3, 'Rua das Flores', '500', 'Bloco B', 'Barra', 'Salvador', 'BA', '40140-000'),

(4, 'Rua das Acácias', '300', NULL, 'Jardim Botânico', 'Curitiba', 'PR', '80210-000');

UPDATE Funcionarios SET id_endereco_atual = 1 WHERE matricula = 1;  -- Primeiro endereço do Carlos
UPDATE Funcionarios SET id_endereco_atual = 3 WHERE matricula = 2;  -- Endereço da Fernanda
UPDATE Funcionarios SET id_endereco_atual = 4 WHERE matricula = 3;  -- Primeiro endereço do Roberto
UPDATE Funcionarios SET id_endereco_atual = 6 WHERE matricula = 4;  -- Endereço da Juliana

INSERT INTO Departamento (matricula, nome_dp, data_inicio, data_fim)
VALUES 
(1, 'Segurança do Trabalho', '2020-05-10', NULL),
(2, 'Saúde Ocupacional', '2018-02-03', NULL),
(3, 'Recursos Humanos', '2015-06-15', NULL),
(4, 'Tecnologia da Informação', '2021-08-20', NULL);

INSERT INTO Cargos (matricula, cargo, data_inicio, data_fim)
VALUES 
(1, 'Analista de Segurança', '2020-05-10', '2023-06-20'),
(1, 'Coordenador de Segurança', '2023-06-21', NULL),
(2, 'Engenheira de Saúde Ocupacional', '2018-02-03', NULL),
(3, 'Analista de RH', '2015-06-15', '2020-01-01'),
(3, 'Gerente de RH', '2020-01-02', NULL),
(4, 'Desenvolvedor Front-end', '2021-08-20', '2023-12-31'),
(4, 'Desenvolvedor Full-stack', '2024-01-01', NULL);

INSERT INTO Dependentes (matricula, nome, data_nascimento, tipo)
VALUES 
(1, 'Pedro Oliveira', '2015-09-10', 'Filho'),
(1, 'Mariana Oliveira', '2012-05-15', 'Filho'),
(1, 'Sofia Oliveira', '2018-11-03', 'Filho'),

(2, 'Ana Souza', '2017-04-25', 'Filho'),

(3, 'Lucas Silva', '2010-12-05', 'Filho'),
(3, 'Laura Silva', '2013-07-20', 'Filho'),

(4, 'Gabriel Costa', '2018-03-12', 'Filho'),
(4, 'Isabela Costa', '2020-08-22', 'Filho');

-- Consulta final mostrando todos os relacionamentos
SELECT 
    f.matricula,
    f.nome AS funcionario,
    DATE_FORMAT(f.data_nascimento, '%d/%m/%Y') AS data_nascimento,
    f.nacionalidade,
    f.sexo,
    f.estado_civil,
    f.rg,
    f.cpf,
    DATE_FORMAT(f.data_admissao, '%d/%m/%Y') AS data_admissao,
    CONCAT(e.logradouro, ', ', e.numero, IFNULL(CONCAT(' - ', e.complemento), '')) AS endereco,
    e.bairro,
    e.cidade,
    e.estado,
    e.cep,
    d.nome_dp AS departamento,
    DATE_FORMAT(d.data_inicio, '%d/%m/%Y') AS depto_inicio,
    IFNULL(DATE_FORMAT(d.data_fim, '%d/%m/%Y'), 'Atual') AS depto_fim,
    c.cargo,
    DATE_FORMAT(c.data_inicio, '%d/%m/%Y') AS cargo_inicio,
    IFNULL(DATE_FORMAT(c.data_fim, '%d/%m/%Y'), 'Atual') AS cargo_fim,
    (SELECT GROUP_CONCAT(CONCAT(dep.nome, ' (', dep.tipo, ')') SEPARATOR ', ') 
     FROM Dependentes dep 
     WHERE dep.matricula = f.matricula) AS dependentes
FROM Funcionarios f
LEFT JOIN Enderecos e ON f.id_endereco_atual = e.id
LEFT JOIN Departamento d ON f.matricula = d.matricula AND d.data_fim IS NULL
LEFT JOIN Cargos c ON f.matricula = c.matricula AND c.data_fim IS NULL
ORDER BY f.matricula;