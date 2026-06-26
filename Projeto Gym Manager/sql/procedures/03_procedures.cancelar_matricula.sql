DELIMITER $$

CREATE PROCEDURE sp_cancelar_matricula(
    IN  p_id_matricula INT,
    OUT p_mensagem     VARCHAR(100)
)
BEGIN
    DECLARE v_status VARCHAR(20);

    SELECT status INTO v_status
    FROM matricula
    WHERE id_matricula = p_id_matricula;

    IF v_status = 'cancelada' THEN
        SET p_mensagem = 'Matrícula já está cancelada.';
    ELSE
        START TRANSACTION;

        UPDATE matricula
        SET status = 'cancelada', updated_at = NOW()
        WHERE id_matricula = p_id_matricula;

        UPDATE pagamento
        SET status = 'cancelado'
        WHERE id_matricula = p_id_matricula
          AND status = 'pendente';

        COMMIT;
        SET p_mensagem = 'Matrícula cancelada com sucesso.';
    END IF;
END$$

DELIMITER ; 

CALL sp_cancelar_matricula(31, @msg);
SELECT @msg, (SELECT status FROM matricula WHERE id_matricula = 31);