USE gym_manager;

DELIMITER $$

CREATE FUNCTION fn_calcular_imc(
    peso DECIMAL(5,2),
    altura_cm DECIMAL(5,2)
) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    RETURN ROUND(peso / POWER(altura_cm / 100, 2), 2);
END$$

DELIMITER ;

SELECT fn_calcular_imc(80, 178) AS imc;