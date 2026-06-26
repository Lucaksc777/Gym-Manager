-- Consulta 6: Planos com mais de 3 matrículas (GROUP BY + HAVING)
SELECT
    p.nome           AS plano,
    COUNT(m.id_matricula) AS total_matriculas,
    SUM(m.valor_plano_contratado) AS receita_total
FROM plano p
INNER JOIN matricula m ON p.id_plano = m.id_plano
GROUP BY p.id_plano, p.nome
HAVING COUNT(m.id_matricula) > 3
ORDER BY total_matriculas DESC;