CREATE VIEW vw_resumo_financeiro AS
SELECT
    MONTH(pg.data_vencimento)   AS mes,
    YEAR(pg.data_vencimento)    AS ano,
    SUM(CASE WHEN pg.status = 'pago'     THEN pg.valor ELSE 0 END) AS total_recebido,
    SUM(CASE WHEN pg.status = 'pendente' THEN pg.valor ELSE 0 END) AS total_pendente,
    SUM(CASE WHEN pg.status = 'atrasado' THEN pg.valor ELSE 0 END) AS total_atrasado
FROM pagamento pg
GROUP BY YEAR(pg.data_vencimento), MONTH(pg.data_vencimento)
ORDER BY ano, mes;

SELECT * FROM vw_resumo_financeiro;