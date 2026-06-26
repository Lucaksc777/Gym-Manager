-- Consulta 10: Top 3 alunos mais frequentes (LIMIT)
SELECT
    a.nome                          AS aluno,
    COUNT(f.id_frequencia)          AS total_visitas,
    MAX(f.data_hora_entrada)        AS ultima_visita
FROM aluno a
INNER JOIN frequencia f ON a.id_aluno = f.id_aluno
GROUP BY a.id_aluno, a.nome
ORDER BY total_visitas DESC
LIMIT 3;