-- JOIN 10: Alunos com ou sem avaliação física (LEFT JOIN)
SELECT
    a.nome                  AS aluno,
    COUNT(af.id_avaliacao)  AS total_avaliacoes,
    MAX(af.data_avaliacao)  AS ultima_avaliacao,
    MAX(af.peso_kg)         AS ultimo_peso
FROM aluno a
LEFT JOIN avaliacao_fisica af ON a.id_aluno = af.id_aluno
GROUP BY a.id_aluno, a.nome
ORDER BY total_avaliacoes DESC;