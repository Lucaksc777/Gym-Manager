DELIMITER $$

CREATE PROCEDURE sp_ativar_matricula(
    IN p_id_aluno    INT,
    IN p_id_plano    INT,
    IN p_data_inicio DATE
)
BEGIN
    DECLARE v_duracao      INT;
    DECLARE v_valor        DECIMAL(10,2);
    DECLARE v_id_matricula INT;
    DECLARE v_data_fim     DATE;

    START TRANSACTION;

    SELECT duracao_meses, valor
    INTO v_duracao, v_valor
    FROM plano
    WHERE id_plano = p_id_plano;

    SET v_data_fim = DATE_ADD(p_data_inicio, INTERVAL v_duracao MONTH);

    INSERT INTO matricula (id_aluno, id_plano, data_inicio, data_fim, valor_plano_contratado, status)
    VALUES (p_id_aluno, p_id_plano, p_data_inicio, v_data_fim, v_valor, 'ativa');

    SET v_id_matricula = LAST_INSERT_ID();

    CALL sp_gerar_parcelas(v_id_matricula, v_duracao, v_valor, p_data_inicio);

    COMMIT;
END$$

DELIMITER ;

CALL sp_ativar_matricula(1, 1, '2025-01-01');
SELECT * FROM matricula WHERE id_aluno = 1 ORDER BY id_matricula DESC LIMIT 1;