USE gym_manager;

-- JOIN 1: Alunos com suas matrículas ativas (INNER JOIN)
SELECT
    a.nome          AS aluno,
    p.nome          AS plano,
    m.data_inicio,
    m.data_fim,
    m.valor_plano_contratado,
    m.status
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN plano p     ON m.id_plano = p.id_plano
WHERE m.status = 'ativa'
ORDER BY a.nome ASC;