DELIMITER $$

CREATE FUNCTION fn_idade_aluno(
    p_id_aluno INT
) RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_idade INT;
    SELECT TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE())
    INTO v_idade
    FROM aluno
    WHERE id_aluno = p_id_aluno;
    RETURN v_idade;
END$$

DELIMITER ;

SELECT nome, fn_idade_aluno(id_aluno) AS idade FROM aluno;