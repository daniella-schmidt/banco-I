USE FICHA_MEDICA;

INSERT INTO Nacionalidade (id, nome) VALUES
(1, 'Brasileiro'),
(2, 'Argentino'),
(3, 'Chileno'),
(4, 'Uruguaio'),
(5, 'Paraguaio'),
(6, 'Colombiano'),
(7, 'Peruano'),
(8, 'Venezuelano'),
(9, 'Equatoriano'),
(10, 'Boliviano'),
(11, 'Alemão');

-- Inserindo sexos
INSERT INTO Sexo (id, nome) VALUES
(1, 'Masculino'),
(2, 'Feminino'),
(3, 'Não Binário'),
(4, 'Outro');

INSERT INTO Estado_Civil (id, nome) VALUES
(1, 'Solteiro'),
(2, 'Casado'),
(3, 'Divorciado'),
(4, 'Viúvo'),
(5, 'União Estável');

INSERT INTO Tipo_Convenio (id, tipo) VALUES
(1, 'Unimed'),
(2, 'Amil'),
(3, 'SulAmérica'),
(4, 'Bradesco Saúde'),
(5, 'NotreDame Intermédica'),
(6, 'Hapvida'),
(7, 'Particular'),
(8, 'Golden Cross'),
(9, 'Medial Saúde');

INSERT INTO Medico (crm, nome, especialidade) VALUES
(12345, 'Carlos Silva', 'Cardiologia'),
(23456, 'Ana Oliveira', 'Pediatria'),
(34567, 'André Pacheco', 'Ortopedia'),
(45678, 'Julia Santos', 'Ginecologia'),
(56789, 'Roberto Martins', 'Clínico Geral'),
(67890, 'Fernando Costa', 'Dermatologia'),
(78901, 'Paula Latejando', 'Neurologia'),
(89012, 'Pedro Albuquerque', 'Oftalmologia'),
(90123, 'Beatriz Bonita', 'Psiquiatria'),
(11223, 'Raquel Morais', 'Endocrinologia'),
(22334, 'Lucas Mendes', 'Otorrinolaringologista');

INSERT INTO Tipo_Exame (id, nome) VALUES
(1, 'Hemograma Completo'),
(2, 'Glicemia em Jejum'),
(3, 'Colesterol Total'),
(4, 'Triglicerídeos'),
(5, 'TSH e T4 Livre'),
(6, 'Eletrocardiograma'),
(7, 'Ecocardiograma'),
(8, 'Ultrassonografia Abdominal'),
(9, 'Radiografia de Tórax'),
(10, 'Ressonância Magnética'),
(11, 'Tomografia Computadorizada');

INSERT INTO Paciente (nmr_paciente, nome, data_nascimento, id_nacionalidade, id_sexo, id_estado_civil, rg, cpf, telefone, id_convenio) VALUES
(1, 'João da Silva', '1980-05-15', 1, 1, 2, '123456789', '11122233344', '(11) 9999-8888', 1),
(2, 'Maria Oliveira', '1975-08-22', 1, 2, 2, '234567891', '22233344455', '(11) 8888-7777', 2),
(3, 'Carlos Pereira', '1990-03-10', 1, 1, 1, '345678912', '33344455566', '(11) 7777-6666', 3),
(4, 'Ana Santos', '1985-11-28', 2, 2, 3, '456789123', '44455566677', '(11) 6666-5555', 4),
(5, 'Pedro Costa', '1972-07-03', 1, 1, 5, '567891234', '55566677788', '(11) 5555-4444', 5),
(6, 'Juliana Almeida', '1995-02-18', 1, 2, 1, '678912345', '66677788899', '(11) 4444-3333', 6),
(7, 'Marcos Souza', '1988-09-25', 3, 1, 2, '789123456', '77788899900', '(11) 3333-2222', 7),
(8, 'Fernanda Lima', '1978-12-05', 1, 2, 4, '891234567', '88899900011', '(11) 2222-1111', 8),
(9, 'Ricardo Gomes', '1965-06-30', 4, 1, 3, '912345678', '99900011122', '(11) 1111-0000', 9),
(10, 'Patrícia Rocha', '1992-04-12', 1, 2, 4, '987654321', '00011122233', '(11) 9999-0000', 5),
(11, 'Lucas Mendes', '1983-01-20', 1, 1, 2, '876543219', '12312312312', '(11) 8888-9999', 1);

INSERT INTO Enderecos (id, paciente, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1, 1, 'Rua das Flores', '100', 'Apto 101', 'Centro', 'São Paulo', 'SP', '01001-000'),
(2, 2, 'Avenida Paulista', '2000', '10º andar', 'Bela Vista', 'São Paulo', 'SP', '01310-200'),
(3, 3, 'Rua Augusta', '300', '', 'Consolação', 'São Paulo', 'SP', '01304-000'),
(4, 4, 'Alameda Santos', '400', 'Sala 5', 'Jardim Paulista', 'São Paulo', 'SP', '01418-000'),
(5, 5, 'Rua Oscar Freire', '500', '', 'Cerqueira César', 'São Paulo', 'SP', '01426-000'),
(6, 6, 'Avenida Brigadeiro Faria Lima', '600', 'Conj 32', 'Pinheiros', 'São Paulo', 'SP', '05426-200'),
(7, 7, 'Rua Haddock Lobo', '700', '', 'Cerqueira César', 'São Paulo', 'SP', '01414-000'),
(8, 8, 'Rua Bela Cintra', '800', 'Apto 302', 'Consolação', 'São Paulo', 'SP', '01415-000'),
(9, 9, 'Avenida Rebouças', '900', '', 'Pinheiros', 'São Paulo', 'SP', '05402-000'),
(10, 10, 'Rua da Consolação', '1000', '5º andar', 'Consolação', 'São Paulo', 'SP', '01301-000'),
(11, 11, 'Rua Frei Caneca', '1100', '', 'Consolação', 'São Paulo', 'SP', '01307-000');

-- Atualizar pacientes com os endereços
UPDATE Paciente SET id_endereco_atual = 1 WHERE nmr_paciente = 1;
UPDATE Paciente SET id_endereco_atual = 2 WHERE nmr_paciente = 2;
UPDATE Paciente SET id_endereco_atual = 3 WHERE nmr_paciente = 3;
UPDATE Paciente SET id_endereco_atual = 4 WHERE nmr_paciente = 4;
UPDATE Paciente SET id_endereco_atual = 5 WHERE nmr_paciente = 5;
UPDATE Paciente SET id_endereco_atual = 6 WHERE nmr_paciente = 6;
UPDATE Paciente SET id_endereco_atual = 7 WHERE nmr_paciente = 7;
UPDATE Paciente SET id_endereco_atual = 8 WHERE nmr_paciente = 8;
UPDATE Paciente SET id_endereco_atual = 9 WHERE nmr_paciente = 9;
UPDATE Paciente SET id_endereco_atual = 10 WHERE nmr_paciente = 10;
UPDATE Paciente SET id_endereco_atual = 11 WHERE nmr_paciente = 11;

-- Inserindo consultas
INSERT INTO Consultas (nmr_consulta, data, id_medico, id_paciente, diagnostico) VALUES
(1, '2023-01-10', 12345, 1, 'Hipertensão arterial estágio 1'),
(2, '2023-01-12', 23456, 2, 'Consulta de rotina pediátrica'),
(3, '2023-01-15', 34567, 3, 'Lombalgia mecânica'),
(4, '2023-01-18', 45678, 4, 'Consulta pré-natal'),
(5, '2023-01-20', 56789, 5, 'Diabetes tipo 2'),
(6, '2023-01-22', 67890, 6, 'Dermatite atópica'),
(7, '2023-01-25', 78901, 7, 'Cefaleia tensional'),
(8, '2023-01-28', 89012, 8, 'Miopia progressiva'),
(9, '2023-02-01', 90123, 9, 'Transtorno de ansiedade'),
(10, '2023-02-05', 11223, 10, 'Hipotireoidismo'),
(11, '2023-02-10', 22334, 11, 'Infecção urinária');

-- Inserindo exames
INSERT INTO Exame (nrm_exame, nrm_consulta, tipo_exame, data) VALUES
(1, 1, 6, '2023-01-11'),
(2, 1, 1, '2023-01-11'),
(3, 2, 1, '2023-01-13'),
(4, 3, 9, '2023-01-16'),
(5, 4, 8, '2023-01-19'),
(6, 5, 2, '2023-01-21'),
(7, 5, 3, '2023-01-21'),
(8, 5, 4, '2023-01-21'),
(9, 6, 1, '2023-01-23'),
(10, 7, 11, '2023-01-26'),
(11, 8, 1, '2023-01-29'),
(12, 9, 5, '2023-02-02'),
(13, 10, 5, '2023-02-06'),
(14, 11, 1, '2023-02-11'),
(15, 11, 10, '2023-02-11');

