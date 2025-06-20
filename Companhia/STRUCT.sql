CREATE DATABASE IF NOT EXISTS Aereo_nuvem;
USE Aereo_nuvem;

-- Tabela Cliente_status
CREATE TABLE Cliente_status (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nivel ENUM('Cobre', 'Prata', 'Ouro') NOT NULL,
    Prioridade_embarque BOOLEAN,
    Descricao TEXT,  
    Desconto_porcentual DECIMAL(5,2)
);

-- Tabela Aeronave
CREATE TABLE Aeronave (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Prefixo VARCHAR(10) UNIQUE,
    Tipo VARCHAR(200) NOT NULL,
    Total_poltronas INT NOT NULL
);

-- Tabela Endereco (será referenciada por Cliente e Aeroporto)
CREATE TABLE Endereco (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Logradouro VARCHAR(250) NOT NULL,
    Numero INT,
    Bairro VARCHAR(250) NOT NULL,
    Cidade VARCHAR(250) NOT NULL,
    Estado VARCHAR(250) NOT NULL,
    CEP INT NOT NULL,
    fk_cliente INT -- Será preenchida após criar Cliente
);

-- Tabela Cliente
CREATE TABLE Cliente (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Cpf VARCHAR(11) NOT NULL,
    Nome VARCHAR(200) NOT NULL,
    Email VARCHAR(150),
    Telefone VARCHAR(20),
    Data_nasc DATE NOT NULL,
    Cliente_status INT,
    Endereco_atual INT UNIQUE,
    Data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Ativo', 'Inativo') DEFAULT 'Ativo',
    FOREIGN KEY (Endereco_atual) REFERENCES Endereco(Id) ON DELETE CASCADE,
    FOREIGN KEY (Cliente_status) REFERENCES Cliente_status(Id)
);

-- Tabela Aeroporto
CREATE TABLE Aeroporto (
    Codigo INT NOT NULL PRIMARY KEY,
    Nome VARCHAR(250) NOT NULL,
    fk_endereco INT UNIQUE,
    Cidade VARCHAR(50) NOT NULL,
    FOREIGN KEY (fk_endereco) REFERENCES Endereco(Id) ON DELETE CASCADE
);

-- Tabela Poltrona
CREATE TABLE Poltrona (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Numero VARCHAR(5) NOT NULL,
    Classe ENUM('Econômica', 'Executiva', 'Primeira Classe') NOT NULL,
    Localizacao VARCHAR(100) NOT NULL,
    Lado VARCHAR(20) NOT NULL,
    fk_aeronave INT,      
    FOREIGN KEY (fk_aeronave) REFERENCES Aeronave(Id)
);

-- Tabela Voo
CREATE TABLE Voo (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Numero VARCHAR(10) UNIQUE,
    Tipo VARCHAR(100) NOT NULL,
    Aeroporto_origem INT,
    Aeroporto_destino INT,
    fk_aeronave INT,
    Partida_prog DATETIME NOT NULL,
    Chegada_prog DATETIME NOT NULL,
    Partida_real DATETIME,
    Chegada_real DATETIME,
    Distancia_km DECIMAL(10,2),
    FOREIGN KEY (Aeroporto_origem) REFERENCES Aeroporto(Codigo),  
    FOREIGN KEY (Aeroporto_destino) REFERENCES Aeroporto(Codigo),  
    FOREIGN KEY (fk_aeronave) REFERENCES Aeronave(Id)
);

-- Tabela Escala
CREATE TABLE Escala (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_voo INT,
    Partida_prog DATETIME NOT NULL,
    Chegada_prog DATETIME NOT NULL,
    Partida_real DATETIME,
    Chegada_real DATETIME,
    Codigo_aeroporto INT,
    FOREIGN KEY (Codigo_aeroporto) REFERENCES Aeroporto(Codigo),
    FOREIGN KEY (fk_voo) REFERENCES Voo(Id)
);

-- Tabela Reserva
CREATE TABLE Reserva (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Codigo_reserva VARCHAR(10) UNIQUE,
    fk_cliente INT,
    fk_voo INT,
    fk_poltrona INT,
    Classe ENUM('Econômica', 'Executiva', 'Primeira Classe') NOT NULL,
    Preco DECIMAL(10,2) NOT NULL, -- Aumentei precisão para valores maiores
    Data_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_voo) REFERENCES Voo(Id),  
    FOREIGN KEY (fk_cliente) REFERENCES Cliente(Id),
    FOREIGN KEY (fk_poltrona) REFERENCES Poltrona(Id)
);


ALTER TABLE Endereco      
ADD CONSTRAINT fk_endereco_cliente
FOREIGN KEY (fk_cliente) REFERENCES Cliente(Id);
