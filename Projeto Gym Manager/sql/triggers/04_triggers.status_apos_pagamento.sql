CREATE TABLE pagamento_log (
    id_log          INT      NOT NULL AUTO_INCREMENT,
    id_pagamento    INT      NOT NULL,
    status_anterior VARCHAR(20),
    status_novo     VARCHAR(20),
    alterado_em     DATETIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_log)
);

DELIMITER $$

CREATE TRIGGER trg_log_pagamento
AFTER UPDATE ON pagamento
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO pagamento_log (id_pagamento, status_anterior, status_novo)
        VALUES (NEW.id_pagamento, OLD.status, NEW.status);
    END IF;
END$$

DELIMITER ;

CALL sp_registrar_pagamento(49, 'pix');
SELECT * FROM pagamento_log;