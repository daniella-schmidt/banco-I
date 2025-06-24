USE Aereo_Nuvem;

INSERT INTO Cliente_status (Nivel, Prioridade_embarque, Descricao, Desconto_porcentual) VALUES
('Cobre', FALSE, 'Cliente básico', 0.00),
('Prata', TRUE, 'Cliente intermediário', 5.00),
('Ouro', TRUE, 'Cliente premium', 10.00);

INSERT INTO Aeronave (Prefixo, Tipo, Total_poltronas) VALUES
('PT-ABC1', 'Boeing 737-800', 186),
('PT-XYZ2', 'Airbus A320', 174),
('PR-GTF', 'Boeing 777-300ER', 396),
('PT-DEF3', 'Embraer E195', 118),
('PR-GTH', 'Airbus A330-300', 293);

INSERT INTO Endereco (Logradouro, Numero, Bairro, Cidade, Estado, CEP, fk_cliente) VALUES
-- Endereços para aeroportos (fk_cliente será NULL)
('Rodovia Hélio Smidt', 1000, 'Cumbica', 'Guarulhos', 'SP', 07190100, NULL),
('Av. Santos Dumont', 1365, 'Centro', 'Rio de Janeiro', 'RJ', 20021130, NULL),
('Rod. Dep. Luis Eduardo Magalhães', 2132, 'Lauro de Freitas', 'Salvador', 'BA', 42599900, NULL),
('BR-116, Km 318', 6000, 'Afonso Pena', 'São José dos Pinhais', 'PR', 83010900, NULL),
('Av. Salgado Filho', 4000, 'Cristo Redentor', 'Porto Alegre', 'RS', 90240001, NULL),
-- Endereços para clientes
('Rua das Flores', 123, 'Centro', 'São Paulo', 'SP', 01310100, NULL),
('Av. Copacabana', 456, 'Copacabana', 'Rio de Janeiro', 'RJ', 22071900, NULL),
('Rua da Bahia', 789, 'Centro', 'Belo Horizonte', 'MG', 30112000, NULL),
('Av. Boa Viagem', 321, 'Boa Viagem', 'Recife', 'PE', 51020000, NULL),
('Rua XV de Novembro', 654, 'Centro', 'Curitiba', 'PR', 80020310, NULL),
('Av. Beira Mar', 987, 'Meireles', 'Fortaleza', 'CE', 60165121, NULL),
('Rua Augusta', 147, 'Consolação', 'São Paulo', 'SP', 01305100, NULL),
('Av. Atlântica', 258, 'Copacabana', 'Rio de Janeiro', 'RJ', 22021001, NULL),
('Rua dos Andradas', 369, 'Centro', 'Porto Alegre', 'RS', 90020007, NULL),
('Av. Paulista', 741, 'Bela Vista', 'São Paulo', 'SP', 01311200, NULL);

INSERT INTO Cliente (Cpf, Nome, Email, Telefone, Data_nasc, Cliente_status, Endereco_atual) VALUES
('12345678901', 'João Silva', 'joao.silva@email.com', '11987654321', '1985-03-15', 1, 6),
('23456789012', 'Maria Oliveira Costa', 'maria.oliveira@email.com', '21987654322', '1990-07-22', 2, 7),
('34567890123', 'Carlos Souza Lima', 'carlos.souza@email.com', '31987654323', '1988-11-08', 3, 8),
('45678901234', 'Ana Paula Ferreira', 'ana.ferreira@email.com', '81987654324', '1992-02-14', 1, 9),
('56789012345', 'Pedro Henrique Alves', 'pedro.alves@email.com', '41987654325', '1987-09-30', 2, 10),
('67890123456', 'Juliana Martins Rocha', 'juliana.martins@email.com', '85987654326', '1995-05-18', 1, 11),
('78901234567', 'Roberto Carlos Silva', 'roberto.carlos@email.com', '11987654327', '1983-12-03', 3, 12),
('89012345678', 'Fernanda Lima Santos', 'fernanda.lima@email.com', '21987654328', '1991-08-25', 2, 13),
('90123456789', 'Marcos Antonio Pereira', 'marcos.pereira@email.com', '51987654329', '1989-04-12', 1, 14),
('01234567890', 'Luciana Barbosa Costa', 'luciana.barbosa@email.com', '11987654330', '1994-10-07', 2, 15);

-- Atualizar endereços com fk_cliente
UPDATE Endereco SET fk_cliente = 1 WHERE Id = 6;
UPDATE Endereco SET fk_cliente = 2 WHERE Id = 7;
UPDATE Endereco SET fk_cliente = 3 WHERE Id = 8;
UPDATE Endereco SET fk_cliente = 4 WHERE Id = 9;
UPDATE Endereco SET fk_cliente = 5 WHERE Id = 10;
UPDATE Endereco SET fk_cliente = 6 WHERE Id = 11;
UPDATE Endereco SET fk_cliente = 7 WHERE Id = 12;
UPDATE Endereco SET fk_cliente = 8 WHERE Id = 13;
UPDATE Endereco SET fk_cliente = 9 WHERE Id = 14;
UPDATE Endereco SET fk_cliente = 10 WHERE Id = 15;

INSERT INTO Aeroporto (Codigo, Nome, fk_endereco, Cidade) VALUES
(2564, 'Aeroporto de Congonhas', 1, 'São Paulo'),
(2567, 'Aeroporto Santos Dumont', 2, 'Rio de Janeiro'),
(2570, 'Aeroporto Internacional de Salvador', 3, 'Salvador'),
(2573, 'Aeroporto Internacional Afonso Pena', 4, 'Curitiba'),
(2576, 'Aeroporto Internacional Salgado Filho', 5, 'Porto Alegre');

-- Poltronas para Boeing 737-800 
INSERT INTO Poltrona (Numero, Classe, Localizacao, Lado, fk_aeronave) VALUES
-- Primeira Classe
('1A', 'Primeira Classe', 'Frente', 'Janela Esquerda', 1),
('1B', 'Primeira Classe', 'Frente', 'Centro Esquerda', 1),
('1C', 'Primeira Classe', 'Frente', 'Centro Direita', 1),
('1D', 'Primeira Classe', 'Frente', 'Janela Direita', 1),
-- Executiva
('2A', 'Executiva', 'Frente', 'Janela Esquerda', 1),
('2B', 'Executiva', 'Frente', 'Centro Esquerda', 1),
('2C', 'Executiva', 'Frente', 'Centro Direita', 1),
('2D', 'Executiva', 'Frente', 'Janela Direita', 1),
('3A', 'Executiva', 'Frente', 'Janela Esquerda', 1),
('3B', 'Executiva', 'Frente', 'Centro Esquerda', 1),
-- Econômica
('10A', 'Econômica', 'Meio', 'Janela Esquerda', 1),
('10B', 'Econômica', 'Meio', 'Centro Esquerda', 1),
('10C', 'Econômica', 'Meio', 'Centro Direita', 1),
('10D', 'Econômica', 'Meio', 'Janela Direita', 1),
('11A', 'Econômica', 'Meio', 'Janela Esquerda', 1),
('11B', 'Econômica', 'Meio', 'Centro Esquerda', 1),
('12A', 'Econômica', 'Meio', 'Janela Esquerda', 1),
('12B', 'Econômica', 'Meio', 'Centro Esquerda', 1),
('13A', 'Econômica', 'Meio', 'Janela Esquerda', 1),
('13B', 'Econômica', 'Meio', 'Centro Esquerda', 1);

-- Poltronas para Airbus A320 
INSERT INTO Poltrona (Numero, Classe, Localizacao, Lado, fk_aeronave) VALUES
('1A', 'Executiva', 'Frente', 'Janela Esquerda', 2),
('1B', 'Executiva', 'Frente', 'Centro', 2),
('1C', 'Executiva', 'Frente', 'Janela Direita', 2),
('2A', 'Executiva', 'Frente', 'Janela Esquerda', 2),
('10A', 'Econômica', 'Meio', 'Janela Esquerda', 2),
('10B', 'Econômica', 'Meio', 'Centro', 2),
('10C', 'Econômica', 'Meio', 'Janela Direita', 2),
('11A', 'Econômica', 'Meio', 'Janela Esquerda', 2),
('11B', 'Econômica', 'Meio', 'Centro', 2),
('12A', 'Econômica', 'Meio', 'Janela Esquerda', 2);

INSERT INTO Voo (Numero, Tipo, Aeroporto_origem, Aeroporto_destino, fk_aeronave, Partida_prog, Chegada_prog, Distancia_km) VALUES
('G31001', 'Doméstico', 2564, 2567, 1, '2025-07-15 08:00:00', '2025-07-15 09:30:00', 365),
('G31002', 'Doméstico', 2567, 2564, 1, '2025-07-15 18:00:00', '2025-07-15 19:30:00', 365),
('G31003', 'Comercial', 2564, 2570, 2, '2025-07-16 10:00:00', '2025-07-16 12:30:00', 1050),
('G31004', 'Comercial', 2570, 2564, 2, '2025-07-16 20:00:00', '2025-07-16 22:30:00', 1050),
('G31005', 'Doméstico', 2564, 2573, 1, '2025-07-17 06:00:00', '2025-07-17 07:15:00', 340),
('G31006', 'Doméstico', 2573, 2576, 2, '2025-07-17 14:00:00', '2025-07-17 15:45:00', 460),
('G31007', 'Comercial', 2576, 2564, 1, '2025-07-18 12:00:00', '2025-07-18 14:15:00', 1100),
('G31008', 'Doméstico', 2567, 2570, 2, '2025-07-18 16:00:00', '2025-07-18 18:00:00', 1200);

INSERT INTO Escala (fk_voo, Partida_prog, Chegada_prog, Codigo_aeroporto) VALUES
(1, '2025-07-15 08:00:00', '2025-07-15 09:30:00', 2564),
(1, '2025-07-15 08:00:00', '2025-07-15 09:30:00', 2567),
(3, '2025-07-16 10:00:00', '2025-07-16 12:30:00', 2564),
(3, '2025-07-16 10:00:00', '2025-07-16 12:30:00', 2570),
(5, '2025-07-17 06:00:00', '2025-07-17 07:15:00', 2564),
(5, '2025-07-17 06:00:00', '2025-07-17 07:15:00', 2573);

-- Reservas para voo G31001 (GRU-SDU)
CALL criar_reserva(1, 1, 1, 'Primeira Classe', 800.00, @codigo1, @msg1);
CALL criar_reserva(2, 1, 11, 'Econômica', 350.00, @codigo2, @msg2);
CALL criar_reserva(3, 1, 12, 'Econômica', 350.00, @codigo3, @msg3);
CALL criar_reserva(4, 1, 13, 'Econômica', 350.00, @codigo4, @msg4);

-- Reservas para voo G31003 (GRU-SSA)
CALL criar_reserva(5, 3, 21, 'Executiva', 600.00, @codigo5, @msg5);
CALL criar_reserva(6, 3, 25, 'Econômica', 450.00, @codigo6, @msg6);
CALL criar_reserva(7, 3, 26, 'Econômica', 450.00, @codigo7, @msg7);

-- Reservas para voo G31005 (GRU-CWB)
CALL criar_reserva(8, 5, 2, 'Primeira Classe', 650.00, @codigo8, @msg8);
CALL criar_reserva(9, 5, 5, 'Executiva', 480.00, @codigo9, @msg9);
CALL criar_reserva(10, 5, 14, 'Econômica', 280.00, @codigo10, @msg10);

-- Reservas adicionais para criar histórico VIP
CALL criar_reserva(1, 2, 15, 'Econômica', 350.00, @codigo11, @msg11);
CALL criar_reserva(1, 7, 16, 'Econômica', 380.00, @codigo12, @msg12);
CALL criar_reserva(3, 4, 27, 'Econômica', 450.00, @codigo13, @msg13);
CALL criar_reserva(3, 6, 28, 'Econômica', 420.00, @codigo14, @msg14);
CALL criar_reserva(7, 8, 29, 'Econômica', 500.00, @codigo15, @msg15);

CALL relatorio_ocupacao_voo(8);
CALL relatorio_ocupacao_voo(2);

-- IDs
CALL relatorio_ocupacao_voo(5);
