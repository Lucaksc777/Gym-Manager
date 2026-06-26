CREATE VIEW vw_pagamentos_pendentes AS
SELECT
    a.nome              AS aluno,
    a.telefone,
    p.nome              AS plano,
    pg.valor,
    pg.data_vencimento,
    pg.parcela_numero,
    pg.status,
    DATEDIFF(CURDATE(), pg.data_vencimento) AS dias_atraso
FROM pagamento pg
INNER JOIN matricula m ON pg.id_matricula = m.id_matricula
INNER JOIN aluno a     ON m.id_aluno      = a.id_aluno
INNER JOIN plano p     ON m.id_plano      = p.id_plano
WHERE pg.status IN ('pendente', 'atrasado')
ORDER BY pg.data_vencimento ASC;

SELECT * FROM vw_pagamentos_pendentes;