-- Consulta 5: Total arrecadado por forma de pagamento (GROUP BY + SUM)
SELECT
    forma_pagamento,
    COUNT(*)        AS quantidade,
    SUM(valor)      AS total_arrecadado
FROM pagamento
WHERE status = 'pago'
GROUP BY forma_pagamento
ORDER BY total_arrecadado DESC;