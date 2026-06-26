DELIMITER $$

CREATE TRIGGER trg_bloquear_reversao_pagamento
BEFORE UPDATE ON pagamento
FOR EACH ROW
BEGIN
    IF OLD.status = 'pago' AND NEW.status != 'pago' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento já efetuado não pode ser revertido.';
    END IF;
END$$

DELIMITER ;

UPDATE pagamento SET status = 'pago' WHERE id_pagamento = 30;
UPDATE pagamento SET status = 'pendente' WHERE id_pagamento = 30;