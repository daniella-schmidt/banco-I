USE SimposioDB;

-- 1. Quantas pessoas estão inscritas em cada minicurso?
SELECT 
    m.Nome AS Nome_Minicurso,
    COUNT(im.Id_Inscricao) AS Total_Inscritos
FROM Minicurso m
LEFT JOIN Inscricao_Minicurso im ON m.Id = im.Id_Minicurso
GROUP BY m.Id, m.Nome
ORDER BY Total_Inscritos DESC;

-- 2. Quantos artigos foram aprovados por tema?
SELECT 
    t.Nome AS Nome_Tema,
    COUNT(a.Id) AS Total_Artigos_Aprovados
FROM Tema t
INNER JOIN Artigo a ON t.Id = a.Id_Tema
INNER JOIN Parecer p ON a.Id = p.Id_Artigo
WHERE p.Descricao LIKE '%Aprovado%'
GROUP BY t.Id, t.Nome
HAVING Total_Artigos_Aprovados > 0
ORDER BY Total_Artigos_Aprovados DESC;

-- 3. Número total de inscrições no simpósio e número de pessoas que se inscreveram em minicursos e palestras
SELECT 
    COUNT(i.Id) AS Total_Inscricoes_Simposio,
    COUNT(DISTINCT im.Id_Inscricao) AS Inscricoes_Minicursos,
    COUNT(DISTINCT ip.Id_Inscricao) AS Inscricoes_Palestras
FROM Inscricao i
LEFT JOIN Inscricao_Minicurso im ON i.Id = im.Id_Inscricao
LEFT JOIN Inscricao_Palestra ip ON i.Id = ip.Id_Inscricao
WHERE i.Id_Simposio = 1;

-- 4. Quem são os ministrantes com mais minicursos e palestras combinados?
SELECT 
    p.Nome AS Nome_Ministrante,
    COUNT(DISTINCT m.Id) AS Total_Minicursos,
    COUNT(DISTINCT pl.Id) AS Total_Palestras,
    (COUNT(DISTINCT m.Id) + COUNT(DISTINCT pl.Id)) AS Total_Atividades
FROM Pessoa p
LEFT JOIN Minicurso m ON p.Id = m.Id_Ministrante
LEFT JOIN Palestra pl ON p.Id = pl.Id_Ministrante
GROUP BY p.Id, p.Nome
ORDER BY Total_Atividades DESC
LIMIT 5;

-- 5. Quantos autores cada artigo possui?
SELECT 
    a.Titulo AS Titulo_Artigo,
    COUNT(au.Id_Pessoa) AS Total_Autores
FROM Artigo a
LEFT JOIN Autor au ON a.Id = au.Id_Artigo
GROUP BY a.Id, a.Titulo
ORDER BY Total_Autores DESC;

-- 6. Qual é o tema com mais artigos submetidos e qual a média de artigos por tema?
SELECT 
    t.Nome AS Nome_Tema,
    COUNT(a.Id) AS Total_Artigos,
    (SELECT AVG(artigos_por_tema) 
     FROM (SELECT COUNT(Id) AS artigos_por_tema 
           FROM Artigo 
           GROUP BY Id_Tema) AS subquery) AS Media_Artigos_Por_Tema
FROM Tema t
LEFT JOIN Artigo a ON t.Id = a.Id_Tema
GROUP BY t.Id, t.Nome
ORDER BY Total_Artigos DESC;

-- 7. Quais pessoas estão inscritas em mais minicursos e palestras combinados?
SELECT 
    p.Nome AS Nome_Pessoa,
    COUNT(DISTINCT im.Id_Minicurso) AS Total_Minicursos,
    COUNT(DISTINCT ip.Id_Palestra) AS Total_Palestras,
    (COUNT(DISTINCT im.Id_Minicurso) + COUNT(DISTINCT ip.Id_Palestra)) AS Total_Atividades
FROM Pessoa p
INNER JOIN Inscricao i ON p.Id = i.Id_Pessoa
LEFT JOIN Inscricao_Minicurso im ON i.Id = im.Id_Inscricao
LEFT JOIN Inscricao_Palestra ip ON i.Id = ip.Id_Inscricao
GROUP BY p.Id, p.Nome
ORDER BY Total_Atividades DESC;

-- 8. Qual é o parecer mais recente por artigo?
SELECT 
    a.Titulo AS Titulo_Artigo,
    p.Nome AS Nome_Parecer,
    p.Descricao AS Descricao_Parecer,
    MAX(p.Id) AS Id_Parecer_Mais_Recente
FROM Artigo a
INNER JOIN Parecer p ON a.Id = p.Id_Artigo
GROUP BY a.Id, a.Titulo
ORDER BY Id_Parecer_Mais_Recente DESC;

-- 9. Quantas pessoas estão na organização e também na comissão?
SELECT 
    COUNT(DISTINCT o.Id_Pessoa) AS Pessoas_Organizacao_E_Comissao
FROM Organizacao o
INNER JOIN Comissao c ON o.Id_Pessoa = c.Id_CP
WHERE o.Id_Simposio = 1;

-- 10. Qual é o número de artigos por autor e o autor com mais artigos?
SELECT 
    p.Nome AS Nome_Autor,
    COUNT(au.Id_Artigo) AS Total_Artigos,
    MAX(COUNT(au.Id_Artigo)) OVER () AS Maior_Numero_Artigos
FROM Pessoa p
INNER JOIN Autor au ON p.Id = au.Id_Pessoa
GROUP BY p.Id, p.Nome
ORDER BY Total_Artigos DESC;
