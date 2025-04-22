USE Simposio;

INSERT INTO Simposio (Nome, Data, Local, Data_Inicio, Data_Fim) 
VALUES 
    ('Encontro de Inovação 2025', '2025-06-01', 'Instituto de Tecnologia', '2025-06-01', '2025-06-03');

INSERT INTO Pessoa (Nome, Instituicao) 
VALUES 
    ('Lucas Almeida', 'Instituto de Tecnologia'),
    ('Fernanda Costa', 'Universidade Nacional'),
    ('Ricardo Lima', 'Instituto de Pesquisa'),
    ('Juliana Santos', 'Universidade do Centro'),
    ('Thiago Martins', 'Faculdade de Engenharia'),
    ('Camila Ferreira', 'Instituto de Tecnologia'),
    ('André Oliveira', 'Universidade Nacional'),
    ('Patrícia Rocha', 'Universidade do Norte'),
    ('Felipe Mendes', 'Instituto de Pesquisa'),
    ('Bianca Silva', 'Universidade do Centro');

INSERT INTO Organizacao (Id_Simposio, Id_Pessoa) 
VALUES 
    (1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
    (1, 6), (1, 7), (1, 8), (1, 9), (1, 10);

INSERT INTO Tema (Nome) 
VALUES 
    ('Sistemas de Informação'),
    ('Comunicações'),
    ('Aprendizado de Máquina'),
    ('Proteção de Dados'),
    ('Desenvolvimento Ágil'),
    ('Infraestrutura em Nuvem'),
    ('Simulação Virtual'),
    ('Análise de Dados'),
    ('Conectividade Inteligente'),
    ('Arquitetura de Software');

INSERT INTO Comissao (Id_Tema) 
VALUES 
    (1), (2), (3), (4), (5),
    (6), (7), (8), (9), (10);

INSERT INTO Membro_Comissao (Id_Comissao, Id_Pessoa) 
VALUES 
    (1, 1), (1, 7), (2, 2), (3, 7), (4, 1),
    (5, 2), (6, 7), (7, 1), (8, 2), (9, 7);

INSERT INTO Artigo (Titulo, Id_Tema, Data_Submissao) 
VALUES 
    ('Fundamentos de NoSQL', 1, '2025-04-01'),
    ('Segurança em Redes Avançadas', 2, '2025-04-02'),
    ('Inovações em IA', 3, '2025-04-03'),
    ('Criptografia Atual', 4, '2025-04-04'),
    ('Práticas Ágeis', 5, '2025-04-05'),
    ('Arquitetura de Nuvem', 6, '2025-04-06'),
    ('Experiências em Realidade Aumentada', 7, '2025-04-07'),
    ('Exploração de Big Data', 8, '2025-04-08'),
    ('IoT em Ambientes Urbanos', 9, '2025-04-09'),
    ('Modelos de Design de Software', 10, '2025-04-10');

-- Inserindo dados na tabela Autor
INSERT INTO Autor (Id_Pessoa, Id_Artigo) 
VALUES 
    (3, 1), (6, 1), (3, 2), (9, 3), (6, 4),
    (3, 5), (9, 6), (6, 7), (3, 8), (9, 9);

-- Inserindo dados na tabela Parecer
INSERT INTO Parecer (Id_Artigo, Id_Comissao, Status, Descricao, Data_Emissao) 
VALUES 
    (1, 1, 'Aprovado com modificações', 'Aprovado com modificações', '2025-04-15'),
    (2, 2, 'Aprovado', 'Aprovado', '2025-04-16'),
    (3, 3, 'Rejeitado', 'Rejeitado', '2025-04-17'),
    (4, 4, 'Aprovado com modificações', 'Aprovado com modificações', '2025-04-18'),
    (5, 5, 'Aprovado', 'Aprovado', '2025-04-19'),
    (6, 6, 'Rejeitado', 'Rejeitado', '2025-04-20'),
    (7, 7, 'Aprovado com modificações', 'Aprovado com modificações', '2025-04-21'),
    (8, 8, 'Aprovado', 'Aprovado', '2025-04-22'),
    (9, 9, 'Rejeitado', 'Rejeitado', '2025-04-23'),
    (10, 10, 'Aprovado', 'Aprovado', '2025-04-24');

-- Inserindo dados na tabela Minicurso
INSERT INTO Minicurso (Nome, Id_Simposio, Id_Ministrante, Data, Horario) 
VALUES 
    ('Workshop de SQL', 1, 2, '2025-06-01', '09:00:00'),
    ('Workshop de Redes', 1, 5, '2025-06-01', '14:00:00'),
    ('Workshop de IA', 1, 2, '2025-06-02', '09:00:00'),
    ('Workshop de Segurança', 1, 5, '2025-06-02', '14:00:00'),
    ('Workshop de Nuvem', 1, 2, '2025-06-03', '09:00:00'),
    ('Workshop de Realidade Aumentada', 1, 5, '2025-06-03', '14:00:00'),
    ('Workshop de Big Data', 1, 2, '2025-06-01', '16:00:00'),
    ('Workshop de IoT', 1, 5, '2025-06-02', '16:00:00'),
    ('Workshop de Software', 1, 2, '2025-06-03', '16:00:00'),
    ('Workshop de Design', 1, 5, '2025-06-01', '11:00:00');

INSERT INTO Palestra (Nome, Id_Ministrante, Id_Simposio, Data, Horario) 
VALUES 
    ('Palestra sobre IA Avançada', 2, 1, '2025-06-01', '10:00:00'),
    ('Palestra sobre Redes Futuras', 5, 1, '2025-06-01', '15:00:00'),
    ('Palestra sobre Nuvem e suas Aplicações', 2, 1, '2025-06-02', '10:00:00'),
    ('Palestra sobre Segurança Digital', 5, 1, '2025-06-02', '15:00:00'),
    ('Palestra sobre Big Data e Análise', 2, 1, '2025-06-03', '10:00:00'),
    ('Palestra sobre IoT e Cidades Inteligentes', 5, 1, '2025-06-03', '15:00:00'),
    ('Palestra sobre Desenvolvimento de Software', 2, 1, '2025-06-01', '17:00:00'),
    ('Palestra sobre Design de Software', 5, 1, '2025-06-02', '17:00:00'),
    ('Palestra sobre Realidade Aumentada e Virtual', 2, 1, '2025-06-03', '17:00:00'),
    ('Palestra sobre Sistemas de Informação', 5, 1, '2025-06-01', '12:00:00');

INSERT INTO Inscricao_Minicurso (Id_Inscricao, Id_Minicurso, Data_Inscricao)  
VALUES 
    (1, 1, '2025-04-01'), (1, 3, '2025-04-01'), (1, 5, '2025-04-01'),   -- 3 minicursos
    (2, 2, '2025-04-02'),                                              -- 1 minicurso
    (3, 1, '2025-04-03'), (3, 4, '2025-04-03'), (3, 6, '2025-04-03'), (3, 8, '2025-04-03'), -- 4 minicursos
    (5, 7, '2025-04-05'), (5, 9, '2025-04-05'),                        -- 2 minicursos
    (6, 10, '2025-04-06'),                                             -- 1 minicurso
    (7, 2, '2025-04-07'), (7, 3, '2025-04-07'),                        -- 2 minicursos
    (8, 4, '2025-04-08'),                                              -- 1 minicurso
    (9, 5, '2025-04-09')                                               -- 1 minicurso
; -- 15 registros

INSERT INTO Inscricao_Palestra (Id_Inscricao, Id_Palestra, Data_Inscricao) 
VALUES 
    (1, 1, '2025-04-01'), (1, 3, '2025-04-01'),           -- 2 palestras
    (2, 2, '2025-04-02'), (2, 4, '2025-04-02'), (2, 6, '2025-04-02'),   -- 3 palestras
    (3, 5, '2025-04-03'),                               -- 1 palestra
    (4, 1, '2025-04-04'), (4, 7, '2025-04-04'), (4, 8, '2025-04-04'), (4, 9, '2025-04-04'), -- 4 palestras
    (6, 3, '2025-04-06'), (6, 10, '2025-04-06'),          -- 2 palestras
    (7, 2, '2025-04-07'),                               -- 1 palestra
    (8, 4, '2025-04-08'),                               -- 1 palestra
    (9, 6, '2025-04-09')                                -- 1 palestra
; -- 15 registros

INSERT INTO Inscricao_Palestra (Id_Inscricao, Id_Palestra, Data_Inscricao) 
VALUES 
<<<<<<< HEAD
    (2, 1, '2025-04-01'); 
=======
    (2, 1, '2025-04-01'); -- Supondo que a pessoa com Id 2 é o ministrante da palestra com Id 1
>>>>>>> 5476b47d6aeeffcd95e52e68fa195cd682ff0012
