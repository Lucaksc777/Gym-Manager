-- Consulta 14: Alunos com pelo menos um pagamento atrasado (subquery)
SELECT
    a.nome          AS aluno,
    a.email,
    a.telefone,
    COUNT(pg.id_pagamento)  AS pagamentos_atrasados,
    SUM(pg.valor)           AS valor_em_atraso
FROM aluno a
INNER JOIN matricula m  ON a.id_aluno     = m.id_aluno
INNER JOIN pagamento pg ON m.id_matricula = pg.id_matricula
WHERE pg.status = 'atrasado'
GROUP BY a.id_aluno, a.nome, a.email, a.telefone
ORDER BY valor_em_atraso DESC;