-- Consulta 3: Pagamentos vencidos entre duas datas (BETWEEN)
SELECT
    p.id_pagamento,
    a.nome           AS aluno,
    p.valor,
    p.data_vencimento,
    p.data_pagamento,
    p.status
FROM pagamento p
INNER JOIN matricula m ON p.id_matricula = m.id_matricula
INNER JOIN aluno a     ON m.id_aluno = a.id_aluno
WHERE p.data_vencimento BETWEEN '2024-01-01' AND '2024-06-30'
ORDER BY p.data_vencimento ASC;