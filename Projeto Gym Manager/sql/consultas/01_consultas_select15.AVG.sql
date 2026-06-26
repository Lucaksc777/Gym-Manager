-- Consulta 15: Média de idade dos alunos por plano (AVG + GROUP BY)
SELECT
    p.nome                                          AS plano,
    COUNT(a.id_aluno)                               AS total_alunos,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, a.data_nascimento, CURDATE())), 1) AS media_idade
FROM plano p
INNER JOIN matricula m ON p.id_plano   = m.id_plano
INNER JOIN aluno a     ON m.id_aluno   = a.id_aluno
WHERE m.status = 'ativa'
GROUP BY p.id_plano, p.nome
ORDER BY media_idade DESC;