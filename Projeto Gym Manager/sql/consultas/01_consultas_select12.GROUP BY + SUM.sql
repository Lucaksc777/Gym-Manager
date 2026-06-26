-- Consulta 12: Receita arrecadada por plano (GROUP BY + SUM)
SELECT
    p.nome                              AS plano,
    COUNT(m.id_matricula)               AS total_matriculas,
    SUM(pg.valor)                       AS receita_total,
    AVG(pg.valor)                       AS ticket_medio
FROM plano p
INNER JOIN matricula m  ON p.id_plano      = m.id_plano
INNER JOIN pagamento pg ON m.id_matricula  = pg.id_matricula
WHERE pg.status = 'pago'
GROUP BY p.id_plano, p.nome
ORDER BY receita_total DESC;