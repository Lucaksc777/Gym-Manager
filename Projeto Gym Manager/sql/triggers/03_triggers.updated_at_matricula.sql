DELIMITER $$

CREATE TRIGGER trg_status_apos_pagamento
AFTER UPDATE ON pagamento
FOR EACH ROW
BEGIN
    DECLARE v_total     INT;
    DECLARE v_pagos     INT;

    IF NEW.status = 'pago' AND OLD.status != 'pago' THEN
        SELECT COUNT(*) INTO v_total
        FROM pagamento
        WHERE id_matricula = NEW.id_matricula;

        SELECT COUNT(*) INTO v_pagos
        FROM pagamento
        WHERE id_matricula = NEW.id_matricula
          AND status = 'pago';

        IF v_total = v_pagos THEN
            UPDATE matricula
            SET status = 'encerrada', updated_at = NOW()
            WHERE id_matricula = NEW.id_matricula;
        END IF;
    END IF;
END$$

DELIMITER ;
SELECT id_pagamento, status FROM pagamento WHERE id_matricula = 18;

SELECT id_pagamento, status FROM pagamento WHERE id_matricula = 21;
SELECT id_pagamento, status FROM pagamento WHERE id_matricula = 22;

CALL sp_registrar_pagamento(43, 'dinheiro');
SELECT id_pagamento, status FROM pagamento WHERE id_matricula = 22;
SELECT id_matricula, status FROM matricula WHERE id_matricula = 22;