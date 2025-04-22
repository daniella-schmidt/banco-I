CREATE DATABASE Simposio;
USE Simposio;

CREATE TABLE Pessoa (
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Instituicao VARCHAR(255),
    PRIMARY KEY (Id)
);

CREATE TABLE Simposio (
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Data DATE NOT NULL,
    Local VARCHAR(255) NOT NULL,
    Data_Inicio DATE NOT NULL,
    Data_Fim DATE NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Tema (
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE Organizacao (
    Id INT NOT NULL AUTO_INCREMENT,
    Id_Simposio INT NOT NULL,
    Id_Pessoa INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Simposio) REFERENCES Simposio(Id),
    FOREIGN KEY (Id_Pessoa) REFERENCES Pessoa(Id)
);

CREATE TABLE Comissao (
    Id INT NOT NULL AUTO_INCREMENT,
    Id_Tema INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Tema) REFERENCES Tema(Id),
    UNIQUE (Id_Tema) -- cada tema tenha apenas 1 submissao
);

CREATE TABLE Membro_Comissao (
    Id INT NOT NULL AUTO_INCREMENT,
    Id_Comissao INT NOT NULL,
    Id_Pessoa INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Comissao) REFERENCES Comissao(Id),
    FOREIGN KEY (Id_Pessoa) REFERENCES Pessoa(Id)
);

CREATE TABLE Artigo (
    Id INT NOT NULL AUTO_INCREMENT,
    Titulo VARCHAR(255) NOT NULL,
    Id_Tema INT NOT NULL,
    Data_Submissao DATE NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Tema) REFERENCES Tema(Id)
);

CREATE TABLE Autor (
    Id INT NOT NULL AUTO_INCREMENT,
    Id_Pessoa INT NOT NULL,
    Id_Artigo INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Pessoa) REFERENCES Pessoa(Id),
    FOREIGN KEY (Id_Artigo) REFERENCES Artigo(Id)
);

CREATE TABLE Parecer (
    Id INT NOT NULL AUTO_INCREMENT,
    Id_Artigo INT NOT NULL,
    Id_Comissao INT NOT NULL,
    Status VARCHAR(50) NOT NULL, 
    Descricao VARCHAR(255) NOT NULL,
    Data_Emissao DATE NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Artigo) REFERENCES Artigo(Id),
    FOREIGN KEY (Id_Comissao) REFERENCES Comissao(Id)
);

CREATE TABLE Minicurso (
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Id_Simposio INT NOT NULL,
    Id_Ministrante INT NOT NULL,
    Data DATE NOT NULL,
    Horario TIME NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Simposio) REFERENCES Simposio(Id),
    FOREIGN KEY (Id_Ministrante) REFERENCES Pessoa(Id)
);

CREATE TABLE Palestra (
    Id INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(255) NOT NULL,
    Id_Ministrante INT NOT NULL,
    Id_Simposio INT NOT NULL,
    Data DATE NOT NULL,
    Horario TIME NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Ministrante) REFERENCES Pessoa(Id),
    FOREIGN KEY (Id_Simposio) REFERENCES Simposio(Id)
);

CREATE TABLE Inscricao_Minicurso (
    Id INT NOT NULL AUTO_INCREMENT,
    Id_Inscricao INT NOT NULL,
    Id_Minicurso INT NOT NULL,
    Data_Inscricao DATE NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Inscricao) REFERENCES Pessoa(Id),
    FOREIGN KEY (Id_Minicurso) REFERENCES Minicurso(Id)
);

CREATE TABLE Inscricao_Palestra (
    Id INT NOT NULL AUTO_INCREMENT,
    Id_Inscricao INT NOT NULL,
    Id_Palestra INT NOT NULL,
    Data_Inscricao DATE NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (Id_Inscricao) REFERENCES Pessoa(Id),
    FOREIGN KEY (Id_Palestra) REFERENCES Palestra(Id)
);

DELIMITER //
CREATE TRIGGER prevencao_ministrante_palestra
BEFORE INSERT ON Inscricao_Palestra
FOR EACH ROW
BEGIN
    DECLARE ministrante_id INT;

    -- Buscar o ID do ministrante do palestra
    SELECT Id_Ministrante INTO ministrante_id
    FROM Palestra
    WHERE Id = NEW.Id_Palestra;

    -- Comparar com o ID da pessoa se inscrevendo
    IF NEW.Id_Inscricao = ministrante_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O ministrante não pode se inscrever na própria palestra.';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER prevencao_ministrante_minicurso
BEFORE INSERT ON Inscricao_Minicurso
FOR EACH ROW
BEGIN
    DECLARE ministrante_id INT;

    -- Buscar o ID do ministrante do minicurso
    SELECT Id_Ministrante INTO ministrante_id
    FROM Minicurso
    WHERE Id = NEW.Id_Minicurso;

    -- Comparar com o ID da pessoa se inscrevendo
    IF NEW.Id_Inscricao = ministrante_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O ministrante não pode se inscrever no próprio minicurso.';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER antes_parecer
BEFORE INSERT ON Parecer
FOR EACH ROW
BEGIN
    DECLARE tema_comissao INT;

    -- Obtém o Id_Tema do artigo associado ao parecer
    SELECT Id_Tema INTO tema_comissao
    FROM Artigo
    WHERE Id = NEW.Id_Artigo;

    -- Verifica se o Id_Comissao do parecer corresponde à comissão do tema do artigo
    IF NOT EXISTS (
        SELECT 1
        FROM Comissao
        WHERE Id = NEW.Id_Comissao AND Id_Tema = tema_comissao
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'A comissão do parecer não corresponde ao tema do artigo.';
    END IF;
END //
DELIMITER ;