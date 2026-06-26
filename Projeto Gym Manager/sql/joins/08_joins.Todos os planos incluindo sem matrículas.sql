-- JOIN 8: Todos os planos incluindo os sem matrículas (LEFT JOIN)
SELECT
    p.nome              AS plano,
    p.valor,
    COUNT(m.id_matricula) AS total_matriculas
FROM plano p
LEFT JOIN matricula m ON p.id_plano = m.id_plano
GROUP BY p.id_plano, p.nome, p.valor
ORDER BY total_matriculas DESC;