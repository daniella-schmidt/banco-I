use ficha_medica;

-- Liste o nome, CPF e data de nascimento de todos os pacientes solteiros, ordenados por nome.
SELECT nome, cpf, data_nascimento 
FROM Paciente 
WHERE id_estado_civil = 1 
ORDER BY nome;

-- "Mostre o nome do paciente, tipo de convênio e telefone para pacientes atendidos pelo convênio 'Unimed' ou 'Amil'."
SELECT p.nome, t.tipo AS convenio, p.telefone 
FROM Paciente p
JOIN Tipo_Convenio t ON p.id_convenio = t.id
WHERE t.tipo IN ('Unimed', 'Amil');

-- Liste todas as consultas com: nome do paciente, nome do médico, especialidade, data da consulta e diagnóstico, para consultas de janeiro de 2023.
SELECT p.nome AS paciente, m.nome AS medico, m.especialidade, c.data, c.diagnostico 
FROM Consultas c
JOIN Paciente p ON c.id_paciente = p.nmr_paciente
JOIN Medico m ON c.id_medico = m.crm
WHERE c.data BETWEEN '2023-01-01' AND '2023-01-31';

-- Conte quantos exames cada médico solicitou, mostrando CRM, nome do médico e total de exames, ordenado pelo maior volume
SELECT m.crm, m.nome, COUNT(e.nrm_exame) AS total_exames
FROM Consultas c
JOIN Medico m ON c.id_medico = m.crm
JOIN Exame e ON c.nmr_consulta = e.nrm_consulta
GROUP BY m.crm, m.nome
ORDER BY total_exames DESC;

-- "Liste pacientes que realizaram exame de 'Ressonância Magnética' ou 'Tomografia Computadorizada', mostrando nome do paciente e data do exame."
SELECT p.nome, e.data
FROM Exame e
JOIN Consultas c ON e.nrm_consulta = c.nmr_consulta
JOIN Paciente p ON c.id_paciente = p.nmr_paciente
WHERE e.tipo_exame IN (
    SELECT id FROM Tipo_Exame 
    WHERE nome IN ('Ressonância Magnética', 'Tomografia Computadorizada')
);

-- Mostre o endereço completo (logradouro, nº, bairro, cidade, UF) de todos os pacientes, incluindo aqueles sem endereço cadastrado
SELECT p.nome, e.logradouro, e.numero, e.bairro, e.cidade, e.estado
FROM Paciente p
LEFT JOIN Enderecos e ON p.id_endereco_atual = e.id;

-- Liste pacientes com mais de 50 anos na data de hoje (08/06/2025), mostrando nome e idade calculada
SELECT nome, TIMESTAMPDIFF(YEAR, data_nascimento, '2025-06-08') AS idade
FROM Paciente
WHERE TIMESTAMPDIFF(YEAR, data_nascimento, '2025-06-08') > 50;

-- Liste todos os exames realizados pelo paciente 'João da Silva', mostrando tipo do exame, data do exame e nome do médico que solicitou.
SELECT te.nome AS tipo_exame, e.data, m.nome AS medico
FROM Exame e
JOIN Consultas c ON e.nrm_consulta = c.nmr_consulta
JOIN Tipo_Exame te ON e.tipo_exame = te.id
JOIN Medico m ON c.id_medico = m.crm
JOIN Paciente p ON c.id_paciente = p.nmr_paciente
WHERE p.nome = 'João da Silva';

-- Qual especialidade médica teve o maior número de consultas? Mostre especialidade e total.
SELECT m.especialidade, COUNT(c.nmr_consulta) AS total_consultas
FROM Consultas c
JOIN Medico m ON c.id_medico = m.crm
GROUP BY m.especialidade
ORDER BY total_consultas DESC
limit 1;