-- JOIN 9: Todas as modalidades incluindo as sem alunos vinculados (LEFT JOIN)
SELECT
    mo.nome                 AS modalidade,
    mo.capacidade_maxima,
    COUNT(f.id_frequencia)  AS total_frequencias
FROM modalidade mo
LEFT JOIN frequencia f ON mo.id_modalidade = f.id_modalidade
GROUP BY mo.id_modalidade, mo.nome, mo.capacidade_maxima
ORDER BY total_frequencias DESC;