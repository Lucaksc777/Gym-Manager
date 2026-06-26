DELIMITER $$

CREATE FUNCTION fn_calcular_mensalidade(
    p_id_plano INT
) RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_valor DECIMAL(10,2);
    SELECT valor
    INTO v_valor
    FROM plano
    WHERE id_plano = p_id_plano;
    RETURN v_valor;
END$$

DELIMITER ;

SELECT
    nome        AS plano,
    fn_calcular_mensalidade(id_plano) AS mensalidade
FROM plano;