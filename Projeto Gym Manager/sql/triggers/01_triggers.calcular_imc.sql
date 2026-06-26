DELIMITER $$

CREATE TRIGGER trg_calcular_imc
BEFORE INSERT ON avaliacao_fisica
FOR EACH ROW
BEGIN
    IF NEW.altura_cm > 0 THEN
        SET NEW.imc = ROUND(NEW.peso_kg / POWER(NEW.altura_cm / 100, 2), 2);
    END IF;
END$$

DELIMITER ;

INSERT INTO avaliacao_fisica (id_aluno, id_instrutor, data_avaliacao, peso_kg, altura_cm, percentual_gordura, massa_muscular_kg, circunferencia_abdominal, pressao_arterial, fc_repouso)
VALUES (1, 1, '2026-06-25', 62.0, 165.0, 19.0, 47.0, 69.0, '117/77', 63);

SELECT id_avaliacao, peso_kg, altura_cm, imc 
FROM avaliacao_fisica 
WHERE id_aluno = 1 
ORDER BY id_avaliacao DESC 
LIMIT 1;