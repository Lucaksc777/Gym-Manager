USE gym_manager;

CREATE VIEW vw_alunos_ativos AS
SELECT
    a.id_aluno,
    a.nome,
    a.email,
    a.telefone,
    p.nome          AS plano,
    m.data_inicio,
    m.data_fim,
    m.valor_plano_contratado
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN plano p     ON m.id_plano = p.id_plano
WHERE m.status = 'ativa'
ORDER BY a.nome ASC;

SELECT * FROM vw_alunos_ativos;