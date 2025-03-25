CREATE DATABASE REAL_ESTATE;
USE REAL_ESTATE;

CREATE TABLE if not exists `PROPERTY`(
    `ID` INT PRIMARY KEY auto_increment,
    `NAME` VARCHAR(50) NOT NULL,
    `DESCRIPTION` text,
    `NUM_ROOMS` INT NOT NULL,
    `SALE_PRICE` FLOAT NOT NULL
);

INSERT INTO PROPERTY (NAME, DESCRIPTION, NUM_ROOMS, SALE_PRICE)
VALUES
    ('Apartment in the Center', 'Apartment with sea view', 3, 350000.00),
    ('House in the Countryside', 'Spacious house with garden', 4, 450000.00),
    ('Modern Studio', 'Studio with modern design in the city center', 1, 250000.00),
    ('Cozy Cottage', 'Charming cottage with rustic charm', 2, 300000.00),
    ('Luxury Penthouse', 'Spacious penthouse with panoramic city views', 5, 1200000.00),
    ('Beachfront Villa', 'Villa with private beach access', 6, 1800000.00),
    ('Urban Loft', 'Loft with industrial design and city views', 1, 400000.00),
    ('Country Estate', 'Large estate with open fields and a pond', 7, 2000000.00),
    ('Suburban Townhouse', 'Townhouse in a quiet neighborhood with good schools', 3, 500000.00),
    ('Mountain Cabin', 'Cabin with rustic charm and stunning mountain views', 2, 350000.00);
    
SELECT * FROM PROPERTY WHERE `NAME` <> 'Local';
SELECT * FROM PROPERTY WHERE `SALE_PRICE` >= 2200 AND `SALE_PRICE` < 9000000;
SELECT * FROM PROPERTY WHERE `NUM_ROOMS` = 4;
SELECT * FROM PROPERTY WHERE `SALE_PRICE` BETWEEN 45000 AND 350000;
SELECT * FROM PROPERTY WHERE `NUM_ROOMS` < ANY ( SELECT `NUM_ROOMS` FROM PROPERTY WHERE `NUM_ROOMS` >50);




