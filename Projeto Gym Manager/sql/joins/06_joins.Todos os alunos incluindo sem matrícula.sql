-- JOIN 6: Todos os alunos incluindo os sem matrícula (LEFT JOIN)
SELECT
    a.nome              AS aluno,
    a.status,
    m.id_matricula,
    p.nome              AS plano,
    m.status            AS status_matricula
FROM aluno a
LEFT JOIN matricula m ON a.id_aluno = m.id_aluno
LEFT JOIN plano p     ON m.id_plano = p.id_plano
ORDER BY a.nome ASC;