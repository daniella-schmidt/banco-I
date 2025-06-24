use aereo_nuvem;

-- Listar todos os clientes com seus status
SELECT 
    c.Nome as Cliente,
    c.Cpf,
    cs.Nivel as Status,
    cs.Desconto_porcentual as Desconto,
    calcular_idade(c.Data_nasc) as Idade
FROM Cliente c
LEFT JOIN Cliente_status cs ON c.Cliente_status = cs.Id
ORDER BY c.Nome;

-- Listar todos os voos programados
SELECT 
    v.Numero as Voo,
    ao.Cidade as Origem,
    ad.Cidade as Destino,
    v.Partida_prog as Partida,
    v.Chegada_prog as Chegada,
    calcular_duracao_voo(v.Partida_prog, v.Chegada_prog) as Duracao_Horas,
    a.Tipo as Aeronave
FROM Voo v
JOIN Aeroporto ao ON v.Aeroporto_origem = ao.Codigo
JOIN Aeroporto ad ON v.Aeroporto_destino = ad.Codigo
JOIN Aeronave a ON v.fk_aeronave = a.Id
ORDER BY v.Partida_prog;


-- View de reservas detalhadas
SELECT 
    Codigo_reserva,
    Cliente_Nome,
    Cliente_Status,
    Voo_Numero,
    Aeroporto_Origem,
    Aeroporto_Destino,
    Poltrona_Numero,
    Poltrona_Classe,
    Preco_Pago,
    Duracao_Horas
FROM v_reservas_detalhadas
ORDER BY Data_reserva DESC;

-- View de voos completos
SELECT 
    Voo_Numero,
    Cidade_Origem,
    Cidade_Destino,
    Partida_Programada,
    Aeronave_Tipo,
    Capacidade_Total,
    Reservas_Confirmadas,
    Percentual_Ocupacao
FROM v_voos_completos
ORDER BY Percentual_Ocupacao DESC;

-- View de clientes VIP
SELECT 
    Cliente_Nome,
    Status_Atual,
    Total_Viagens,
    Total_Gasto,
    Categoria_VIP,
    Desconto_Sugerido
FROM v_clientes_vip
ORDER BY Total_Viagens DESC;

-- Ranking de aeroportos mais movimentados
SELECT 
    a.Nome as Aeroporto,
    a.Cidade,
    COUNT(DISTINCT vo.Id) + COUNT(DISTINCT vd.Id) as Total_Voos,
    COUNT(DISTINCT vo.Id) as Voos_Origem,
    COUNT(DISTINCT vd.Id) as Voos_Destino
FROM Aeroporto a
LEFT JOIN Voo vo ON a.Codigo = vo.Aeroporto_origem
LEFT JOIN Voo vd ON a.Codigo = vd.Aeroporto_destino
GROUP BY a.Codigo, a.Nome, a.Cidade
ORDER BY Total_Voos DESC;

-- Análise de receita por classe de poltrona
SELECT 
    r.Classe,
    COUNT(*) as Total_Reservas,
    SUM(r.Preco) as Receita_Total,
    AVG(r.Preco) as Preco_Medio,
    MIN(r.Preco) as Menor_Preco,
    MAX(r.Preco) as Maior_Preco
FROM Reserva r
GROUP BY r.Classe
ORDER BY Receita_Total DESC;

-- Clientes com mais reservas
SELECT 
    c.Nome as Cliente,
    cs.Nivel as Status,
    COUNT(r.Id) as Total_Reservas,
    SUM(r.Preco) as Total_Gasto,
    AVG(r.Preco) as Gasto_Medio
FROM Cliente c
JOIN Reserva r ON c.Id = r.fk_cliente
LEFT JOIN Cliente_status cs ON c.Cliente_status = cs.Id
GROUP BY c.Id, c.Nome, cs.Nivel
ORDER BY Total_Reservas DESC, Total_Gasto DESC;

-- Análise de ocupação por aeronave
SELECT 
    a.Tipo as Aeronave,
    a.Prefixo,
    a.Total_poltronas as Capacidade,
    COUNT(r.Id) as Reservas_Totais,
    ROUND((COUNT(r.Id) / (a.Total_poltronas * COUNT(DISTINCT v.Id))) * 100, 2) as Ocupacao_Media
FROM Aeronave a
JOIN Voo v ON a.Id = v.fk_aeronave
LEFT JOIN Reserva r ON v.Id = r.fk_voo
GROUP BY a.Id, a.Tipo, a.Prefixo, a.Total_poltronas
ORDER BY Ocupacao_Media DESC;

-- Voos com maior receita
SELECT 
    v.Numero as Voo,
    ao.Cidade as Origem,
    ad.Cidade as Destino,
    COUNT(r.Id) as Total_Reservas,
    SUM(r.Preco) as Receita_Total,
    AVG(r.Preco) as Preco_Medio
FROM Voo v
JOIN Aeroporto ao ON v.Aeroporto_origem = ao.Codigo
JOIN Aeroporto ad ON v.Aeroporto_destino = ad.Codigo
LEFT JOIN Reserva r ON v.Id = r.fk_voo
GROUP BY v.Id, v.Numero, ao.Cidade, ad.Cidade
HAVING COUNT(r.Id) > 0
ORDER BY Receita_Total DESC;
