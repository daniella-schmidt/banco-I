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
    data_admissao DATE NOT NULL,
    id_endereco_atual INT  
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

ALTER TABLE Funcionarios
ADD CONSTRAINT fk_endereco_atual
FOREIGN KEY (id_endereco_atual) REFERENCES Enderecos(id);

CREATE TABLE Departamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
     matricula INT NOT NULL,
    nome_dp VARCHAR(50) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    FOREIGN KEY (matricula) REFERENCES Funcionarios(matricula)
);

CREATE TABLE Cargos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    matricula INT NOT NULL,
    cargo VARCHAR(50) NOT NULL,
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
