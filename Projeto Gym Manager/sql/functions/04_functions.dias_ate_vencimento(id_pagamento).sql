DELIMITER $$

CREATE FUNCTION fn_dias_ate_vencimento(
    p_id_pagamento INT
) RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_dias INT;
    SELECT DATEDIFF(data_vencimento, CURDATE())
    INTO v_dias
    FROM pagamento
    WHERE id_pagamento = p_id_pagamento;
    RETURN v_dias;
END$$

DELIMITER ;

SELECT
    id_pagamento,
    data_vencimento,
    status,
    fn_dias_ate_vencimento(id_pagamento) AS dias_ate_vencimento
FROM pagamento
WHERE status IN ('pendente', 'atrasado')
ORDER BY data_vencimento ASC;