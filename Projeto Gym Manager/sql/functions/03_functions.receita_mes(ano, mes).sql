DELIMITER $$

CREATE FUNCTION fn_receita_mes(
    p_ano INT,
    p_mes INT
) RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_receita DECIMAL(10,2);
    SELECT COALESCE(SUM(valor), 0)
    INTO v_receita
    FROM pagamento
    WHERE status = 'pago'
      AND YEAR(data_pagamento)  = p_ano
      AND MONTH(data_pagamento) = p_mes;
    RETURN v_receita;
END$$

DELIMITER ;

SELECT fn_receita_mes(2024, 1) AS receita_janeiro,
       fn_receita_mes(2024, 2) AS receita_fevereiro,
       fn_receita_mes(2024, 3) AS receita_marco;