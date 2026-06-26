DELIMITER $$

CREATE PROCEDURE sp_gerar_parcelas(
    IN p_id_matricula INT,
    IN p_duracao      INT,
    IN p_valor        DECIMAL(10,2),
    IN p_data_inicio  DATE
)
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= p_duracao DO
        INSERT INTO pagamento (id_matricula, valor, data_vencimento, status, parcela_numero)
        VALUES (p_id_matricula, p_valor, DATE_ADD(p_data_inicio, INTERVAL i MONTH), 'pendente', i);
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;