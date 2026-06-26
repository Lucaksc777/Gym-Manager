DELIMITER $$

CREATE PROCEDURE sp_renovar_matricula(
    IN p_id_matricula INT,
    IN p_id_plano_novo INT
)
BEGIN
    DECLARE v_id_aluno     INT;
    DECLARE v_data_fim     DATE;
    DECLARE v_duracao      INT;
    DECLARE v_valor        DECIMAL(10,2);
    DECLARE v_id_nova      INT;

    START TRANSACTION;

    SELECT id_aluno, data_fim
    INTO v_id_aluno, v_data_fim
    FROM matricula
    WHERE id_matricula = p_id_matricula;

    SELECT duracao_meses, valor
    INTO v_duracao, v_valor
    FROM plano
    WHERE id_plano = p_id_plano_novo;

    UPDATE matricula
    SET status = 'encerrada', updated_at = NOW()
    WHERE id_matricula = p_id_matricula;

    INSERT INTO matricula (id_aluno, id_plano, data_inicio, data_fim, valor_plano_contratado, status)
    VALUES (v_id_aluno, p_id_plano_novo, v_data_fim, DATE_ADD(v_data_fim, INTERVAL v_duracao MONTH), v_valor, 'ativa');

    SET v_id_nova = LAST_INSERT_ID();

    CALL sp_gerar_parcelas(v_id_nova, v_duracao, v_valor, v_data_fim);

    COMMIT;
END$$

DELIMITER ;

CALL sp_renovar_matricula(22, 4);
SELECT id_matricula, id_aluno, id_plano, data_inicio, data_fim, status 
FROM matricula 
WHERE id_aluno = 2 
ORDER BY id_matricula;