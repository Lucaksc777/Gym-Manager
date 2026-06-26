-- JOIN 3: Treinos ativos com nome do aluno e instrutor (INNER JOIN)
SELECT
    a.nome              AS aluno,
    i.nome              AS instrutor,
    mo.nome             AS modalidade,
    t.nome              AS treino,
    t.objetivo,
    t.nivel,
    t.data_inicio,
    t.data_fim
FROM treino t
INNER JOIN aluno a       ON t.id_aluno      = a.id_aluno
INNER JOIN instrutor i   ON t.id_instrutor  = i.id_instrutor
INNER JOIN modalidade mo ON t.id_modalidade = mo.id_modalidade
WHERE t.ativo = 1
ORDER BY a.nome ASC;