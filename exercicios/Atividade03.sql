CREATE DATABASE Saude_Trabalho;

USE Saude_Trabalho;

CREATE TABLE Funcionarios (
    matricula INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    nacionalidade ENUM('Brasileira', 'Estrangeira') NOT NULL,
    sexo ENUM('Masculino', 'Feminino', 'Outro'),
    estado_civil ENUM('Solteiro', 'Casado', 'Divorciado', 'Viúvo'),
    rg VARCHAR(20) UNIQUE NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_admissao DATE NOT NULL
);
CREATE TABLE Enderecos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    matricula INT NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(9) NOT NULL,
    FOREIGN KEY (matricula) REFERENCES Funcionarios(matricula)
);

CREATE TABLE Departamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    matricula INT NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    departamento_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    FOREIGN KEY (matricula) REFERENCES Funcionarios(matricula)
);

CREATE TABLE Cargos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    matricula INT NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    departamento_id INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    FOREIGN KEY (matricula) REFERENCES Funcionarios(matricula)
);

CREATE TABLE Dependentes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    matricula INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    tipo ENUM('Filho', 'Cônjuge', 'Outro') NOT NULL,
    FOREIGN KEY (matricula) REFERENCES Funcionarios(matricula)
);

INSERT INTO Funcionarios (matricula, nome, data_nascimento, nacionalidade, sexo, estado_civil, rg, cpf, data_admissao)  
VALUES   
(1, 'Carlos Oliveira', '1990-07-15', 'Brasileira', 'Masculino', 'Casado', '123456789', '111.222.333-44', '2020-05-10'), 
(2, 'Fernanda Souza', '1985-09-22', 'Brasileira', 'Feminino', 'Solteiro', '987654321', '444.333.222-11', '2018-02-03');

INSERT INTO Enderecos (matricula, logradouro, numero, complemento, bairro, cidade, estado, cep)
VALUES 
(1, 'Rua das Palmeiras', '120', 'Apto 301', 'Centro', 'São Paulo', 'SP', '01010-000'),
(2, 'Avenida Brasil', '456', NULL, 'Jardim América', 'Rio de Janeiro', 'RJ', '22030-001');

INSERT INTO Cargos (matricula, cargo, departamento_id, data_inicio, data_fim)
VALUES 
(1, 'Analista de Segurança', 1, '2020-05-10', '2023-06-20'),
(2, 'Engenheira de Saúde Ocupacional', 2, '2018-02-03', NULL);

INSERT INTO Dependentes (matricula, nome, data_nascimento, tipo)
VALUES 
(1, 'Pedro Oliveira', '2015-09-10', 'Filho'),
(2, 'Ana Souza', '2017-04-25', 'Filho');

SELECT 
    f.matricula, f.nome, f.data_nascimento, f.nacionalidade, f.sexo, f.estado_civil, 
    f.rg, f.cpf, f.data_admissao, 
    c.cargo, c.data_inicio AS cargo_inicio, c.data_fim AS cargo_fim,
    d.departamento_id AS departamento, d.data_inicio AS departamento_inicio, d.data_fim AS departamento_fim,
    dep.nome AS dependente_nome, dep.data_nascimento AS dependente_nascimento
FROM Funcionarios f
LEFT JOIN Cargos c ON f.matricula = c.matricula
LEFT JOIN Departamento d ON f.matricula = d.matricula
LEFT JOIN Dependentes dep ON f.matricula = dep.matricula;
