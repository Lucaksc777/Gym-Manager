DELIMITER $$

CREATE FUNCTION fn_status_matricula(
    p_id_aluno INT
) RETURNS VARCHAR(20)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_status VARCHAR(20);
    SELECT status
    INTO v_status
    FROM matricula
    WHERE id_aluno = p_id_aluno
      AND status = 'ativa'
    LIMIT 1;
    IF v_status IS NULL THEN
        SET v_status = 'sem matricula ativa';
    END IF;
    RETURN v_status;
END$$

DELIMITER ;

SELECT
    nome,
    fn_status_matricula(id_aluno) AS situacao
FROM aluno;