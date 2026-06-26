-- Consulta 4: Ranking de alunos por frequência (COUNT + ORDER BY)
SELECT
    a.nome           AS aluno,
    COUNT(f.id_frequencia) AS total_visitas
FROM aluno a
INNER JOIN frequencia f ON a.id_aluno = f.id_aluno
GROUP BY a.id_aluno, a.nome
ORDER BY total_visitas DESC;