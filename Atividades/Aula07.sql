USE nota_fiscal_normalizada;

DELIMITER $$

CREATE TRIGGER promo_check
BEFORE UPDATE ON produto
FOR EACH ROW 
BEGIN
    DECLARE nome VARCHAR(255);

    SELECT desc_produto INTO nome FROM produto 
    WHERE cod_produto = NEW.cod_produto;
        
    IF NEW.vl_produto < 100 THEN
        SET NEW.desc_produto = CONCAT('promoção ', nome);
    ELSEIF NEW.vl_produto >= 100 AND 
           NEW.vl_produto <= 200 THEN 
        SET NEW.desc_produto = CONCAT('oferta ', nome);
    END IF;
END $$

DELIMITER ;

UPDATE produto SET vl_produto = 85 WHERE cod_produto IN (1, 2);