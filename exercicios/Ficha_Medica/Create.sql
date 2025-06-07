CREATE DATABASE FICHA_MEDICA;
USE FICHA_MEDICA;

CREATE TABLE Nacionalidade (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Sexo (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE Estado_Civil (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE Tipo_Convenio (
    id INTEGER PRIMARY KEY,
    tipo VARCHAR(100) NOT NULL
);

CREATE TABLE Enderecos (
    id INTEGER PRIMARY KEY,
    paciente INTEGER NOT NULL,
    logradouro VARCHAR(200) NOT NULL,
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL
);

CREATE TABLE Paciente (
    nmr_paciente INTEGER PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    data_nascimento DATE NOT NULL,
    id_nacionalidade INTEGER,
    id_sexo INTEGER,
    id_estado_civil INTEGER,
    rg VARCHAR(20) UNIQUE,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20),
    id_endereco_atual INTEGER,
    id_convenio INTEGER,
    FOREIGN KEY (id_nacionalidade) REFERENCES Nacionalidade(id),
    FOREIGN KEY (id_sexo) REFERENCES Sexo(id),
    FOREIGN KEY (id_estado_civil) REFERENCES Estado_Civil(id),
    FOREIGN KEY (id_convenio) REFERENCES Tipo_Convenio(id),
    FOREIGN KEY (id_endereco_atual) REFERENCES Enderecos(id)
);

ALTER TABLE Enderecos
ADD CONSTRAINT fk_endereco_paciente
FOREIGN KEY (paciente) REFERENCES Paciente(nmr_paciente);

CREATE TABLE Medico (
    crm INTEGER PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    especialidade VARCHAR(100) NOT NULL
);

CREATE TABLE Consultas (
    nmr_consulta INTEGER PRIMARY KEY,
    data DATE NOT NULL,
    id_medico INTEGER NOT NULL,
    id_paciente INTEGER NOT NULL,
    diagnostico TEXT,
    FOREIGN KEY (id_medico) REFERENCES Medico(crm),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(nmr_paciente)
);

CREATE TABLE Tipo_Exame (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Exame (
    nrm_exame INTEGER PRIMARY KEY,
    nrm_consulta INTEGER NOT NULL,
    tipo_exame INTEGER NOT NULL,
    data DATE NOT NULL,
    FOREIGN KEY (nrm_consulta) REFERENCES Consultas(nmr_consulta),
    FOREIGN KEY (tipo_exame) REFERENCES Tipo_Exame(id)
);

CREATE INDEX idx_paciente_nome ON Paciente(nome);
CREATE INDEX idx_paciente_cpf ON Paciente(cpf);
CREATE INDEX idx_consulta_data ON Consultas(data);
CREATE INDEX idx_consulta_paciente ON Consultas(id_paciente);
CREATE INDEX idx_consulta_medico ON Consultas(id_medico);
CREATE INDEX idx_exame_consulta ON Exame(nrm_consulta);
CREATE INDEX idx_endereco_paciente ON Enderecos(paciente);