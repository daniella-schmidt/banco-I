use nota_fiscal_normalizada;

create function Hello(s char(20))
	returns char(50) deterministic
	return CONCAT('Hello, ',s,'!');
    
select Hello('Daniella');

select Hello (DESC_PRODUTO) from produto where COD_PRODUTO = 2; -- combinando funções

/*---------------------------*/
delimiter $$

create procedure `GetAllProducts`()
begin
-- declaração de variaveis
declare totalSale DEC(10,2) default 0.0;
declare x, y, total, qtd int default 0;

-- atribuição de valores
set total = 10;

select count(*) into qtd from produto;
select qtd;
select * from produto;
end $$

delimiter ;
/*--------------------------*/
call `GetAllProducts`();


/*-----------------------*/
DELIMITER $$

CREATE PROCEDURE `GetProductById`(
    IN pProduct INT, 
    OUT pProductLevel VARCHAR(20)
)
BEGIN
    DECLARE valor DECIMAL(10,2) DEFAULT 0;

    SELECT COUNT(*) INTO valor FROM produto AS p WHERE p.cod_produto = pProduct;

    IF(valor >= 5 AND valor <= 10) THEN
        SET pProductLevel = 'critico';
    ELSEIF (valor > 10 AND valor <= 20) THEN
        SET pProductLevel = 'preocupante';
    ELSEIF (valor > 20) THEN
        SET pProductLevel = 'ok';
    ELSE 
        SET pProductLevel = 'fuja';
    END IF;
END $$

DELIMITER ;
/*-----------------------------*/ 
call GetProductById (1, @teste);
select @teste;