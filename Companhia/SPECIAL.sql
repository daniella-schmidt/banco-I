USE Aereo_Nuvem;

-- =============================================
-- FUNÇÕES
-- =============================================

-- Função para calcular duração do voo em horas
DELIMITER //
CREATE FUNCTION calcular_duracao_voo(partida DATETIME, chegada DATETIME) 
RETURNS DECIMAL(5,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(MINUTE, partida, chegada) / 60.0;
END //
DELIMITER ;

-- Função para calcular idade (necessária para a view)
DELIMITER //
CREATE FUNCTION calcular_idade(data_nascimento DATE) 
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE());
END //
DELIMITER ;

-- Função para aplicar desconto baseado no tipo de cliente
DELIMITER //
CREATE FUNCTION aplicar_desconto(preco_original DECIMAL(10,2), cliente_id INT) 
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE desconto DECIMAL(5,2) DEFAULT 0;
    
    SELECT COALESCE(cs.Desconto_porcentual, 0) INTO desconto
    FROM Cliente c
    LEFT JOIN Cliente_status cs ON c.Cliente_status = cs.Id
    WHERE c.Id = cliente_id;
    
    RETURN preco_original * (1 - desconto/100);
END //
DELIMITER ;

-- Função para verificar disponibilidade de poltrona (simplificada)
DELIMITER //
CREATE FUNCTION verificar_disponibilidade_poltrona(poltrona_id INT, voo_id INT) 
RETURNS BOOLEAN
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE disponivel BOOLEAN DEFAULT TRUE;
    DECLARE reservas_existentes INT DEFAULT 0;
    
    -- Verificar se a poltrona já está reservada para este voo
    SELECT COUNT(*) INTO reservas_existentes
    FROM Reserva 
    WHERE fk_poltrona = poltrona_id AND fk_voo = voo_id;
    
    SET disponivel = (reservas_existentes = 0);
    
    RETURN disponivel;
END //
DELIMITER ;

-- =============================================
-- PROCEDIMENTOS ARMAZENADOS
-- =============================================

-- Procedimento para criar uma nova reserva (adaptado)
DELIMITER //
CREATE PROCEDURE criar_reserva(
    IN p_cliente_id INT,
    IN p_voo_id INT,
    IN p_poltrona_id INT,
    IN p_classe VARCHAR(50),
    IN p_preco DECIMAL(10,2),
    OUT p_codigo_reserva VARCHAR(10),
    OUT p_mensagem VARCHAR(255)
)
BEGIN
    DECLARE v_disponivel BOOLEAN DEFAULT FALSE;
    DECLARE v_preco_final DECIMAL(10,2);
    DECLARE v_codigo VARCHAR(10);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_mensagem = 'Erro ao criar reserva';
        SET p_codigo_reserva = NULL;
    END;
    
    START TRANSACTION;
    
    -- Verificar disponibilidade da poltrona
    SET v_disponivel = verificar_disponibilidade_poltrona(p_poltrona_id, p_voo_id);
    
    IF NOT v_disponivel THEN
        SET p_mensagem = 'Poltrona não disponível - já está reservada para este voo';
        SET p_codigo_reserva = NULL;
        ROLLBACK;
    ELSE
        -- Aplicar desconto
        SET v_preco_final = aplicar_desconto(p_preco, p_cliente_id);
        
        -- Gerar código de reserva
        SET v_codigo = CONCAT('R', LPAD(FLOOR(RAND() * 999999), 6, '0'));
        
        -- Criar reserva
        INSERT INTO Reserva (Codigo_reserva, fk_cliente, fk_voo, fk_poltrona, Classe, Preco)
        VALUES (v_codigo, p_cliente_id, p_voo_id, p_poltrona_id, p_classe, v_preco_final);
        
        SET p_codigo_reserva = v_codigo;
        SET p_mensagem = 'Reserva criada com sucesso';
        COMMIT;
    END IF;
END //
DELIMITER ;

-- Procedimento para cancelar reserva (simplificado)
DELIMITER //
CREATE PROCEDURE cancelar_reserva(
    IN p_codigo_reserva VARCHAR(10),
    OUT p_mensagem VARCHAR(255)
)
BEGIN
    DECLARE v_reserva_id INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_mensagem = 'Erro ao cancelar reserva';
    END;
    
    START TRANSACTION;
    
    -- Verificar se a reserva existe
    SELECT Id INTO v_reserva_id
    FROM Reserva
    WHERE Codigo_reserva = p_codigo_reserva;
    
    IF v_reserva_id IS NULL THEN
        SET p_mensagem = 'Reserva não encontrada';
        ROLLBACK;
    ELSE
        -- Cancelar reserva (simplesmente deletar o registro)
        DELETE FROM Reserva WHERE Codigo_reserva = p_codigo_reserva;
        
        SET p_mensagem = 'Reserva cancelada com sucesso';
        COMMIT;
    END IF;
END //
DELIMITER ;

-- Procedimento para relatório de ocupação de voos
DELIMITER //
CREATE PROCEDURE relatorio_ocupacao_voo(IN p_voo_id INT)
BEGIN
    SELECT 
        v.Numero as Voo,
        v.Tipo as Tipo_Voo,
        ao.Nome as Aeroporto_Origem,
        ad.Nome as Aeroporto_Destino,
        a.Tipo as Aeronave,
        a.Total_poltronas as Total_Poltronas,
        COUNT(r.Id) as Poltronas_Reservadas,
        (a.Total_poltronas - COUNT(r.Id)) as Poltronas_Disponiveis,
        ROUND((COUNT(r.Id) / a.Total_poltronas) * 100, 2) as Percentual_Ocupacao
    FROM Voo v
    JOIN Aeroporto ao ON v.Aeroporto_origem = ao.Codigo
    JOIN Aeroporto ad ON v.Aeroporto_destino = ad.Codigo
    JOIN Aeronave a ON v.fk_aeronave = a.Id
    LEFT JOIN Reserva r ON v.Id = r.fk_voo
    WHERE v.Id = p_voo_id
    GROUP BY v.Id, v.Numero, v.Tipo, ao.Nome, ad.Nome, a.Tipo, a.Total_poltronas;
END //
DELIMITER ;

-- Procedimento para listar poltronas disponíveis em um voo
DELIMITER //
CREATE PROCEDURE listar_poltronas_disponiveis(IN p_voo_id INT)
BEGIN
    SELECT 
        p.Id as Poltrona_ID,
        p.Numero as Poltrona_Numero,
        p.Classe as Poltrona_Classe,
        p.Localizacao as Poltrona_Localizacao,
        a.Tipo as Aeronave_Tipo
    FROM Voo v
    JOIN Aeronave a ON v.fk_aeronave = a.Id
    JOIN Poltrona p ON a.Id = p.fk_aeronave
    WHERE v.Id = p_voo_id
    AND p.Id NOT IN (
        SELECT r.fk_poltrona 
        FROM Reserva r 
        WHERE r.fk_voo = p_voo_id
    )
    ORDER BY p.Classe, p.Numero;
END //
DELIMITER ;

-- =============================================
-- TRIGGERS
-- =============================================

-- Trigger para gerar código de reserva automaticamente
DELIMITER //
CREATE TRIGGER gerar_codigo_reserva
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    IF NEW.Codigo_reserva IS NULL OR NEW.Codigo_reserva = '' THEN
        SET NEW.Codigo_reserva = CONCAT('R', LPAD(FLOOR(RAND() * 999999), 6, '0'));
    END IF;
END //
DELIMITER ;

-- Trigger para validar data de voo (não pode ser no passado)
DELIMITER //
CREATE TRIGGER validar_data_voo
BEFORE INSERT ON Voo
FOR EACH ROW
BEGIN
    IF NEW.Partida_prog < NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de partida não pode ser no passado';
    END IF;
    
    IF NEW.Chegada_prog <= NEW.Partida_prog THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de chegada deve ser posterior à partida';
    END IF;
END //
DELIMITER ;

-- Trigger para verificar capacidade máxima da aeronave
DELIMITER //
CREATE TRIGGER verificar_capacidade_aeronave
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    DECLARE v_total_poltronas INT;
    DECLARE v_reservas_existentes INT;
    
    -- Buscar total de poltronas da aeronave do voo
    SELECT a.Total_poltronas INTO v_total_poltronas
    FROM Voo v
    JOIN Aeronave a ON v.fk_aeronave = a.Id
    WHERE v.Id = NEW.fk_voo;
    
    -- Contar reservas existentes para o voo
    SELECT COUNT(*) INTO v_reservas_existentes
    FROM Reserva r
    WHERE r.fk_voo = NEW.fk_voo;
    
    -- Verificar se ultrapassou capacidade
    IF v_reservas_existentes >= v_total_poltronas THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Capacidade máxima da aeronave atingida';
    END IF;
END //
DELIMITER ;

-- Trigger para verificar se poltrona já está reservada no mesmo voo
DELIMITER //
CREATE TRIGGER verificar_poltrona_duplicada
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    DECLARE v_reservas_existentes INT;
    
    -- Verificar se a poltrona já está reservada para este voo
    SELECT COUNT(*) INTO v_reservas_existentes
    FROM Reserva r
    WHERE r.fk_poltrona = NEW.fk_poltrona AND r.fk_voo = NEW.fk_voo;
    
    IF v_reservas_existentes > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Poltrona já está reservada para este voo';
    END IF;
END //
DELIMITER ;

-- Trigger para validar se poltrona pertence à aeronave do voo
DELIMITER //
CREATE TRIGGER validar_poltrona_aeronave
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    DECLARE v_aeronave_voo INT;
    DECLARE v_aeronave_poltrona INT;
    
    -- Buscar aeronave do voo
    SELECT fk_aeronave INTO v_aeronave_voo
    FROM Voo
    WHERE Id = NEW.fk_voo;
    
    -- Buscar aeronave da poltrona
    SELECT fk_aeronave INTO v_aeronave_poltrona
    FROM Poltrona
    WHERE Id = NEW.fk_poltrona;
    
    -- Verificar se coincidem
    IF v_aeronave_voo != v_aeronave_poltrona THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Poltrona não pertence à aeronave deste voo';
    END IF;
END //
DELIMITER ;

-- =============================================
-- VIEWS
-- =============================================

-- View para reservas detalhadas
CREATE VIEW v_reservas_detalhadas AS
SELECT 
    r.Id as Reserva_ID,
    r.Codigo_reserva,
    c.Nome as Cliente_Nome,
    c.Cpf as Cliente_CPF,
    calcular_idade(c.Data_nasc) as Cliente_Idade,
    cs.Nivel as Cliente_Status,
    v.Numero as Voo_Numero,
    v.Tipo as Voo_Tipo,
    ao.Nome as Aeroporto_Origem,
    ad.Nome as Aeroporto_Destino,
    v.Partida_prog as Data_Partida,
    v.Chegada_prog as Data_Chegada,
    calcular_duracao_voo(v.Partida_prog, v.Chegada_prog) as Duracao_Horas,
    p.Numero as Poltrona_Numero,
    p.Classe as Poltrona_Classe,
    p.Localizacao as Poltrona_Localizacao,
    r.Preco as Preco_Pago,
    r.Data_reserva,
    CASE 
        WHEN v.Partida_prog > NOW() THEN 'Ativa'
        WHEN v.Partida_prog <= NOW() AND v.Chegada_prog > NOW() THEN 'Em Andamento'
        ELSE 'Finalizada'
    END as Status_Reserva
FROM Reserva r
JOIN Cliente c ON r.fk_cliente = c.Id
LEFT JOIN Cliente_status cs ON c.Cliente_status = cs.Id
JOIN Voo v ON r.fk_voo = v.Id
JOIN Aeroporto ao ON v.Aeroporto_origem = ao.Codigo
JOIN Aeroporto ad ON v.Aeroporto_destino = ad.Codigo
JOIN Poltrona p ON r.fk_poltrona = p.Id;

-- View para voos com informações completas
CREATE VIEW v_voos_completos AS
SELECT 
    v.Id as Voo_ID,
    v.Numero as Voo_Numero,
    v.Tipo as Voo_Tipo,
    ao.Nome as Aeroporto_Origem,
    ao.Cidade as Cidade_Origem,
    ad.Nome as Aeroporto_Destino,
    ad.Cidade as Cidade_Destino,
    v.Partida_prog as Partida_Programada,
    v.Chegada_prog as Chegada_Programada,
    v.Partida_real as Partida_Real,
    v.Chegada_real as Chegada_Real,
    calcular_duracao_voo(v.Partida_prog, v.Chegada_prog) as Duracao_Programada_Horas,
    v.Distancia_km,
    a.Tipo as Aeronave_Tipo,
    a.Prefixo as Aeronave_Prefixo,
    a.Total_poltronas as Capacidade_Total,
    COUNT(r.Id) as Reservas_Confirmadas,
    (a.Total_poltronas - COUNT(r.Id)) as Poltronas_Disponiveis,
    ROUND((COUNT(r.Id) / a.Total_poltronas) * 100, 2) as Percentual_Ocupacao,
    CASE 
        WHEN v.Partida_prog > NOW() THEN 'Agendado'
        WHEN v.Partida_prog <= NOW() AND v.Chegada_prog > NOW() THEN 'Em Voo'
        WHEN v.Chegada_prog <= NOW() AND v.Chegada_real IS NOT NULL THEN 'Finalizado'
        WHEN v.Chegada_prog <= NOW() AND v.Chegada_real IS NULL THEN 'Atrasado'
        ELSE 'Indefinido'
    END as Status_Voo
FROM Voo v
JOIN Aeroporto ao ON v.Aeroporto_origem = ao.Codigo
JOIN Aeroporto ad ON v.Aeroporto_destino = ad.Codigo
JOIN Aeronave a ON v.fk_aeronave = a.Id
LEFT JOIN Reserva r ON v.Id = r.fk_voo
GROUP BY v.Id, v.Numero, v.Tipo, ao.Nome, ao.Cidade, ad.Nome, ad.Cidade, 
         v.Partida_prog, v.Chegada_prog, v.Partida_real, v.Chegada_real, 
         v.Distancia_km, a.Tipo, a.Prefixo, a.Total_poltronas;

-- View para clientes VIP (baseado em número de viagens)
CREATE VIEW v_clientes_vip AS
SELECT 
    c.Id as Cliente_ID,
    c.Nome as Cliente_Nome,
    c.Cpf as Cliente_CPF,
    c.Email as Cliente_Email,
    c.Telefone as Cliente_Telefone,
    calcular_idade(c.Data_nasc) as Idade,
    cs.Nivel as Status_Atual,
    cs.Desconto_porcentual as Desconto_Atual,
    COUNT(r.Id) as Total_Viagens,
    SUM(r.Preco) as Total_Gasto,
    AVG(r.Preco) as Gasto_Medio_Por_Viagem,
    MAX(r.Data_reserva) as Ultima_Reserva,
    CASE 
        WHEN COUNT(r.Id) >= 20 THEN 'VIP Platinum'
        WHEN COUNT(r.Id) >= 10 THEN 'VIP Gold'
        WHEN COUNT(r.Id) >= 5 THEN 'VIP Silver'
        ELSE 'Cliente Regular'
    END as Categoria_VIP,
    CASE 
        WHEN COUNT(r.Id) >= 20 THEN 25.00
        WHEN COUNT(r.Id) >= 10 THEN 15.00
        WHEN COUNT(r.Id) >= 5 THEN 10.00
        ELSE 0.00
    END as Desconto_Sugerido
FROM Cliente c
LEFT JOIN Cliente_status cs ON c.Cliente_status = cs.Id
LEFT JOIN Reserva r ON c.Id = r.fk_cliente
WHERE c.Status = 'Ativo'
GROUP BY c.Id, c.Nome, c.Cpf, c.Email, c.Telefone, c.Data_nasc, cs.Nivel, cs.Desconto_porcentual
HAVING COUNT(r.Id) >= 3 -- Apenas clientes com 3+ viagens
ORDER BY Total_Viagens DESC, Total_Gasto DESC;

-- View para análise de ocupação por rota
CREATE VIEW v_ocupacao_por_rota AS
SELECT 
    CONCAT(ao.Cidade, ' → ', ad.Cidade) as Rota,
    COUNT(DISTINCT v.Id) as Total_Voos,
    SUM(a.Total_poltronas) as Total_Poltronas_Oferecidas,
    COUNT(r.Id) as Total_Reservas,
    ROUND((COUNT(r.Id) / SUM(a.Total_poltronas)) * 100, 2) as Taxa_Ocupacao_Media,
    SUM(r.Preco) as Receita_Total,
    AVG(r.Preco) as Preco_Medio_Passagem
FROM Voo v
JOIN Aeroporto ao ON v.Aeroporto_origem = ao.Codigo
JOIN Aeroporto ad ON v.Aeroporto_destino = ad.Codigo
JOIN Aeronave a ON v.fk_aeronave = a.Id
LEFT JOIN Reserva r ON v.Id = r.fk_voo
GROUP BY ao.Cidade, ad.Cidade
ORDER BY Taxa_Ocupacao_Media DESC;