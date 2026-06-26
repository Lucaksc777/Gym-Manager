DELIMITER $$

CREATE TRIGGER trg_updated_at_aluno
BEFORE UPDATE ON aluno
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END$$

DELIMITER ;

UPDATE aluno SET telefone = '71988888888' WHERE id_aluno = 1;
SELECT id_aluno, nome, telefone, updated_at FROM aluno WHERE id_aluno = 1;