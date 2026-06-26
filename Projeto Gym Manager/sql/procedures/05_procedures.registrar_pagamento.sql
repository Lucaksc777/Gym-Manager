DROP PROCEDURE IF EXISTS sp_registrar_pagamento;

DELIMITER $$

CREATE PROCEDURE sp_registrar_pagamento(
    IN p_id_pagamento   INT,
    IN p_forma          VARCHAR(20)
)
BEGIN
    DECLARE v_status VARCHAR(20);

    SELECT status INTO v_status
    FROM pagamento
    WHERE id_pagamento = p_id_pagamento;

    IF v_status = 'pago' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento já foi efetuado.';
    ELSEIF v_status = 'cancelado' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento cancelado não pode ser efetivado.';
    ELSE
        UPDATE pagamento
        SET status          = 'pago',
            data_pagamento  = CURDATE(),
            forma_pagamento = p_forma
        WHERE id_pagamento = p_id_pagamento;
    END IF;
END$$

DELIMITER ;

CALL sp_registrar_pagamento(38, 'pix');
SELECT id_pagamento, status, data_pagamento, forma_pagamento 
FROM pagamento 
WHERE id_pagamento = 38;