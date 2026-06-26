-- Consulta 11: Resumo financeiro geral (SUM + COUNT)
SELECT
    SUM(CASE WHEN status = 'pago'     THEN valor ELSE 0 END) AS total_recebido,
    SUM(CASE WHEN status = 'pendente' THEN valor ELSE 0 END) AS total_pendente,
    SUM(CASE WHEN status = 'atrasado' THEN valor ELSE 0 END) AS total_atrasado,
    COUNT(CASE WHEN status = 'atrasado' THEN 1 END)          AS qtd_inadimplentes
FROM pagamento;